##README
### 下载说明
* 下载插件源代码

* 下载fami-plugin-lists用于集成插件 git clone git@github.com:fami2u/fami-plugin-lists.git

* 以上两个目录平级

* cd fami-plugin-lists

* 查看当前安装的插件 cordova plugin list

* 删除插件 cordova plugin remove com.fami2u.plugin.

* 安装插件 cordova-plugin- 使用命令 cordova plugin add ../

* 重新编译插件 cordova build android||ios

### 调用说明
> IOS部分

本插件是基于ping++SDK集成的支付插件。开发人员使用时需要调起如下方法：                                                                                                                                                   
      
      ping.pay(params);

其中params是支付过程中所需参数，需要在调取方法的时候传递，例：


        var params = {
               order_no: "订单号",
               app[id]: "appID"
                     };

在AppDelegate.m中添加以下方法：

// iOS 8 及以下请用这个
	  
	- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	    return [Pingpp handleOpenURL:url withCompletion:nil];
	}


// iOS 9 以上请用这个

	- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
	    return [Pingpp handleOpenURL:url withCompletion:nil];
	}


####具体所需参数如下：

- order_no: required

 
  商户订单号，适配每个渠道对此参数的要求，必须在商户系统内唯一。(alipay: 1-64 位， wx: 2-32 位，bfb: 1-20 位，upacp: 8-40 位，yeepay_wap:1-50 位，jdpay_wap:1-30 位，cnp_u:8-20 位，cnp_f:8-20 位，推荐使用 8-20 位，要求数字或字母，不允许特殊字符)。
     
     
 - app[id]: required

   支付使用的 app 对象的 id，请登陆管理平台查看。
- channel: required

   支付使用的第三方支付渠道。
- amount: required

  订单总金额, 单位为对应币种的最小货币单位，例如：人民币为分（如订单 总金额为 1 元，此处请填 100）。
- client_ip: required

  发起支付请求客户端的 IP 地址，格式为 IPV4，如: 127.0.0.1。
- currency: required
 
  三位 ISO 货币代码，目前仅支持人民币 cny。

- subject: required

  商品的标题，该参数最长为 32 个 Unicode 字符，银联全渠道（upacp/upacp_wap）限制在 32 个字节。
- body: required

  商品的描述信息，该参数最长为 128 个 Unicode 字符，yeepay_wap 对于该参数长度限制为 100 个 Unicode 字符。
- extra: optional

  特定渠道发起交易时需要的额外参数以及部分渠道支付成功返回的额外参数。
- time_expire: optional

  订单失效时间，用 Unix 时间戳表示。时间范围在订单创建后的 1 分钟到 15 天，默认为 1 天，创建时间以 Ping++ 服务器时间为准。 微信对该参数的有效值限制为 2 小时内；银联对该参数的有效值限制为 1 小时内。
- metadata: optional

  参考 Metadata 元数据。
- description: optional

  订单附加说明，最多 255 个 Unicode 字符。
  
####channel参数的取值范围
* alipay:支付宝手机支付

* alipay_wap:支付宝手机网页支付

* alipay_qr:支付宝扫码支付

* alipay_pc_direct:支付宝 PC 网页支付

* bfb:百度钱包移动快捷支付

* bfb_wap:百度钱包手机网页支付

* upacp:银联全渠道支付（2015 年 1 月 1 日后的银联新商户使用。若有疑问，请与 Ping++ 或者相关的收单行联系）

* upacp_wap:银联全渠道手机网页支付（2015 年 1 月 1 日后的银联新商户使用。若有疑问，请与 Ping++ 或者相关的收单行联系）

* upacp_pc:银联 PC 网页支付

* cp_b2b:银联企业网银支付

* wx:微信支付

* wx_pub:微信公众账号支付

* wx_pub_qr:微信公众账号扫码支付

* yeepay_wap:易宝手机网页支付

* jdpay_wap:京东手机网页支付

* cnp_u:应用内快捷支付（银联）

* cnp_f:应用内快捷支付（外卡）

* applepay_upacp:Apple Pay

* fqlpay_wap:分期乐支付

* qgbc_wap:量化派支付

#####更多插件请点击：[fami2u](https://github.com/fami2u)
#####关于我们：[FAMI](http://fami2u.com)