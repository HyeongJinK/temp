package comaf.estgames.ttestasdf;

import android.support.multidex.MultiDexApplication;

import com.estgames.estgames_framework.core.AwsPlatformContext;
import com.estgames.estgames_framework.core.Configuration;
import com.estgames.estgames_framework.core.PlatformContext;
import com.estgames.estgames_framework.core.session.SessionRepository;

public class Application extends MultiDexApplication implements PlatformContext {
    private PlatformContext delegateContext;

    @Override
    public Configuration getConfiguration() {
        return delegateContext.getConfiguration();
    }

    @Override
    public String getDeviceId() {
        return delegateContext.getDeviceId();
    }

    @Override
    public SessionRepository getSessionRepository() {
        return delegateContext.getSessionRepository();
    }

    @Override
    public void onCreate() {
        super.onCreate();
        this.delegateContext = new AwsPlatformContext(getApplicationContext());
    }
}
