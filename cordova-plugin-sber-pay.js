var exec = require('cordova/exec');
let sberPay = function () {};
sberPay.initPay = function (arg0, success, error) {
    exec(success, error, 'sberPay', 'initPay', [arg0]);
};
module.exports = sberPay;
