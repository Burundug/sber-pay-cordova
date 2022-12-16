@objc(sberPay) class sberPay : CDVPlugin {
    var sberPayId : String?

    /**
     * Check device for ApplePay capability
     */
    @objc(initPay:) func initPay(command: CDVInvokedUrlCommand){
               self.sberPayId = (fromArguments: command.arguments, key: "sbolBankInvoiceId") as! String;
                        let requestModel = PaymentRequest(invoiceId: self.sberPayId, redirectUri: "https://getbuket.profycode.pro/mobile_app/")
                    SberPay.pay(with: requestModel) { result in
                  commandDelegate.send(result, sberPayId: sbolBankInvoiceId)
}

    }

}

