//
//  CDVQRCode.h
//  HelloWorld
//
//  Created by JUST-IMAC on 16/3/17.
//
//

#import <Cordova/CDVPlugin.h>

@interface CDVQRCode : CDVPlugin

/**
 *  扫描二维码
 */
- (void)scanCode:(CDVInvokedUrlCommand*)command;

@end
