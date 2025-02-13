package com.example.enya_ali_auth

import android.app.Activity
import android.app.Application
import android.os.Build
import android.os.Bundle
import android.util.Log
import com.mobile.auth.gatewayauth.LoginAuthActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** EnyaAliAuthPlugin */
class EnyaAliAuthPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    OneKeyLoginManager.IOneKeyLoginCallBack {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var oneKeyLoginManager: OneKeyLoginManager
    private var uiConfig: UIConfig? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "enya_ali_auth")
        channel.setMethodCallHandler(this)
    }


    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "init" -> {
                val map = call.arguments as HashMap<*, *>
                Log.i("uiConfig !! ", map.toString())
                uiConfig = UIConfig.fromMap(map)
                uiConfig?.let {
                    oneKeyLoginManager.apply {
                        setIOneKeyLoginCallBack(this@EnyaAliAuthPlugin)
                        initSdk(it)
                        initLayout(it)
                        setAuthUIConfig()
                    }
                }


                result.success("")
            }

            "accelerateLoginPage" -> {
                oneKeyLoginManager.accelerateLoginPage()
                result.success("")
            }

            "startToLogin"->{
                uiConfig?.let {
                    oneKeyLoginManager.initLayout(it)
                }

                oneKeyLoginManager.setAuthUIConfig()
                oneKeyLoginManager.oneKeyLogin()
            }

            "quitLoginPage" -> {
                oneKeyLoginManager.quitLoginPage()
            }

            "dismissLoading" -> {
                oneKeyLoginManager.dismissLoading()
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(p0: ActivityPluginBinding) {
        oneKeyLoginManager = OneKeyLoginManager(p0.activity)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            p0.activity.application.registerActivityLifecycleCallbacks(object : Application.ActivityLifecycleCallbacks {
                override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) {
                }

                override fun onActivityStarted(activity: Activity) {
                }

                override fun onActivityResumed(activity: Activity) {
                    if (activity is LoginAuthActivity) {
                        //展示一键登录页面
                        oneKeyLoginManager.setHostActivity(activity)
                    }
                }

                override fun onActivityPaused(activity: Activity) {
                }

                override fun onActivityStopped(activity: Activity) {
                }

                override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {
                }

                override fun onActivityDestroyed(activity: Activity) {
                    if (activity is LoginAuthActivity) {
                        //销毁一键登录页面
                        oneKeyLoginManager.setHostActivity(null)
                    }
                }

            })
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }

    override fun onTokenResult(json: String) {
        channel.invokeMethod("onResponseResult", json)
    }

    override fun onThirdLogin(type: Int) {
        channel.invokeMethod("onThirdLogin", type)
    }

    override fun onCheckChange(isChecked: Boolean) {
        channel.invokeMethod("onCheckChange", isChecked)
    }
}
