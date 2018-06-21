package com.estgames.estgames_framework.banner;

import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.ImageView;

import com.estgames.estgames_framework.R;
import com.estgames.estgames_framework.common.Action;
import com.estgames.estgames_framework.common.Banner;
import com.estgames.estgames_framework.core.HttpResponse;
import com.estgames.estgames_framework.core.HttpUtils;
import com.estgames.estgames_framework.core.Method;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by mp on 2018. 1. 24..
 */

public class BannerDialog extends Dialog {
    private BannerCacheRepository cache;
    private BannerDialogHandler handler;

    private BannerChain bannerChain;

    public BannerDialog(Context context, List<Banner> banners, BannerCacheRepository repository)  {
        super(context, android.R.style.Theme_NoTitleBar_Fullscreen);
        cache = repository;

        bannerChain = new BannerChain(this);

        for (Banner b: banners) {
            String type = b.getContentType().toLowerCase();
            if (type.contains("text/html")) {
                bannerChain.add(new WebBannerView(this, b));
            } else {
                bannerChain.add(new ImageBannerView(this, b));
            }
        }
    }

    public void setDialogHandler(BannerDialogHandler h) {
        handler = h;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.banner);

        // Banner View Layer 초기화. 처음 배너창이 열릴때는 모두 가려져 있어야 함.
        findViewById(R.id.web_banner_view).setVisibility(View.GONE);
        findViewById(R.id.img_banner_view).setVisibility(View.GONE);

        findViewById(R.id.btn_link_action).setOnClickListener(new View.OnClickListener() {
            @Override public void onClick(View v) {
                bannerChain.action();
            }
        });

        findViewById(R.id.btn_dismiss).setOnClickListener(new View.OnClickListener() {
            @Override public void onClick(View v) {
                bannerChain.close();
            }
        });

        ((CheckBox)findViewById(R.id.chk_hide_for_a_day)).setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                cache.setHideOnToday(bannerChain.getBannerName(), b);
            }
        });

        setOnDismissListener(new OnDismissListener() {
            @Override public void onDismiss(DialogInterface dialogInterface) {
                handler.onDialogClosed();
            }
        });

        bannerChain.open();
    }

    private abstract class BannerView {
        protected BannerDialog context;
        private String bannerName;

        BannerView(BannerDialog ctx, String banner) {
            context = ctx;
            bannerName = banner;
        }

        abstract void open();
        abstract void action();
        abstract void close();

        String getBannerName() {
            return bannerName;
        }
    }

    private class ImageBannerView extends BannerView {
        private String resource;
        private String buttonName;
        private String actionType;
        private String actionTarget;

        private Bitmap cache;

        ImageBannerView(BannerDialog ctx, Banner b) {
            super(ctx, b.getName());
            resource = b.getResource();

            Action action = b.getAction();
            if (action instanceof Action.WebView) {
                actionType = "WEB_VIEW";
                actionTarget = ((Action.WebView) action).getUrl();
                buttonName = ((Action.WebView) action).getButton();
            } else if (action instanceof Action.WebBrowser) {
                actionType = "WEB_BROWSER";
                actionTarget = ((Action.WebBrowser) action).getUrl();
                buttonName = ((Action.WebBrowser) action).getButton();
            }
        }

        @Override void open() {
            if (buttonName != null) {
                context.findViewById(R.id.btn_link_action).setVisibility(View.VISIBLE);
                ((Button) context.findViewById(R.id.btn_link_action)).setText(buttonName);
            } else {
                context.findViewById(R.id.btn_link_action).setVisibility(View.INVISIBLE);
            }

            context.findViewById(R.id.img_banner_view).setVisibility(View.VISIBLE);
            if (cache != null) {
                ((ImageView)context.findViewById(R.id.img_banner_view)).setImageBitmap(cache);
            } else {
                try {
                    ExecutorService executor = Executors.newSingleThreadExecutor();
                    cache = executor.submit(new Callable<Bitmap>() {
                        @Override public Bitmap call() throws Exception {
                            HttpResponse res = HttpUtils.request(resource, Method.GET);
                            return BitmapFactory.decodeStream(res.getInputStream());
                        }
                    }).get();
                    executor.shutdown();

                    ((ImageView)context.findViewById(R.id.img_banner_view)).setImageBitmap(cache);
                } catch (InterruptedException e) {
                } catch (ExecutionException e) {
                    // error Image 를 보여줘야 함.
                    e.printStackTrace();
                }
            }
        }

        @Override void action() {
            if (actionTarget != null) {
                Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(actionTarget));
                context.getContext().startActivity(intent);
            }
        }

        @Override void close() {
            context.findViewById(R.id.img_banner_view).setVisibility(View.GONE);
        }
    }

    private class WebBannerView extends BannerView {
        private String resource;
        private WebView view;

        WebBannerView(BannerDialog ctx, Banner b) {
            super(ctx, b.getName());
            resource = b.getResource();
        }

        @Override void open() {
            context.findViewById(R.id.btn_link_action).setVisibility(View.INVISIBLE);

            view = context.findViewById(R.id.web_banner_view);
            view.setVisibility(View.VISIBLE);
            view.getSettings().setJavaScriptEnabled(true);
            view.setWebViewClient(new WebViewClient() {
                @Override
                public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                    return super.shouldOverrideUrlLoading(view, request);
                }
            });
            view.loadUrl(resource);

        }
        @Override void action() { }
        @Override void close() {
            view.setVisibility(View.GONE);
        }
    }

    private class BannerChain extends BannerView {
        private List<BannerView> banners = new ArrayList();
        private int index = 0;

        BannerChain(BannerDialog ctx) { super(ctx, null); }

        @Override void open() {
            if (index < banners.size()) {
                banners.get(index).open();
                ((CheckBox)context.findViewById(R.id.chk_hide_for_a_day)).setChecked(false);
            }
        }

        @Override void action() {
            banners.get(index).action();
        }

        @Override void close() {
            banners.get(index).close();
            if (++index >= banners.size()) {
                context.dismiss();
            } else {
                open();
            }
        }

        @Override String getBannerName() {
            return banners.get(index).getBannerName();
        }

        void add(BannerView banner) {
            banners.add(banner);
        }
    }
}
