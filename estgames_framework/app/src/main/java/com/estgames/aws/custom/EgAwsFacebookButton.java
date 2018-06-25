package com.estgames.aws.custom;

import android.content.Context;
import android.graphics.Color;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.util.AttributeSet;
import android.util.Log;

import com.amazonaws.mobile.auth.core.signin.SignInManager;
import com.amazonaws.mobile.auth.core.signin.ui.buttons.SignInButton;
import com.amazonaws.mobile.auth.core.signin.ui.buttons.SignInButtonAttributes;
import com.amazonaws.mobile.auth.facebook.FacebookButton;
import com.amazonaws.mobile.auth.facebook.FacebookSignInProvider;

import static com.amazonaws.mobile.auth.core.signin.ui.DisplayUtils.dp;

public class EgAwsFacebookButton extends SignInButton {

    /** Log tag. */
    private static final String LOG_TAG = FacebookButton.class.getSimpleName();

    /** Button corner radius. */
    private static final int CORNER_RADIUS = dp(4);

    /** Button background color. */
    private static final int FB_BACKGROUND_COLOR = 0xFF3C5C95;

    /** Button background color when pressed. */
    private static final int FB_BACKGROUND_COLOR_PRESSED = 0xFF2D4570;

    /** Button top shadow color. */
    private static final int BUTTON_TOP_SHADOW_COLOR = 0xFFCCCCCC;

    /** Button top shadow thickness in pixels. */
    private static final int BUTTON_TOP_SHADOW_THICKNESS = (int) dp(0);

    /** Button bottom shadow thickness in pixels. */
    private static final int BUTTON_BOTTOM_SHADOW_THICKNESS = (int) dp(0);

    /**
     * Constructor.
     * @param context context.
     */
    public EgAwsFacebookButton(@NonNull final Context context) {
        this(context, null);
    }

    /**
     * Constructor.
     * @param context context.
     * @param attrs attribute set.
     */
    public EgAwsFacebookButton(@NonNull final Context context,
                          @Nullable final AttributeSet attrs) {
        this(context, attrs, 0);
    }

    /**
     * Constructor.
     * @param context context.
     * @param attrs attribute set.
     * @param defStyleAttr default style attribute.
     */
    public EgAwsFacebookButton(@NonNull final Context context,
                          @Nullable final AttributeSet attrs,
                          final int defStyleAttr) {
        super(context, attrs, defStyleAttr,
                new SignInButtonAttributes()
                        .withCornerRadius(CORNER_RADIUS)
                        .withBackgroundColor(FB_BACKGROUND_COLOR)
                        .withBackgroundColorPressed(FB_BACKGROUND_COLOR_PRESSED)
                        .withTextColor(Color.WHITE)
                        .withDefaultTextResourceId(com.amazonaws.mobile.auth.facebook.R.string.default_facebook_button_text)
                        .withImageIconResourceId(com.amazonaws.mobile.auth.facebook.R.drawable.facebook_icon)
                        .withTopShadowColor(BUTTON_TOP_SHADOW_COLOR)
                        .withTopShadowThickness(BUTTON_TOP_SHADOW_THICKNESS)
                        .withBottomShadowThickness(BUTTON_BOTTOM_SHADOW_THICKNESS)
        );


        if (isInEditMode()) {
            return;
        }

        try {
            final SignInManager signInManager = SignInManager.getInstance();
            signInManager.initializeSignInButton(FacebookSignInProvider.class, this);
        } catch (Exception exception) {
            exception.printStackTrace();
            Log.e(LOG_TAG, "Cannot initialize the SignInButton. Please check if IdentityManager : "
                    + " startUpAuth and setUpToAuthenticate are invoked");
        }
    }
}
