package com.reactnativelandmarksid;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.facebook.react.bridge.ReadableType;
import com.facebook.react.module.annotations.ReactModule;
import com.landmarksid.lo.LandmarksID;
import com.landmarksid.lo.formats.CustomData;

@ReactModule(name = LandmarksidModule.NAME)
public class LandmarksidModule extends ReactContextBaseJavaModule {
    public static final String NAME = "Landmarksid";
    private static LandmarksID landmarksId;
    private final ReactApplicationContext reactContext;

    public LandmarksidModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    @NonNull
    public String getName() {
        return NAME;
    }

    @ReactMethod
    public void initialize(String appId, String appSecret, ReadableMap options) {
        if (landmarksId == null) {
            LandmarksID.Options trackOptions = new LandmarksID.Options()
                    .setAppMetadata(appId, appSecret);

            String customerId = "sample-id";
            CustomData customData = new CustomData();

            if (options != null) {
                ReadableMapKeySetIterator iterator = options.keySetIterator();

                while (iterator.hasNextKey()) {
                    String key = iterator.nextKey();
                    ReadableType type = options.getType(key);
                    if (key.equals("customerId")) {
                        customerId = options.getString(key);
                        continue;
                    }

                    switch (type) {
                        case Number:
                            customData.addInt(key, options.getInt(key));
                            customData.addFloat(key, (float) options.getDouble(key));
                            break;
                        case String:
                            customData.addString(key, options.getString(key));
                            break;
                    }
                }
            }

            trackOptions.setCustomerId(customerId);
            trackOptions.setCustomData(customData);

            landmarksId = LandmarksID.getInstance().start(this.reactContext, trackOptions);
        }
    }

    @ReactMethod
    public void startTracking() {
        // Do nothing as Android does not support this.
    }

    @ReactMethod
    public void stopTracking() {
        // Do nothing as Android does not support this.
    }
//
//    @Override
//    public boolean onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
//      Log.e("matej: requestCode", String.valueOf(requestCode));
//      landmarksId.onRequestPermissionsResult(this.reactContext, requestCode, permissions, grantResults);
//      return true;
//    }
}
