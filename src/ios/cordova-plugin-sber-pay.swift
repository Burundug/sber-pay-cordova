import SberPaySDK
import UIKit

@objc(sberPay) class sberPay : CDVPlugin {
    var sberPayId : String?

    /**
     * Check device for ApplePay capability
     */
    func canOpen(url: URL) -> Bool {
           return UIApplication.shared.canOpenURL(url)
   }
    func open(
    _ url: URL,
    options: [UIApplication.OpenExternalURLOptionsKey: Any] = [:],
    completionHandler completion: ((Bool) -> Void)? = nil) {
    UIApplication.shared.open(url, options: options, completionHandler: completion)
}
    enum Deeplink: String {
                     case sbolpayDeeplink = "sbolpay://invoicing/v2"
                     case sberpayDeeplink = "sberpay://invoicing/v2"
         func canOpen(url: URL) -> Bool {
            return UIApplication.shared.canOpenURL(url)
    }
                     var scheme: String? {
                         switch self {
                         case .sbolpayDeeplink:
                             guard let url = URL(string: "sbolpay://invoicing/v2") else { return nil }
                             return canOpen(url: url) ? self.rawValue : nil
                         case .sberpayDeeplink:
                             guard let url = URL(string: "sberpay://invoicing/v2") else { return nil }
                             return canOpen(url: url) ? self.rawValue : nil
} }
}
                  func checkingDeeplinkScheme() -> String? {
                     if let sbolPay = Deeplink.sbolpayDeeplink.scheme {
                         return sbolPay
                     } else if let sberPay = Deeplink.sberpayDeeplink.scheme {
                         return sberPay
                     } else {
return nil }
}
    @objc(initPay:) func initPay(command: CDVInvokedUrlCommand){
        self.sberPayId = command.callbackId;
        //        do {
        //            var sberId = try getFromRequest(fromArguments: command.arguments, key: "sbolBankInvoiceId") as! String;
        //            let requestModel = PaymentRequest(invoiceId: sberId, redirectUri: "https://getbuket.profycode.pro/mobile_app/")
        //            SberPay.pay(with: requestModel) { [self] resultSber in
        //                let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "OK")
        //                commandDelegate.send(result, callbackId: sberPayId)
        //
        //            }
        //
        //        } catch ValidationError.missingArgument(let message) {
        //            failWithError(message)
        //        } catch {
        //            failWithError(error.localizedDescription)
        //        }
        if(!command.callbackId.isEmpty) {
            command.callbackId.count <= invoiceIdMaxLength else {
               completionHandler?(.invalidParams)
               return
           }
        }

         let scheme = checkingDeeplinkScheme(),
              url = urlBuilder.build(with: self.sberPayId, scheme: scheme) else {
            completionHandler?(.unknown)
            return
        }
        urlOpener.open(url, options: [:]) { result in
            completionHandler?(result ? .success : .launchError)
        }
    }
    private func getFromRequest(fromArguments arguments: [Any]?, key: String) throws -> Any {
        let val = (arguments?[0] as? [AnyHashable : Any])?[key]

        if val == nil {
            throw ValidationError.missingArgument("\(key) is required")
        }

        return val!
    }

    private func failWithError(_ error: String){
        let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error)
        commandDelegate.send(result, callbackId: sberPayId)
    }

}
