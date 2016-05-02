# QRCode

简单的cordova扫描二维码插件(支持iOS)


## Installation
```
cordova plugin add cordova-plugin-qrcode
```

## Usage
js调用

```
var button = document.getElementsByClassName('QRCode')[0];

button.onclick = function() {

    QRCode.scanCode(success);

    function success(info) {
        alert(info);
    }
    
};
```

## Supported Platforms

- iOS 8.0

## License

Apache License 2.0
