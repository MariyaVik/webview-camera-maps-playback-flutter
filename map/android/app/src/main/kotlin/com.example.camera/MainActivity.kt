package com.example.camera

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    MapKitFactory.setApiKey("84a724ea-53fd-4508-9df1-39a2db7283a6") // Your generated API key
    super.configureFlutterEngine(flutterEngine)
  }
}