//
//  QRCodeViewController.m
//  HelloWorld
//
//  Created by JUST-IMAC on 16/3/17.
//
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIView *navView;
@property (strong, nonatomic) AVCaptureDevice *device;
@property (strong, nonatomic) AVCaptureDeviceInput *input;
@property (strong, nonatomic) AVCaptureMetadataOutput *output;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self setupCamera];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.backButton.hidden = NO;
    self.navView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.backButton.hidden = YES;
    self.navView.hidden = YES;
}

- (void)addBackButton {
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 64)];
    _navView.backgroundColor = [UIColor colorWithRed:0.0588 green:0.0588 blue:0.0588 alpha:1.0];
    _navView.alpha = 0.6;
    [window addSubview:_navView];
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(16, 26, 32, 32);
    [_backButton setBackgroundImage:[UIImage imageNamed:@"qrcode_back"] forState:0];
    [_backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:_backButton];
}

- (void)setupCamera {
    // Device
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Input
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    // Output
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // Session
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    self.output.metadataObjectTypes = @[ AVMetadataObjectTypeQRCode ];
    // Preview
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer addSublayer:self.preview];
    // Start

    [self setScanRegion];
    [self.session startRunning];
}

- (void)setScanRegion {
    UIImageView *overlayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"focus.png"]];
    overlayImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:overlayImageView];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:overlayImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:overlayImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0]];

    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;

    _output.rectOfInterest = CGRectMake((screenHeight - 200) / 2 / screenHeight,
                                        (screenWidth - 260) / 2 / screenWidth,
                                        200 / screenHeight,
                                        260 / screenWidth);
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue;
    if ([metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    [_session stopRunning];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:stringValue];
    [self.qrCode.commandDelegate sendPluginResult:pluginResult callbackId:_callBackId];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickBack {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)dealloc {
    [self.backButton removeFromSuperview];
    [self.navView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
