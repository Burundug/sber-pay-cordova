import SberPaySDK

@objc(sberPay) class sberPay : CDVPlugin {
    var sberPayId : String?

    /**
     * Check device for ApplePay capability
     */
    @objc(initPay:) func initPay(command: CDVInvokedUrlCommand){
        self.sberPayId = command.callbackId;
        do {
            var sberId = try getFromRequest(fromArguments: command.arguments, key: "sbolBankInvoiceId") as! String;
            let requestModel = PaymentRequest(invoiceId: sberId, redirectUri: "https://getbuket.profycode.pro/mobile_app/")
            SberPay.pay(with: requestModel) { [self] resultSber in
                let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "OK")
                commandDelegate.send(result, callbackId: sberPayId)

            }

        } catch ValidationError.missingArgument(let message) {
            failWithError(message)
        } catch {
            failWithError(error.localizedDescription)
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

