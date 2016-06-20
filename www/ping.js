var exec = require('cordova/exec');

exports.pay = function(arg0, success, error) {
    exec(success, error, "ping", "pay", [arg0]);
};
