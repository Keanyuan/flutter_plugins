package anjiplus.aj_flutter_update;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** AjFlutterUpdatePlugin */
public class AjFlutterUpdatePlugin implements MethodCallHandler {
  private static Registrar registrar;
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    AjFlutterUpdatePlugin.registrar = registrar;
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "aj_flutter_update");
    channel.setMethodCallHandler(new AjFlutterUpdatePlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("apkinstallMethod")) {
      Object parameter = call.arguments();
      if (parameter instanceof Map) {
        String value = (String) ((Map) parameter).get("path");
        VersionUpdateInstaller.installApk(registrar.activity().getApplication(), value);
      }
      //版本更新
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else {
      result.notImplemented();
    }
  }
}
