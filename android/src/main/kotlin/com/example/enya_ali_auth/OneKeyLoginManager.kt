package com.example.enya_ali_auth

import android.app.AlertDialog
import android.content.Context
import android.content.Intent
import android.content.pm.ActivityInfo
import android.graphics.Color
import android.text.Spannable
import android.text.SpannableString
import android.text.TextPaint
import android.text.method.LinkMovementMethod
import android.text.style.ClickableSpan
import android.text.style.ForegroundColorSpan
import android.util.Log
import android.util.TypedValue
import android.view.LayoutInflater
import android.view.View
import android.widget.TextView
import com.example.enya_ali_auth.activity.WebActivity
import com.mobile.auth.gatewayauth.AuthRegisterXmlConfig
import com.mobile.auth.gatewayauth.AuthUIConfig
import com.mobile.auth.gatewayauth.LoginAuthActivity
import com.mobile.auth.gatewayauth.PhoneNumberAuthHelper
import com.mobile.auth.gatewayauth.PreLoginResultListener
import com.mobile.auth.gatewayauth.ResultCode
import com.mobile.auth.gatewayauth.TokenResultListener
import com.mobile.auth.gatewayauth.ui.AbstractPnsViewDelegate
import org.json.JSONException
import org.json.JSONObject

/**
 * @author wfx
 * date 2021.09.02
 * Description:
 */
class OneKeyLoginManager(private val context: Context) {
    companion object {
        private const val TIMEOUT = 1000
        private const val PRIVACY_DIALOG_ALPHA = 0.5f
        private const val PRIVACY_TEXT_SIZE = 11
        private const val CHECKBOX_SIZE = 16


        fun getCurrentCarrierNameCn(name: String): String {
            return when (name) {
//            CMCC(中国移动)、CUCC(中国联通)、CTCC(中国电信)
                "CMCC" -> "中国移动"
                "CUCC" -> "中国联通"
                "CTCC" -> "中国电信"
                else -> "未知"
            }
        }
    }

    private var mPhoneNumberAuthHelper: PhoneNumberAuthHelper? = null
    private var iOneKeyLoginCallBack: IOneKeyLoginCallBack? = null
    private var uiConfig: UIConfig? = null
    private var hostActivity: LoginAuthActivity? = null
    private val privacyDialogWidth by lazy { px2dip(context, getScreenWidth() / 4 * 3) }
    var currentCarrierName = ""

    fun setHostActivity(activity: LoginAuthActivity?) {
        hostActivity = activity
    }

    fun initSdk(uiConfig: UIConfig) {
        this.uiConfig = uiConfig
        mPhoneNumberAuthHelper =
            PhoneNumberAuthHelper.getInstance(context, initTokenListener()).apply {
                reporter.setLoggerEnable(true)
                setAuthSDKInfo(uiConfig.apiKey)
                accelerateLoginPage(TIMEOUT, object : PreLoginResultListener {
                    override fun onTokenSuccess(p0: String) {
                        oneKeyLogin()
                    }

                    override fun onTokenFailed(p0: String, p1: String) {
                        iOneKeyLoginCallBack?.onTokenResult("{\"code\":\"500012\"}")
                    }
                })
            }
    }


    private fun initTokenListener() = object : TokenResultListener {
        override fun onTokenSuccess(s: String) {
            Log.i("OneKeyLoginManagerHost", s)
            iOneKeyLoginCallBack?.onTokenResult(s)
        }

        override fun onTokenFailed(s: String) {
            Log.i("OneKeyLoginManagerHost", s)
            iOneKeyLoginCallBack?.onTokenResult(s)
        }
    }

