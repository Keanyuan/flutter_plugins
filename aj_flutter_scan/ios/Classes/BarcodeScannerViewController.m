#import "BarcodeScannerViewController.h"
#import <MTBBarcodeScanner/MTBBarcodeScanner.h>
#import "ScannerOverlay.h"
#import "QRHelper.h"



@implementation BarcodeScannerViewController {
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.clearColor;
    self.previewView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.previewView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_previewView];
    [self.view addConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"V:[previewView]"
                                options:NSLayoutFormatAlignAllBottom
                                metrics:nil
                                  views:@{@"previewView": _previewView}]];
    [self.view addConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"H:[previewView]"
                                options:NSLayoutFormatAlignAllBottom
                                metrics:nil
                                  views:@{@"previewView": _previewView}]];
  self.scanRect = [[ScannerOverlay alloc] initWithFrame:self.view.bounds];
  self.scanRect.translatesAutoresizingMaskIntoConstraints = NO;
  self.scanRect.backgroundColor = UIColor.clearColor;
  [self.view addSubview:_scanRect];
  [self.view addConstraints:[NSLayoutConstraint
                             constraintsWithVisualFormat:@"V:[scanRect]"
                             options:NSLayoutFormatAlignAllBottom
                             metrics:nil
                             views:@{@"scanRect": _scanRect}]];
  [self.view addConstraints:[NSLayoutConstraint
                             constraintsWithVisualFormat:@"H:[scanRect]"
                             options:NSLayoutFormatAlignAllBottom
                             metrics:nil
                             views:@{@"scanRect": _scanRect}]];
  [_scanRect startAnimating];
    self.scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:_previewView];
    [self setNav];
  [self updateFlashButton];
}


- (void)setNav {
    BOOL isIPhone8X = [UIScreen mainScreen].bounds.size.height >= 812 ? YES : NO;
    CGFloat kStatusBarH = isIPhone8X ? 44.0 : 20.0;
    
    self.backLabelButton = [[BackButton alloc]init];
    self.backLabelButton.frame = CGRectMake(10, kStatusBarH+5, 40, 40);
    self.backLabelButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.backLabelButton.layer.cornerRadius = 20;
    self.backLabelButton.layer.masksToBounds = true;
//    [self.backLabelButton setImage:[UIImage imageNamed:@"navigaton-back-button-bg"] forState:UIControlStateNormal];
    [self.backLabelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backLabelButton];
    
    self.flashButton = [[FlashButton alloc]init];
    //130 174
    self.flashButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, kStatusBarH + 5, 30, 40);
    [self.flashButton setNeedsDrawColor:UIColor.whiteColor];
//    self.flashButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];

//    [self.flashButton setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [self.flashButton addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.flashButton];
    CGRect rect = self.view.frame;
    CGFloat heightMultiplier = 3.0/4.0; // 4:3 aspect ratio
    CGFloat scanRectWidth = rect.size.width * 0.8f;
    CGFloat scanRectHeight = scanRectWidth * heightMultiplier;
    CGFloat scanRectOriginY = (rect.size.height / 2) - (scanRectHeight / 2);
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, scanRectOriginY - 50, [UIScreen mainScreen].bounds.size.width, 40);
    titleLabel.text = @"将二维码/条形码放入框内，即可自动扫描";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.scanner.isScanning) {
        [self.scanner stopScanning];
    }
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        if (success) {
            [self startScan];
        } else {
          [self.delegate barcodeScannerViewController:self didFailWithErrorCode:@"PERMISSION_NOT_GRANTED"];
          [self dismissViewControllerAnimated:NO completion:nil];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.scanner stopScanning];
    [super viewWillDisappear:animated];
    if ([self isFlashOn]) {
        [self toggleFlash:NO];
    }
}

- (void)startScan {
    NSError *error;
    [self.scanner startScanningWithResultBlock:^(NSArray<AVMetadataMachineReadableCodeObject *> *codes) {
        [QRHelper playAudioWithSoundName:@"noticeMusic.caf"];
        [self.scanner stopScanning];
         AVMetadataMachineReadableCodeObject *code = codes.firstObject;
        if (code) {
            [self.delegate barcodeScannerViewController:self didScanBarcodeWithResult:code.stringValue];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    } error:&error];
}

- (void)cancel {
    [self.delegate barcodeScannerViewController:self didFailWithErrorCode:@"SCAN_CANCLE"];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)updateFlashButton {
    if (!self.hasTorch) {
        return;
    }
    if (self.isFlashOn) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Flash Off"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self action:@selector(toggle)];
//        [self.flashButton setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
        [self.flashButton setNeedsDrawColor:[UIColor colorWithRed:95/255.0 green:144/255.0 blue:232/255.0 alpha:1/1.0]];

    } else {
//        [self.flashButton setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
        [self.flashButton setNeedsDrawColor:UIColor.whiteColor];

    }
}

- (void)toggle {
    [self toggleFlash:!self.isFlashOn];
    [self updateFlashButton];
}

- (BOOL)isFlashOn {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        return device.torchMode == AVCaptureFlashModeOn || device.torchMode == AVCaptureTorchModeOn;
    }
    return NO;
}

- (BOOL)hasTorch {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        return device.hasTorch;
    }
    return false;
}

- (void)toggleFlash:(BOOL)on {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!device) return;

    NSError *err;
    if (device.hasFlash && device.hasTorch) {
        [device lockForConfiguration:&err];
        if (err != nil) return;
        if (on) {
            device.flashMode = AVCaptureFlashModeOn;
            device.torchMode = AVCaptureTorchModeOn;
        } else {
            device.flashMode = AVCaptureFlashModeOff;
            device.torchMode = AVCaptureTorchModeOff;
        }
        [device unlockForConfiguration];
    }
}


@end
