cordova.define("cordova-plugin-sber-pay.sberPay", function(require, exports, module) {
    var exec = require('cordova/exec');
    let sberPay = function () {};
    sberPay.initPay = function (arg0, success, error) {
        exec(success, error, 'sberPay', 'initPay', [arg0]);
    };
    sberPay.checkSbol = function ( success, error) {
        exec(success, error, 'sberPay', 'checkSbol');
    };

    module.exports = sberPay;

});
