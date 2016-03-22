//
//  QRCodeViewController.h
//  HelloWorld
//
//  Created by JUST-IMAC on 16/3/17.
//
//

#import <UIKit/UIKit.h>
#import "CDVQRCode.h"

@interface QRCodeViewController : UIViewController

@property(nonatomic,weak) CDVQRCode *qrCode;
@property(nonatomic,copy) NSString *callBackId;

@end
