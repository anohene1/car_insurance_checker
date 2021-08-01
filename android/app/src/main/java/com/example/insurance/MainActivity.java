package com.example.insurance;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import androidx.annotation.NonNull;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import com.hover.sdk.api.Hover;
import com.hover.sdk.api.HoverParameters;
import android.app.Activity;




import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.anohene.insurance";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine){
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("hoverStartTransaction")) {
                                String action_id = call.argument("action_id");
                                String  number = call.argument("number");

                                Intent i = new HoverParameters.Builder(this)
                                        .request(action_id)
                                        .extra("licenseNumber", number) // Only if your action has variables
                                        .setHeader("Getting Insurance Data")
                                        .initialProcessingMessage("Please wait...")
                                        .buildIntent();
                                startActivityForResult(i, 0);

                            } else if(call.method.equals("hoverInitial")) {
                                Hover.initialize(this);
                                Hover.setBranding("Car Insurance Checker", android.R.color.transparent, this);
                            }
                            else {
                                result.notImplemented();
                            }
                        }
                );
    }
}