    fun setAuthUIConfig() {
        uiConfig?.let { config ->
            Log.i("uiConfig == ", config.toMap().toString())
            val temp = getCurrentCarrierNameCn(mPhoneNumberAuthHelper?.currentCarrierName ?: "")
            if (currentCarrierName != temp) {
                currentCarrierName = temp

                mPhoneNumberAuthHelper?.setAuthUIConfig(
                    AuthUIConfig.Builder()
                        .setScreenOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR_PORTRAIT)
                        .setSwitchAccHidden(config.changeBtnIsHidden) //切换方式隐藏
                        .setPrivacyState(false) //隐私条款是否默认勾选
                        .setLightColor(false) //状态栏字体颜色
                        .setNavHidden(config.navIsHidden)
                        .setStatusBarColor(Color.TRANSPARENT)
                        .setStatusBarUIFlag(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN)

                        //logo
                        .setLogoHidden(config.logoIsHidden)
                        .setLogoWidth(config.logoWidth.toInt())
                        .setLogoHeight(config.logoHeight.toInt())
                        .setLogoImgPath(getImageName(config.logoImage))
                        .setLogoOffsetY(config.logoOffsetY.toInt())

                        .setSloganText("${currentCarrierName}提供认证服务")
                        .setSloganTextSizeDp(config.sloganFontSize)
                        .setSloganHidden(config.sloganIsHidden)
                        .setSloganTextColor(Color.parseColor(config.sloganColor))
                        .setSloganOffsetY(config.sloganOffsetY.toInt())

                        //手机号码
                        .setNumberColor(Color.parseColor(config.numberColor))
                        .setNumberSizeDp(config.numberFontSize)
                        .setNumFieldOffsetY(config.numberOffsetY.toInt())

                        //一键登录按钮
                        .setLogBtnOffsetY(config.loginBtnOffsetY.toInt())
                        .setLogBtnText(config.loginBtnText)
                        .setLogBtnTextColor(Color.parseColor(config.loginBtnColor))
                        .setLogBtnTextSizeDp(config.loginBtnFontSize.toInt())
                        .setLogBtnBackgroundDrawable(context.resources.getDrawable(R.drawable.background_login_onekey))
                        .setLogBtnHeight(config.loginBtnHeight.toInt())
                        .setLogBtnToastHidden(true)
                        .setHiddenLoading(config.hideLoginLoading)


                        .setPrivacyTextSize(config.privacyFontSize.toInt())
                        .setPrivacyBefore(config.privacyPreText)
                        .setAppPrivacyOne(config.privacyOne[0], config.privacyOne[1])
                        .setAppPrivacyTwo(config.privacyTwo[0], config.privacyTwo[1])
                        .setAppPrivacyColor(
                            context.resources.getColor(R.color.color_BDBDBD),
                            context.resources.getColor(R.color.color_92A6E2)
                        )

                        .setCheckedImgPath(getImageName(config.checkBoxImages[0]))
                        .setUncheckedImgPath(getImageName(config.checkBoxImages[1]))
                        .setCheckBoxWidth(config.checkBoxWH.toInt())
                        .setCheckBoxHeight(config.checkBoxWH.toInt())
                        .setPrivacyOffsetY_B(config.privacyOffsetY.toInt())
                        .setVendorPrivacyPrefix(config.privacyOperatorPreText)
                        .setVendorPrivacySuffix(config.privacyOperatorSufText)
                        .setPrivacyConectTexts(arrayOf("", "和"))


                        //二次弹窗
                        .setPrivacyAlertWidth(privacyDialogWidth)
                        .setPrivacyAlertHeight((privacyDialogWidth / 3 * 2.2f).toInt())
                        .setPrivacyAlertIsNeedShow(true)
                        .setPrivacyAlertMaskAlpha(0.7f)
                        .setPrivacyAlertBackgroundColor(Color.parseColor(config.privacyAlertBackgroundColor))
                        .setPrivacyAlertCornerRadiusArray(config.privacyAlertCornerRadiusArray.map { it.toInt() }
                            .toIntArray())

                        //二次协议弹窗标题
                        .setPrivacyAlertTitleTextSize(config.privacyAlertTitleFontSize.toInt())
                        .setPrivacyAlertTitleColor(Color.parseColor(config.privacyAlertTitleColor))
                        .setPrivacyAlertTitleOffsetY(config.privacyAlertTitleOffsetY.toInt())

                        //二次协议弹窗内容

                        .setPrivacyAlertContentBaseColor(Color.parseColor(config.privacyAlertContentColors[0]))
                        .setPrivacyAlertContentColor(Color.parseColor(config.privacyAlertContentColors[1]))
                        .setPrivacyAlertContentTextSize(config.privacyAlertContentFontSize.toInt())
                        .setPrivacyAlertContentVerticalMargin(config.privacyAlertContentMarginVertical.toInt())
                        .setPrivacyAlertContentHorizontalMargin(config.privacyAlertContentMarginHorizontal.toInt())

                        //二次协议弹窗确认按钮
                        .setPrivacyAlertBtnBackgroundImgDrawable(context.resources.getDrawable(R.drawable.background_login_onekey))
                        .setPrivacyAlertBtnTextColor(Color.parseColor(config.privacyAlertButtonTextColors[0]))
                        .setPrivacyAlertBtnVerticalMargin(10)
                        .setPrivacyAlertBtnWidth(config.privacyAlertButtonWidth.toInt())
                        .setPrivacyAlertBtnHeigth(config.privacyAlertButtonHeight.toInt())
                        .setPrivacyAlertBtnTextSize(config.privacyAlertButtonFontSize.toInt())
                        .setPrivacyAlertBtnOffsetY(config.privacyAlertButtonOffsetY.toInt())
                        .setPrivacyAlertContentBaseColor(Color.parseColor(config.privacyAlertContentColors[0]))
                        .setPrivacyAlertOneColor(Color.parseColor(config.privacyAlertContentColors[1]))
                        .setPrivacyAlertTwoColor(Color.parseColor(config.privacyAlertContentColors[1]))
                        .setPrivacyAlertOperatorColor(Color.parseColor(config.privacyAlertContentColors[1]))
                        .setPrivacyAlertCloseBtnShow(false)

                        .create()
                )
            }
        }
    }

    fun initLayout(uiConfig: UIConfig) {
        Log.i("OneKeyLoginManagerHost", "privacyDialogWidth = $privacyDialogWidth")
        mPhoneNumberAuthHelper?.let { helper ->
            helper.setUIClickListener { code: String, context: Context, jsonString: String? ->
                if (jsonString.isNullOrEmpty()) {
                    return@setUIClickListener
                }

                Log.i("OneKeyLoginManagerHost", jsonString)
                val jsonObj: JSONObject = try {
                    JSONObject(jsonString)
                } catch (e: JSONException) {
                    JSONObject()
                }

                if (ResultCode.CODE_ERROR_USER_CHECKBOX == code) {
                    iOneKeyLoginCallBack?.onCheckChange(jsonObj.optBoolean("isChecked"))
                }
            }
            helper.removeAuthRegisterXmlConfig()
            helper.removeAuthRegisterViewConfig()
            helper.addAuthRegisterXmlConfig(
                AuthRegisterXmlConfig.Builder()
                    .setLayout(R.layout.layout_onekey_login, object : AbstractPnsViewDelegate() {
                        override fun onViewCreated(view: View) {

                            view.findViewById<View>(R.id.wxLogin).let { wxView ->
                                wxView.visibility =
                                    if (uiConfig.isWxInstalled) View.VISIBLE else View.GONE


                                wxView.setOnClickListener {
                                    if (helper.queryCheckBoxIsChecked()) {
                                        iOneKeyLoginCallBack?.onThirdLogin(0)
                                    } else {
                                        showPrivacyAlert(0)
                                    }
                                }
                            }

                            view.findViewById<View>(R.id.loginPhone).setOnClickListener {
                                if (helper.queryCheckBoxIsChecked()) {
                                    iOneKeyLoginCallBack?.onThirdLogin(1)
                                } else {
                                    showPrivacyAlert(1)
                                }
                            }
                        }
                    })
                    .build()
            )
        }
    }

    /**
     * 拉取授权页
     */
    fun oneKeyLogin() {
        mPhoneNumberAuthHelper?.getLoginToken(context, TIMEOUT)
    }

    fun dismissLoading() {
        mPhoneNumberAuthHelper?.hideLoginLoading()
    }

    fun destroy() {
        mPhoneNumberAuthHelper?.apply {
            setAuthListener(null)
        }
        mPhoneNumberAuthHelper = null
    }

    fun quitLoginPage() {
        mPhoneNumberAuthHelper?.quitLoginPage()
    }

    fun setIOneKeyLoginCallBack(iOneKeyLoginCallBack: IOneKeyLoginCallBack?) {
        this.iOneKeyLoginCallBack = iOneKeyLoginCallBack
    }


    private fun getScreenWidth(): Float {
        val metrics = context.resources.displayMetrics
        return metrics.widthPixels.toFloat()
    }

    private fun dip2px(context: Context, dipValue: Float): Float {
        return TypedValue.applyDimension(
            TypedValue.COMPLEX_UNIT_DIP,
            dipValue,
            context.resources.displayMetrics
        )
    }

    fun px2dip(context: Context, pxValue: Float): Int {
        val scale = context.resources.displayMetrics.density
        return (pxValue / scale + 0.5f).toInt()
    }


    private fun showPrivacyAlert(type: Int) {
        uiConfig?.let { config ->
            hostActivity?.let { activity ->
                val view = LayoutInflater.from(activity)
                    .inflate(R.layout.dialog_layout, null)

                val dialog = AlertDialog.Builder(activity)
                    .setView(view)
                    .create()

                val content = view.findViewById<TextView>(R.id.dialogContent)
                val text =
                    SpannableString("${config.privacyPreText}${config.privacyOne[0]}和${config.privacyTwo[0]}")

                // "我已阅读并同意"设置为白色
                text.setSpan(
                    ForegroundColorSpan(Color.parseColor(config.privacyColors[0])),
                    0,
                    config.privacyPreText.length,
                    Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
                )

                // "和"设置为白色
                text.setSpan(
                    ForegroundColorSpan(Color.parseColor(config.privacyColors[0])),
                    text.indexOf("和"),
                    text.indexOf("和") + 1,
                    Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
                )

                // 用户服务条款：蓝色+点击事件1
                val userStart = text.indexOf(config.privacyOne[0])
                text.apply {
                    setSpan(
                        ForegroundColorSpan(Color.parseColor(config.privacyColors[1])),
                        userStart,
                        userStart + config.privacyOne[0].length,
                        Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
                    )
                    setSpan(
                        object : ClickableSpan() {
                            override fun onClick(widget: View) {
                                hostActivity?.startActivity(
                                    Intent(
                                        hostActivity,
                                        WebActivity::class.java
                                    ).apply {
                                        putExtra("url", uiConfig?.privacyOne?.get(1) ?: "")
                                    })
                            }

                            override fun updateDrawState(ds: TextPaint) {
                                ds.isUnderlineText = false
                            }
                        },
                        userStart,
                        userStart + config.privacyOne[0].length,
                        Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
                    )
                }

                // 隐私保护指引：蓝色+点击事件2
                val privacyStart = text.indexOf(config.privacyTwo[0])
                text.apply {
                    setSpan(
                        ForegroundColorSpan(Color.parseColor(config.privacyColors[1])),
                        privacyStart,
                        privacyStart + config.privacyTwo[0].length,
                        Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
                    )
                    setSpan(
                        object : ClickableSpan() {
                            override fun onClick(widget: View) {
                                hostActivity?.startActivity(
                                    Intent(
                                        hostActivity,
                                        WebActivity::class.java
                                    ).apply {
                                        putExtra("url", uiConfig?.privacyTwo?.get(1) ?: "")
                                    })
                            }

                            override fun updateDrawState(ds: TextPaint) {
                                ds.isUnderlineText = false
                            }
                        },
                        privacyStart,
                        privacyStart + config.privacyTwo[0].length,
                        Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
                    )
                }

                // 设置文本可点击
                content.movementMethod = LinkMovementMethod.getInstance()
                content.highlightColor = Color.TRANSPARENT
                content.text = text

                view.findViewById<TextView>(R.id.confirmButton).setOnClickListener {
                    mPhoneNumberAuthHelper?.apply {
                        // setProtocolChecked(true)
                        iOneKeyLoginCallBack?.onThirdLogin(type)
                    }
                    dialog.dismiss()
                }

                dialog.show()

                dialog.window?.apply {
                    setBackgroundDrawableResource(android.R.color.transparent)
                    setDimAmount(PRIVACY_DIALOG_ALPHA)
                    val params = attributes
                    params.width = dip2px(activity, privacyDialogWidth.toFloat()).toInt()
                    params.height = dip2px(activity, privacyDialogWidth / 3 * 2f).toInt()
                    attributes = params
                }
            }
        }

    }

    private fun getImageName(path: String): String {
        return try {
            // 处理 Flutter 资源路径
            when {
                path.startsWith("assets/") || path.startsWith("/assets/") -> {
                    // 移除 assets/ 前缀，并移除文件扩展名
                    path.replace(Regex("^/?assets/"), "")
                        .substringBeforeLast(".")
                }
                else -> path.substringBeforeLast(".")
            }
        } catch (e: Exception) {
            Log.e("OneKeyLoginManager", "Error processing image path: $path", e)
            path
        }
    }

    interface IOneKeyLoginCallBack {
        fun onTokenResult(json: String)
        fun onThirdLogin(type: Int)
        fun onCheckChange(isChecked: Boolean)
    }
}