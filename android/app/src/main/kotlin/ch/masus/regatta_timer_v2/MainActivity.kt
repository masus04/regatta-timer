package ch.masus.regatta_timer_v2

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import android.view.MotionEvent
import com.samsung.wearable_rotary.WearableRotaryPlugin


class MainActivity : FlutterActivity() {
    // The following configuration only applies to the wearOS version
    override fun onCreate(savedInstanceState: Bundle?) {
        intent.putExtra("background_mode", "transparent")
        super.onCreate(savedInstanceState)
    }

    override fun onGenericMotionEvent(event: MotionEvent?): Boolean {
        return when {
            WearableRotaryPlugin.onGenericMotionEvent(event) -> true
            else -> super.onGenericMotionEvent(event)
        }
    }
}
