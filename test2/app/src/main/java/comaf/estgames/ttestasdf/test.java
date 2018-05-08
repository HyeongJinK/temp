package comaf.estgames.ttestasdf;

import android.support.multidex.MultiDexApplication;

import com.estgames.estgames_framework.core.Configuration;
import com.estgames.estgames_framework.core.PlatformContext;
import com.estgames.estgames_framework.core.session.SessionRepository;

import org.jetbrains.annotations.NotNull;

/**
 * Created by mp on 2018. 5. 8..
 */

class test extends MultiDexApplication implements PlatformContext {
    private Configuration mpCfg;
    private String mpDeviceId;
    private SessionRepository mpSessionRepository;

    @Override
    public Configuration getConfiguration() {
        return null;
    }

    @Override
    public Configuration getCongifuration() {
        return this.mpCfg;
    }

    @Override
    public String getDeviceId() {
        return this.mpDeviceId;
    }

    @Override
    public SessionRepository getSessionRepository() {
        return this.mpSessionRepository;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        //initializeAws();
        initializeMp();

    }

    private void initializeMp() {
        this.mpCfg = new Configuration(getApplicationContext());
//        this.mpDeviceId = AndroidUtils.obtainDeviceId(getApplicationContext()) + "@android";
//        this.mpSessionRepository = new PreferenceSessionRepository(getApplicationContext());
    }
}

