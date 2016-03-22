//
//  CDVQRCode.m
//  HelloWorld
//
//  Created by JUST-IMAC on 16/3/17.
//
//

#import "CDVQRCode.h"
#import "QRCodeViewController.h"

@interface CDVQRCode () {
    QRCodeViewController *_qrCodeController;
}

@end

@implementation CDVQRCode

- (void)scanCode:(CDVInvokedUrlCommand*)command {
    NSString *callBackId = command.callbackId;
    if (!_qrCodeController) {
        _qrCodeController = [[QRCodeViewController alloc] init];
    }
    _qrCodeController.callBackId = callBackId;
    _qrCodeController.qrCode = self;
    [self.viewController presentViewController:_qrCodeController animated:YES completion:nil];
}

@end
