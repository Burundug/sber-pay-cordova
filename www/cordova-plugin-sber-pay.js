var exec = require('cordova/exec');
let sberPay = function () {};
sberPay.coolMethod = function (arg0, success, error) {
    exec(success, error, 'sberPay', 'coolMethod', [arg0]);
};
module.exports = sberPay;
