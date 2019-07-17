package anjiplus.aj.flutter.aj_flutter_scan;

import android.content.Intent;
import android.util.Log;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.zbar.lib.CaptureActivity;

/**
 * AjFlutterScanPlugin
 */
public class AjFlutterScanPlugin implements MethodCallHandler {
    private static Registrar registrar;
    private static Result result;
    private static int requestCode = 0x22;

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        AjFlutterScanPlugin.registrar = registrar;
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "aj_flutter_scan");
        channel.setMethodCallHandler(new AjFlutterScanPlugin());
        AjFlutterScanPlugin.registrar.addActivityResultListener(new PluginRegistry.ActivityResultListener() {
            @Override
            public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
                if (AjFlutterScanPlugin.requestCode == requestCode
                        && resultCode == 1) {
                    if (result != null) {
                        String barcode = data.getStringExtra("resultCode");
                        result.success(barcode);
                    }
                } else if (AjFlutterScanPlugin.requestCode == requestCode
                        && resultCode == 0104) {
                    if (result != null) {
                        String errorCode = data.getStringExtra("resultCode");
                        result.error(errorCode, null, null);
                    }
                }
                return AjFlutterScanPlugin.requestCode == requestCode;
            }
        });
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("getBarCode")) {
            AjFlutterScanPlugin.result = result;
            Intent intent = new Intent(registrar.activity(), CaptureActivity.class);
            registrar.activity().startActivityForResult(intent, requestCode);
        } else {
            result.notImplemented();
        }
    }
}
