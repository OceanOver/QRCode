var exec = require('cordova/exec');
var qrCodeExport = {};
qrCodeExport.scanCode = function(successCallback, errorCallback, options) {
    var args = ['codeType'];
    exec(successCallback, errorCallback, "QRCode", "scanCode", args);
};
module.exports = qrCodeExport;
