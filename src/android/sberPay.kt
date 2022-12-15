package cordova.plugin.sber.pay;

import org.apache.cordova.CallbackContext
import org.apache.cordova.CordovaPlugin
import org.json.JSONArray
import org.json.JSONException
import sberpay.sdk.sberpaysdk.domain.SberbankOnlineManager

class sberPay : CordovaPlugin() {
    private var _callbackContext: CallbackContext? = null
    fun initSberPay(bankId: String) {
        val sberbankOnlineManager = SberbankOnlineManager()
        sberbankOnlineManager.openSberbankOnline(webView.context, bankId)
    }
    lateinit var context: CallbackContext
    @Throws(JSONException::class)
    override fun execute(
        action: String,
        data: JSONArray,
        callbackContext: CallbackContext
    ): Boolean {
        var result = true
        if (action == "coolMethod") {
            context = callbackContext
            var str: String = "dsd2e12d1123";
            initSberPay(str)
//                val obj: JSONObject = data.getJSONObject(0)
        }

        return result
    }
}

