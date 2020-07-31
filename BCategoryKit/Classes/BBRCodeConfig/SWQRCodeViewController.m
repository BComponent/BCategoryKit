//
//  SWQRCodeViewController.m
//  SWQRCode_Objc
//
//  Created by zhuku on 2018/4/4.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWQRCodeViewController.h"
#import "SWScannerView.h"

@interface SWQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/** 扫描器 */
@property (nonatomic, strong) SWScannerView *scannerView;
@property (nonatomic, strong) AVCaptureSession *session;

@end

@implementation SWQRCodeViewController

- (void)dealloc {
    [self pauseScanning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (SWScannerView *)scannerView
{
    if (!_scannerView) {
        _scannerView = [[SWScannerView alloc]initWithFrame:self.view.bounds config:_codeConfig];;
    }
    return _scannerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [SWQRCodeManager sw_navigationItemTitleWithType:self.codeConfig.scannerType];
    [self _setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.scannerView sw_addScannerLineAnimation];
//    [self resumeScanning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.scannerView sw_setFlashlightOn:NO];
    [self.scannerView sw_hideFlashlightWithAnimated:YES];
}
- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationFullScreen;
}
- (void)_setupUI {
    self.view.backgroundColor = [UIColor blackColor];
    UIBarButtonItem *albumItem = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(showAlbum)];
//    [albumItem setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = albumItem;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blueColor]];
    
    [self.view addSubview:self.scannerView];
    __weak __typeof(&*self)weakSelf = self;
    // 校验相机权限
    [SWQRCodeManager sw_checkCameraAuthorizationStatusWithGrand:^(BOOL granted) {
        if (granted) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf _setupScanner];
                });
            });
        }
    }];
}

/** 创建扫描器 */
- (void)_setupScanner {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    AVCaptureVideoDataOutput *videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:deviceInput]) {
        [self.session addInput:deviceInput];
    }
    if ([self.session canAddOutput:metadataOutput]) {
        [self.session addOutput:metadataOutput];
    }
    if ([self.session canAddOutput:videoDataOutput]) {
        [self.session addOutput:videoDataOutput];
    }
    metadataOutput.metadataObjectTypes = [SWQRCodeManager sw_metadataObjectTypesWithType:self.codeConfig.scannerType];
    AVCaptureVideoPreviewLayer *videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.session startRunning];
    __weak __typeof(&*self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.codeConfig.scannerArea == SWScannerAreaDefault) {
            metadataOutput.rectOfInterest = CGRectMake([weakSelf.scannerView scanner_y]/weakSelf.view.frame.size.height, [weakSelf.scannerView scanner_x]/weakSelf.view.frame.size.width, [weakSelf.scannerView scanner_width]/weakSelf.view.frame.size.height, [weakSelf.scannerView scanner_width]/weakSelf.view.frame.size.width);
        }
        videoPreviewLayer.frame = weakSelf.view.layer.bounds;
        [weakSelf.view.layer insertSublayer:videoPreviewLayer atIndex:0];
        [weakSelf.scannerView sw_addScannerLineAnimation];
    });
    
    
}

#pragma mark -- 跳转相册
- (void)imagePicker {
    __weak __typeof(&*self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (@available(iOS 11.0, *)) {
             [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways; //iOS11 解决SafeArea的问题，同时能解决pop时上级页面scrollView抖动的问题
        } else {
            // Fallback on earlier versions
            weakSelf.automaticallyAdjustsScrollViewInsets = YES;
        }
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        imagePicker.navigationBar.translucent = NO; //去除毛玻璃效果
        imagePicker.navigationBar.barTintColor =[UIColor blueColor];
        [imagePicker.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:16], NSFontAttributeName, nil]];
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        [weakSelf presentViewController:imagePicker animated:YES completion:nil];
    });
    
    
}

#pragma mark -- AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    // 获取扫一扫结果
    if (metadataObjects && metadataObjects.count > 0) {
        
        [self pauseScanning];
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
        NSString *stringValue = metadataObject.stringValue;
        
        [self sw_handleWithValue:stringValue];
    }
}

#pragma mark -- AVCaptureVideoDataOutputSampleBufferDelegate
/** 此方法会实时监听亮度值 */
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    
    // 亮度值
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    
    if (![self.scannerView sw_flashlightOn]) {
        if (brightnessValue < -4.0) {
            [self.scannerView sw_showFlashlightWithAnimated:YES];
        }else
        {
            [self.scannerView sw_hideFlashlightWithAnimated:YES];
        }
    }
}

- (void)showAlbum {
    // 校验相册权限
    [SWQRCodeManager sw_checkAlbumAuthorizationStatusWithGrand:^(BOOL granted) {
        if (granted) {
            [self imagePicker];
        }
    }];
}

#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if (@available(iOS 11.0, *)) {
         [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    [picker showHudInView:picker.view hint:@"图片识别中"];
//     __weak __typeof(&*self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        UIImage *pickImage = info[UIImagePickerControllerOriginalImage];
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            // 获取选择图片中识别结果
            NSArray *features = [detector featuresInImage:[CIImage imageWithData:UIImagePNGRepresentation(pickImage)]];
            //回调或者说是通知主线程刷新，
            [picker dismissViewControllerAnimated:YES completion:^{
//                [picker hideHud];
                if (features.count > 0) {
                    CIQRCodeFeature *feature = features[0];
                    NSString *stringValue = feature.messageString;
                    [self sw_handleWithValue:stringValue];
                }
                else {
                    [self sw_didReadFromAlbumFailed];
                }
            }];
        });
    });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (@available(iOS 11.0, *)) {
           [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
      } else {
          // Fallback on earlier versions
          self.automaticallyAdjustsScrollViewInsets = NO;
      }
     [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark -- App 从后台进入前台
- (void)appDidBecomeActive:(NSNotification *)notify {
    [self resumeScanning];
}

#pragma mark -- App 从前台进入后台
- (void)appWillResignActive:(NSNotification *)notify {
    [self pauseScanning];
}

/** 恢复扫一扫功能 */
- (void)resumeScanning {
    if (self.session) {
        [self.session startRunning];
        [self.scannerView sw_addScannerLineAnimation];
    }
}


/** 暂停扫一扫功能 */
- (void)pauseScanning {
    if (self.session) {
        [self.session stopRunning];
        [self.scannerView sw_pauseScannerLineAnimation];
    }
}

#pragma mark -- 扫一扫API
/**
 处理扫一扫结果
 @param value 扫描结果
 */
- (void)sw_handleWithValue:(NSString *)value {
    if (_block) {
        _block(value);
    }
    NSLog(@"sw_handleWithValue === %@", value);
}

/**
 相册选取图片无法读取数据
 */
- (void)sw_didReadFromAlbumFailed {
//    [self showHint:@"图片识别失败"];
    NSLog(@"sw_didReadFromAlbumFailed");
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
