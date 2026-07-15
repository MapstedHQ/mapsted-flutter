package com.mapsted;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import androidx.appcompat.app.AppCompatActivity;

import com.google.gson.Gson;

import org.json.JSONException;
import org.json.JSONObject;

import com.mapsted.ui.map.MapstedMapActivity;
import com.mapsted.ui.CustomParams;
import java.util.Map;

public class MapstedFlutterPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {

    private MethodChannel channel;
    private ActivityPluginBinding activityBinding;
    private AppCompatActivity activity;


    // Constants
    private static final String SET_CUSTOM_PARAMS_JSON = "Set_Custom_Params_Json";

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "mapsted_flutter");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("launchMapActivity")) {
            launchMapActivity(call.arguments(), result);
        } else {
            result.notImplemented();
        }
    }

    private CustomParams getCustomParams(Context context, boolean enableSelection, boolean showOnLaunch) {
        return (CustomParams) CustomParams.newBuilder((AppCompatActivity) context)
        .setEnablePropertyListSelection(true)
        .setShowPropertyListOnMapLaunch(true)
        .build();
    }

    private void launchMapActivity(Object arguments, Result result) {
        if (activityBinding != null && activityBinding.getActivity() != null) {
            try {
                
            // Convert Map to CustomParams using Gson
            Gson gson = new Gson();
        
            CustomParams customParams = getCustomParams(activity, true, true);

            // Create intent for MapstedMapActivity
            Intent intent = new Intent(activityBinding.getActivity(), MapstedMapActivity.class);

            // Convert CustomParams back to JSON and put into Bundle
            String customParamsJson = new Gson().toJson(customParams);
            Bundle bundle = new Bundle();
            bundle.putString(SET_CUSTOM_PARAMS_JSON, customParamsJson);
            intent.putExtras(bundle);

            // Start activity with the intent
            activityBinding.getActivity().startActivity(intent);

            // Notify success
            result.success(null);
            } catch (Exception e) {
                // Notify error if JSON parsing fails
                result.error("JSON_ERROR", e.getMessage(), null);
            }
        } else {
            // Notify error if activity is not available
            result.error("NO_ACTIVITY", "Activity is not available", null);
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activityBinding = binding;
        this.activity = (AppCompatActivity) binding.getActivity();

    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        activityBinding = null;
        this.activity = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        activityBinding = binding;
        this.activity = (AppCompatActivity) binding.getActivity();
    }

    @Override
    public void onDetachedFromActivity() {
        activityBinding = null;
        this.activity = null;
    }
}
