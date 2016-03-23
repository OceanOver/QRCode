//
//  CDVQRCode.m
//  HelloWorld
//
//  Created by JUST-IMAC on 16/3/17.
//
//

#import "CDVQRCode.h"
#import "QRCodeViewController.h"

@interface CDVQRCode ()

@end

@implementation CDVQRCode

- (void)scanCode:(CDVInvokedUrlCommand*)command {
    NSString *callBackId = command.callbackId;
    QRCodeViewController *qrCodeController = [[QRCodeViewController alloc] init];
    qrCodeController.callBackId = callBackId;
    qrCodeController.qrCode = self;
    [self.viewController presentViewController:qrCodeController animated:YES completion:nil];
}

@end
