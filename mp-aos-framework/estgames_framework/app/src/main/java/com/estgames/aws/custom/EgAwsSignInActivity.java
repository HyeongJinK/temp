package com.estgames.aws.custom;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.amazonaws.mobile.auth.ui.AuthUIConfiguration;
import com.amazonaws.mobile.auth.ui.SignInActivity;
import com.amazonaws.mobile.auth.ui.SignInView;
import com.estgames.estgames_framework.R;

public class EgAwsSignInActivity extends SignInActivity {

    /** Log Tag. */
    private static final String LOG_TAG = EgAwsSignInActivity.class.getSimpleName();


    /**
     * Key for Background Color.
     */
    static final String CONFIG_KEY_SIGN_IN_BACKGROUND_COLOR = "signInBackgroundColor";

    /**
     * Key for global Font across all the SignIn views and its subviews.
     */
    static final String CONFIG_KEY_FONT_FAMILY = "fontFamily";

    /**
     * Key for Enabling background color full screen.
     */
    static final String CONFIG_KEY_FULL_SCREEN_BACKGROUND = "fullScreenBackgroundColor";

    @Override
    protected void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.eg_aws_custom_sign_in);
    }

    /**
     * Start the SignInActivity that kicks off the authentication flow
     * by initializing the SignInManager.
     *
     * @param context The context from which the SignInActivity will be started
     * @param config  Reference to AuthUIConfiguration object
     */
    public static void startSignInActivity(final Context context,
                                           final AuthUIConfiguration config) {
        try {
            Intent intent = new Intent(context, EgAwsSignInActivity.class);
            intent.putExtra(SignInView.CONFIGURATION_KEY, config);
            intent.putExtra(CONFIG_KEY_SIGN_IN_BACKGROUND_COLOR,
                    config.getSignInBackgroundColor(SignInView.DEFAULT_BACKGROUND_COLOR));
            intent.putExtra(CONFIG_KEY_FONT_FAMILY,
                    config.getFontFamily());
            intent.putExtra(CONFIG_KEY_FULL_SCREEN_BACKGROUND,
                    config.isBackgroundColorFullScreen());
            context.startActivity(intent);
        } catch (Exception exception) {
            Log.e(LOG_TAG, "Cannot start the SignInActivity. "
                    + "Check the context and the configuration object passed in.", exception);
        }
    }

    /**
     * Start the SignInActivity that kicks off the authentication flow
     * by initializing the SignInManager.
     *
     * @param context The context from which the SignInActivity will be started
     */
    public static void startSignInActivity(final Context context) {
        try {
            Intent intent = new Intent(context, EgAwsSignInActivity.class);
            context.startActivity(intent);
        } catch (Exception exception) {
            Log.e(LOG_TAG, "Cannot start the SignInActivity. "
                    + "Check the context passed in.", exception);
        }
    }
}
