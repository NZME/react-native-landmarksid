package com.reactnativelandmarksid;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;

@ReactModule(name = LandmarksidModule.NAME)
public class LandmarksidModule extends ReactContextBaseJavaModule {
    public static final String NAME = "Landmarksid";

    public LandmarksidModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    @NonNull
    public String getName() {
        return NAME;
    }

    @ReactMethod
    public void initialize(String appId, String appSecret) {
    // TODO(matej): implement android tracking
    }
}
