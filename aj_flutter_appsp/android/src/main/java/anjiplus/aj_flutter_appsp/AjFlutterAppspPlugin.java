package anjiplus.aj_flutter_appsp;

import android.app.Activity;
import android.app.Application;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.widget.Toast;

import com.anji.appsp.sdk.AppSpConfig;
import com.anji.appsp.sdk.AppSpLog;
import com.anji.appsp.sdk.IAppSpNoticeCallback;
import com.anji.appsp.sdk.IAppSpVersionUpdateCallback;
import com.anji.appsp.sdk.model.AppSpNoticeModel;
import com.anji.appsp.sdk.model.AppSpUpdateModel;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.google.gson.Gson;

import java.util.Map;

/**
 * AjFlutterAppSpPlugin
 */
public class AjFlutterAppspPlugin implements MethodCallHandler {
    private static Registrar registrar;

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        AjFlutterAppspPlugin.registrar = registrar;
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "aj_flutter_appsp");
        channel.setMethodCallHandler(new AjFlutterAppspPlugin());
    }

    // MethodChannel.Result wrapper that responds on the platform thread.
    private static class MethodResultWrapper implements MethodChannel.Result {
        private MethodChannel.Result methodResult;
        private Handler handler;

        MethodResultWrapper(MethodChannel.Result result) {
            methodResult = result;
            handler = new Handler(Looper.getMainLooper());
        }

        @Override
        public void success(final Object result) {
            handler.post(
                    new Runnable() {
                        @Override
                        public void run() {
                            methodResult.success(result);
                        }
                    });
        }

        @Override
        public void error(
                final String errorCode, final String errorMessage, final Object errorDetails) {
            AppSpLog.d("Test error  ");
            handler.post(
                    new Runnable() {
                        @Override
                        public void run() {
                            methodResult.error(errorCode, errorMessage, errorDetails);
                        }
                    });
        }

        @Override
        public void notImplemented() {
            handler.post(
                    new Runnable() {
                        @Override
                        public void run() {
                            methodResult.notImplemented();
                        }
                    });
        }
    }

    private void checkVersion(String appKey, final MethodResultWrapper resultWrapper) {
        AppSpConfig.getInstance().init(registrar.activity(), appKey);
        AppSpConfig.getInstance().setVersionUpdateCallback(new IAppSpVersionUpdateCallback() {
            @Override
            public void update(AppSpUpdateModel updateModel) {
                AppSpLog.d("Test updateModel is " + updateModel);
                if (updateModel == null) {
                    resultWrapper.notImplemented();
                } else {
                    //先转成json
                    resultWrapper.success(new Gson().toJson(updateModel));
                }

            }
        });
    }

    private void checkNotice(String appKey, final MethodResultWrapper resultWrapper) {
        AppSpConfig.getInstance().init(registrar.activity(), appKey);
        AppSpConfig.getInstance().setNoticeCallback(new IAppSpNoticeCallback() {
            @Override
            public void notice(AppSpNoticeModel noticeModel) {
                AppSpLog.d("Test noticeModel is " + noticeModel);

                if (noticeModel == null) {
                    resultWrapper.notImplemented();
                } else {
                    //先转成json
                    resultWrapper.success(new Gson().toJson(noticeModel));
                }

            }
        });
    }

    MethodChannel.Result resultWrapper;

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        MethodResultWrapper resultWrapper = new MethodResultWrapper(result);
        if (call.method.equals("getUpdateModel")) {
            String appkey = null;
            Object parameter = call.arguments();

            if (parameter instanceof Map) {
                appkey = (String) ((Map) parameter).get("appKey");
                checkVersion(appkey, resultWrapper);
            }
        } else if (call.method.equals("getNoticeModel")) {
            String appkey = null;
            Object parameter = call.arguments();

            if (parameter instanceof Map) {
                appkey = (String) ((Map) parameter).get("appKey");
                checkNotice(appkey, resultWrapper);
            }
        } else if (resultWrapper != null) {
            resultWrapper.notImplemented();
        }
    }
}
