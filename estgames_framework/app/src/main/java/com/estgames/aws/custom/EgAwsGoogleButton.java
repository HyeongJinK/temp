package com.estgames.aws.custom;

import android.content.Context;
import android.graphics.Color;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.util.AttributeSet;
import android.util.Log;
import android.util.TypedValue;

import com.amazonaws.mobile.auth.core.signin.SignInManager;
import com.amazonaws.mobile.auth.core.signin.ui.buttons.SignInButton;
import com.amazonaws.mobile.auth.core.signin.ui.buttons.SignInButtonAttributes;
import com.amazonaws.mobile.auth.google.GoogleButton;
import com.amazonaws.mobile.auth.google.GoogleSignInProvider;

import static com.amazonaws.mobile.auth.core.signin.ui.DisplayUtils.dp;

public class EgAwsGoogleButton extends SignInButton {

    /** Log tag. */
    private static final String LOG_TAG = GoogleButton.class.getSimpleName();

    /** Button corner radius. */
    private static final int CORNER_RADIUS = 4;

    /** Button background color. */
    private static final int GOOGLE_BACKGROUND_COLOR = Color.WHITE;

    /** Button background color when pressed. */
    private static final int GOOGLE_BACKGROUND_COLOR_PRESSED = Color.LTGRAY;

    /** Text Color. */
    private static final int TEXT_COLOR = Color.DKGRAY;

    /** Button top shadow color. */
    private static final int BUTTON_TOP_SHADOW_COLOR = 0xFFCCCCCC;

    /** Button top shadow thickness in pixels. */
    private static final int BUTTON_TOP_SHADOW_THICKNESS = (int) dp(1);

    /** Button bottom shadow thickness in pixels. */
    private static final int BUTTON_BOTTOM_SHADOW_THICKNESS = (int) dp(1);

    /** Max text size in pixels for EG Framework. */
    private static final int EG_TEXT_SIZE_MAX_PX = dp(20);

    /**
     * Constructor.
     * @param context The activity context
     */
    public EgAwsGoogleButton(@NonNull final Context context) {
        this(context, null);
    }

    /**
     * Constructor.
     * @param context The activity context
     * @param attrs The AttributeSet passed in by the application
     */
    public EgAwsGoogleButton(@NonNull final Context context,
                        @Nullable final AttributeSet attrs) {
        this(context, attrs, 0);
    }

    /**
     * Constructor.
     * @param context The activity context
     * @param attrs The AttributeSet passed in by the application
     * @param defStyleAttr The default style attribute
     */
    public EgAwsGoogleButton(@NonNull final Context context,
                        @Nullable final AttributeSet attrs,
                        final int defStyleAttr) {
        super(context, attrs, defStyleAttr,
                new SignInButtonAttributes()
                        .withCornerRadius(CORNER_RADIUS)
                        .withBackgroundColor(GOOGLE_BACKGROUND_COLOR)
                        .withBackgroundColorPressed(GOOGLE_BACKGROUND_COLOR_PRESSED)
                        .withTextColor(TEXT_COLOR)
//                        .withDefaultTextResourceId(com.amazonaws.mobile.auth.google.R.string.default_google_button_text)
                        .withDefaultTextResourceId(com.estgames.estgames_framework.R.string.aws_sign_button_google)
                        .withImageIconResourceId(com.amazonaws.mobile.auth.google.R.drawable.google_icon)
                        .withTopShadowColor(BUTTON_TOP_SHADOW_COLOR)
                        .withTopShadowThickness(BUTTON_TOP_SHADOW_THICKNESS)
                        .withBottomShadowThickness(BUTTON_BOTTOM_SHADOW_THICKNESS)
        );

        if (isInEditMode()) {
            return;
        }

        try {
            final SignInManager signInManager = SignInManager.getInstance();
            signInManager.initializeSignInButton(GoogleSignInProvider.class, this);
        } catch (Exception exception) {
            exception.printStackTrace();
            Log.e(LOG_TAG, "Cannot initialize the SignInButton. Please check if IdentityManager :"
                    + " startUpAuth and setUpToAuthenticate are invoked");
        }

    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
        textView.setTextSize(TypedValue.COMPLEX_UNIT_PX, EG_TEXT_SIZE_MAX_PX);
    }
}
