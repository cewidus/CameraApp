//
//  ShadowViewController.m
//  CameraApp
//
//  Created by Admin on 1/22/15.
//  Copyright (c) 2015 CWD. All rights reserved.
//
@import GoogleMobileAds;
#import "ShadowViewController.h"
#import "GAI.h"
#import <Parse/Parse.h>
#import "GAIDictionaryBuilder.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"

#define DegreesToRadians(x) ((x) * M_PI / 180.0)

@interface ShadowViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIWebView *shadowWebView;
@property (weak, nonatomic) IBOutlet UIButton *shootingButton;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (nonatomic, strong) UIImage *imageBuffer;
- (IBAction)ShootingAction:(id)sender;
- (IBAction)reloadAction:(id)sender;


@end


@implementation ShadowViewController
@synthesize stillImageOutput, imagePreview,shootingButton,urlTextField,bannerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Shadow View"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    [tracker set:kGAIScreenName value:nil];

    
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    /*
    NSLog(@"Country name: %@", countryCode);
    
    if([countryCode isEqualToString:@"JP"])
        
    {
        
        self.globalAdview.adUnitID=@"ca-app-pub-8337981281366372/7697065240";
        
        
    }
    
    else{
        
        self.globalAdview.adUnitID=@"ca-app-pub-8337981281366372/9173798446";
        
        
    }
    
    self.globalAdview.delegate = self;
    self.globalAdview.rootViewController = self;
    GADRequest *request = [GADRequest request];
    [self.globalAdview loadRequest:request];
    */
    
    
    
    if([countryCode isEqualToString:@"JP"])
    {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthPortraitWithHeight(100)];
        }
        else {
            
            self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthPortraitWithHeight(50)];
            
        }
        self.bannerView.adUnitID = @"ca-app-pub-8337981281366372/7697065240";
        
    }
    
    else
    {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthPortraitWithHeight(100)];
        }
        else {
            
            self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthPortraitWithHeight(50)];
            
        }
        self.bannerView.adUnitID = @"ca-app-pub-8337981281366372/9173798446";
        
    }
    
    self.bannerView.delegate = self;
    self.bannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    [self.bannerView loadRequest:request];
    [self.globalAdview addSubview:self.bannerView];
    
    /*self.globalAdview.delegate = self;
     self.globalAdview.rootViewController = self;
     GADRequest *request = [GADRequest request];
     [self.globalAdview loadRequest:request];
     */
    
    /*
    GADRequest *request = [GADRequest request];
    [self.bannerView loadRequest:request];
    self.bannerView.delegate = self;
    self.bannerView.rootViewController = self;
    [self.globalAdview addSubview:self.bannerView];
*/
    
    
    
    
    urlTextField.delegate = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *getUrl =    [defaults objectForKey:@"startPage"];
    
    
    NSString * urlString = getUrl;
    
    if(urlString == nil) {
        NSURL *url = [NSURL URLWithString:@"http://m.yahoo.co.jp"];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.shadowWebView loadRequest:urlRequest];
        self.urlTextField.text = @"http://m.yahoo.co.jp";
        NSLog(@"url request%@",urlRequest);
    }
    else{
        
        
        NSString* urlS = urlString;
        NSURL* url = [NSURL URLWithString:urlS];
        if(!url.scheme)
        {
            NSString* modifiedURLString = [NSString stringWithFormat:@"http://%@", urlString];
            self.urlTextField.text = modifiedURLString;
             NSLog(@"modifiedURLString%@",modifiedURLString);
            NSURL *url1 = [NSURL URLWithString:self.urlTextField.text];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url1];
            [self.shadowWebView loadRequest:urlRequest];
            
            self.urlTextField.text = self.urlTextField.text;
            
        }
        else
        {
            self.urlTextField.text = urlString;
            NSURL *url2 = [NSURL URLWithString:self.urlTextField.text];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url2];
            [self.shadowWebView loadRequest:urlRequest];
            
            self.urlTextField.text = self.urlTextField.text;
        
        }

       
    }
    NSLog(@"the url string%@",urlString);
    
    
    
  
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initializeCamera {
    
    [self initCamera];
    
 
}




- (void)viewDidAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean isdefaultCamera =    [defaults boolForKey:@"isdefaultCameraOn"];
    NSLog(@"isdefaultCamera%d",isdefaultCamera);
    
    cameraMode = isdefaultCamera;
    
    if(isdefaultCamera == TRUE)
        
    {
        [self initializeVideoCamera];
       
        
        self.videoButton.enabled = TRUE;
        
        [self.cameraButton setImage:[UIImage imageNamed:@"icon_camera_off.png"] forState:UIControlStateNormal];
        [self.videoButton setImage:[UIImage imageNamed:@"icon_video_on.png"] forState:UIControlStateNormal];
    }
    
    else
    {
        [self initializeCamera];
        self.cameraButton.enabled = TRUE;
        [self.cameraButton setImage:[UIImage imageNamed:@"icon_camera_on.png"] forState:UIControlStateNormal];
        [self.videoButton setImage:[UIImage imageNamed:@"icon_video_off.png"] forState:UIControlStateNormal];
    }
    
}


- (IBAction)ShootingAction:(id)sender {
    
    if(cameraMode == TRUE)
    
    {
        
        [self recordVideo];
    }
    
    else
    {
        
        
        if (!isProcessingTakePhoto) {
            
            isRequireTakePhoto = YES;
        }
        

        
        
        
    }
    

}

- (IBAction)reloadAction:(id)sender {
    
     [self loadUrl];
    
}





- (void) capImage { //method to capture image from AVCaptureSession video feed
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections) {
        
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        
        if (videoConnection) {
            break;
        }
    }
    
    NSLog(@"about to request a capture from: %@", stillImageOutput);
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        
        if (imageSampleBuffer != NULL) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
            [self processImage:[UIImage imageWithData:imageData]];
            
            
            
            
            
            NSString *dataPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media"];
            if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])    {
                [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
                NSLog(@"dataPath1 = %@ \n",dataPath);
            }
            
            NSString *imageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media/"];
            
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyyMMddHHmmss"];
            NSDate *now = [NSDate date];
            NSString *retStr = [format stringFromDate:now];
            NSLog(@"return string%@",retStr);
            
            NSString *savedImagePath = [imageFilePath
                                        stringByAppendingPathComponent:retStr];
            
            
            
            
            imageFilePath = [savedImagePath stringByAppendingString:@".png"];
            
            
            
            
            NSFileManager *fileManage = [NSFileManager defaultManager];
            
            [fileManage createFileAtPath:imageFilePath contents:nil attributes:nil];
            
            [imageData writeToFile:imageFilePath atomically:YES];
            
            
            
            
            
            
        }
    }];
}


-(void)CreateFolder
{
    
    NSString *dataPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])    {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
        NSLog(@"dataPath1 = %@ \n",dataPath);
    }
    
    NSString *testpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Download_Videos/"];
    testpath = [testpath stringByAppendingString:@"/test.mp4"];
    
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    [fileManage createFileAtPath:testpath contents:nil attributes:nil];
    
}


- (void) processImage:(UIImage *)image { //process captured image, crop, resize and rotate
    haveImage = YES;
    
    if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad) { //Device is ipad
        // Resize image
        UIGraphicsBeginImageContext(CGSizeMake(768, 1022));
        [image drawInRect: CGRectMake(0, 0, 768, 1022)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CGRect cropRect = CGRectMake(0, 130, 768, 768);
        CGImageRef imageRef = CGImageCreateWithImageInRect([smallImage CGImage], cropRect);
        //or use the UIImage wherever you like
        
        [self.captureImage setImage:[UIImage imageWithCGImage:imageRef]];
        
        CGImageRelease(imageRef);
        
    }else{ //Device is iphone
        // Resize image
        UIGraphicsBeginImageContext(CGSizeMake(320, 426));
        [image drawInRect: CGRectMake(0, 0, 320, 426)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CGRect cropRect = CGRectMake(0, 55, 320, 320);
        CGImageRef imageRef = CGImageCreateWithImageInRect([smallImage CGImage], cropRect);
        
        [self.captureImage setImage:[UIImage imageWithCGImage:imageRef]];
        
        CGImageRelease(imageRef);
    }
    
    //adjust image orientation based on device orientation
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) {
        NSLog(@"landscape left image");
        
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.5];
        self.captureImage.transform = CGAffineTransformMakeRotation(DegreesToRadians(-90));
        [UIView commitAnimations];
        
    }
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
        NSLog(@"landscape right");
        
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.5];
        self.captureImage.transform = CGAffineTransformMakeRotation(DegreesToRadians(90));
        [UIView commitAnimations];
        
    }
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) {
        NSLog(@"upside down");
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.5];
        self.captureImage.transform = CGAffineTransformMakeRotation(DegreesToRadians(180));
        [UIView commitAnimations];
        
    }
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        NSLog(@"upside upright");
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.5];
        self.captureImage.transform = CGAffineTransformMakeRotation(DegreesToRadians(0));
        [UIView commitAnimations];
    }
}



- (IBAction)videoAction:(id)sender {
    
    [self.cameraButton setImage:[UIImage imageNamed:@"camera_off.png"] forState:UIControlStateNormal];
    [self.videoButton setImage:[UIImage imageNamed:@"icon_video_on.png"] forState:UIControlStateNormal];
    
    [captureImageSession startRunning];
    [CaptureSession stopRunning];
    [self initializeVideoCamera];
    
    cameraMode = TRUE;
 
    
}

- (void) initializeVideoCamera
{
    
    CaptureSession = [[AVCaptureSession alloc] init];
    
    
    AVCaptureDevice *VideoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (VideoDevice)
    {
        NSError *error;
        VideoInputDevice = [AVCaptureDeviceInput deviceInputWithDevice:VideoDevice error:&error];
        if (!error)
        {
            if ([CaptureSession canAddInput:VideoInputDevice])
                [CaptureSession addInput:VideoInputDevice];
            else
                NSLog(@"Couldn't add video input");
        }
        else
        {
            NSLog(@"Couldn't create video input");
        }
    }
    else
    {
        NSLog(@"Couldn't create video capture device");
    }
    
    //ADD AUDIO INPUT
    AVCaptureDevice *audioCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    NSError *error = nil;
    AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioCaptureDevice error:&error];
    if (audioInput)
    {
        [CaptureSession addInput:audioInput];
    }
    
    
    captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:CaptureSession];
    [captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    captureVideoPreviewLayer.frame = self.imagePreview.bounds;
    [self.imagePreview.layer addSublayer:captureVideoPreviewLayer];
    
    
    MovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    
    Float64 TotalSeconds = 60;			//Total seconds
    int32_t preferredTimeScale = 30;	//Frames per second
    CMTime maxDuration = CMTimeMakeWithSeconds(TotalSeconds, preferredTimeScale);
    MovieFileOutput.maxRecordedDuration = maxDuration;
    
    MovieFileOutput.minFreeDiskSpaceLimit = 1024 * 1024;
    
    if ([CaptureSession canAddOutput:MovieFileOutput])
        [CaptureSession addOutput:MovieFileOutput];
    
    [self CameraSetOutputProperties];
    [CaptureSession startRunning];
    
    
    
    
    
}

- (void) CameraSetOutputProperties
{
    //SET THE CONNECTION PROPERTIES (output properties)
    AVCaptureConnection *CaptureConnection = [MovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    
    //Set landscape (if required)
    if ([CaptureConnection isVideoOrientationSupported])
    {
        AVCaptureVideoOrientation orientation = AVCaptureVideoOrientationPortrait;		//<<<<<SET VIDEO ORIENTATION IF LANDSCAPE
        [CaptureConnection setVideoOrientation:orientation];
    }
    
    //Set frame rate (if requried)
    CMTimeShow(CaptureConnection.videoMinFrameDuration);
    CMTimeShow(CaptureConnection.videoMaxFrameDuration);
    
    if (CaptureConnection.supportsVideoMinFrameDuration)
        //   CaptureConnection.videoMinFrameDuration = CMTimeMake(1, CAPTURE_FRAMES_PER_SECOND);
        if (CaptureConnection.supportsVideoMaxFrameDuration)
            //  CaptureConnection.videoMaxFrameDuration = CMTimeMake(1, CAPTURE_FRAMES_PER_SECOND);
            
            CMTimeShow(CaptureConnection.videoMinFrameDuration);
    CMTimeShow(CaptureConnection.videoMaxFrameDuration);
}

- (AVCaptureDevice *) CameraWithPosition:(AVCaptureDevicePosition) Position
{
    NSArray *Devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *Device in Devices)
    {
        if ([Device position] == Position)
        {
            return Device;
        }
    }
    return nil;
}

- (void) recordVideo

{
    if (!WeAreRecording)
    {
        WeAreRecording = YES;
     
        
     
        
         [shootingButton setImage:[UIImage imageNamed:@"button_shtter_b.png"] forState:UIControlStateNormal];
        NSString *dataPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])    {
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
            NSLog(@"dataPath1 = %@ \n",dataPath);
        }
        
        NSString *videoFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media/"];
        
        
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyyMMddHHmmss"];
        NSDate *now = [NSDate date];
        NSString *retStr = [format stringFromDate:now];
        NSLog(@"record string%@",retStr);
        
        NSString *savedVideoPath = [videoFilePath
                                    stringByAppendingPathComponent:retStr];
        
        videoFilePath = [savedVideoPath stringByAppendingString:@".mp4"];
        NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:videoFilePath];
        NSFileManager *fileManage = [NSFileManager defaultManager];
        
        [fileManage createFileAtPath:videoFilePath contents:nil attributes:nil];
        
        
        [MovieFileOutput startRecordingToOutputFileURL:outputURL recordingDelegate:self];
        
        
        NSLog(@"outputPath%@",outputURL);
    }
    else
    {
        
        
        //----- STOP RECORDING -----
        NSLog(@"STOP RECORDING");
        WeAreRecording = NO;
        
        [MovieFileOutput stopRecording];
       // [shootingButton setImage:[UIImage imageNamed:@"shooting.jpeg"] forState:UIControlStateNormal];
        [shootingButton setImage:[UIImage imageNamed:@"button_shtter_a.png"] forState:UIControlStateNormal];
        // [shootingImage setBackgroundImage:@"Shooting.jpeg" forState:UIControlStateNormal];
    }
    
}


- (IBAction)CameraAction:(id)sender {
    
    
    [self.cameraButton setImage:[UIImage imageNamed:@"icon_camera_on.png"] forState:UIControlStateNormal];
    [self.videoButton setImage:[UIImage imageNamed:@"icon_video_off.png"] forState:UIControlStateNormal];
    [captureImageSession startRunning];
    [CaptureSession stopRunning];
    [self initializeCamera];
    cameraMode = FALSE;
  
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    

    [self loadUrl];
    
    
    return NO;
    
    
}

-(void)loadUrl
{

    NSString* urleEntered = nil;
    urleEntered =  self.urlTextField.text;
    
    NSString* urlString = urleEntered;
    NSURL* url = [NSURL URLWithString:urlString];
    if(!url.scheme)
    {
        NSString* modifiedURLString = [NSString stringWithFormat:@"http://%@", urlString];
        self.urlTextField.text = modifiedURLString;
        
    }
    
    urleEntered = self.urlTextField.text;
    NSLog(@"entered url :%@", urleEntered);
    
    NSURL *url1 = [NSURL URLWithString:urleEntered];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url1];
    [ self.shadowWebView loadRequest:urlRequest];
    


}



- (void)initCamera {
    
    // バッファ作成
    size_t width = 640;
    size_t height = 480;
    
    //size_t width = 320;
    //size_t height = 480;
    
    
    bitmap = malloc(width * height * 4);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGDataProviderRef dataProviderRef = CGDataProviderCreateWithData(NULL, bitmap, width * height * 4, NULL);
    CGImageRef cgImage = CGImageCreate(width, height, 8, 32, width * 4, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst, dataProviderRef, NULL, 0, kCGRenderingIntentDefault);
    self.imageBuffer = [UIImage imageWithCGImage:cgImage];
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(dataProviderRef);
    
    // カメラデバイスの初期化
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 入力の初期化
    NSError *error = nil;
    AVCaptureInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice
                                                                         error:&error];
    
    if (!captureInput) {
        NSLog(@"ERROR:%@", error);
        return;
    }
    
    // セッション初期化
    //AVCaptureSession *captureSession = [[AVCaptureSession alloc] init];
    
    captureImageSession = [[AVCaptureSession alloc] init];
    
    [captureImageSession addInput:captureInput];
    [captureImageSession beginConfiguration];
    //    captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    captureImageSession.sessionPreset = AVCaptureSessionPreset640x480;
    [captureImageSession commitConfiguration];
    
    // プレビュー表示
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureImageSession];
    // previewLayer.automaticallyAdjustsMirroring = NO;
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //previewLayer.frame = self.view.bounds;
    previewLayer.frame = self.imagePreview.bounds;
    
    //[self.imagePreview.layer insertSublayer:previewLayer atIndex:0];
    [[previewLayer connection] setAutomaticallyAdjustsVideoMirroring:YES];
    [self.imagePreview.layer addSublayer:previewLayer];
    
    // 出力の初期化
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    [captureImageSession addOutput:videoOutput];
    
    // ビデオデータ取得方法の設定
    videoOutput.videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    AVCaptureConnection *connection = [[videoOutput connections] lastObject];
    connection.videoMaxFrameDuration = CMTimeMake(1, 20);	// 20fps
    videoOutput.alwaysDiscardsLateVideoFrames = YES;
    dispatch_queue_t queue = dispatch_queue_create("com.overout223.myQueue", NULL);
    [videoOutput setSampleBufferDelegate:self
                                   queue:queue];
    //dispatch_release(queue);
    
    
    // セッション開始
    [captureImageSession startRunning];
}



#pragma mark -------------------------------------------------------------------
#pragma mark AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection {
    
    if (isRequireTakePhoto) {
        
        isRequireTakePhoto = NO;
        isProcessingTakePhoto = YES;
        
        CVPixelBufferRef pixbuff = CMSampleBufferGetImageBuffer(sampleBuffer);
        
        UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
        UIImage *rotatedImage = [self imageRotatedByDegrees:image deg:90];
        
        NSString *dataPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])    {
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
            NSLog(@"dataPath1 = %@ \n",dataPath);
        }
        
        NSString *imageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media/"];
        // NSString*fileNmae=@"myphoto%d";
        
        
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyyMMddHHmmss"];
        NSDate *now = [NSDate date];
        NSString *retStr = [format stringFromDate:now];
        NSLog(@"return string%@",retStr);
        
        NSString *savedImagePath = [imageFilePath
                                    stringByAppendingPathComponent:retStr];
        
        imageFilePath = [savedImagePath stringByAppendingString:@".png"];
        
        NSFileManager *fileManage = [NSFileManager defaultManager];
        
        [fileManage createFileAtPath:imageFilePath contents:nil attributes:nil];
        
        NSLog(@"image file path : %@", imageFilePath);
        
        NSData* data = UIImagePNGRepresentation(rotatedImage);
        //[data writeToFile:path atomically:YES];
        
        [data writeToFile:imageFilePath atomically:YES];
        
        isProcessingTakePhoto = NO;
        
        
        
        
        
        
        
        
    }
}


- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    return (image);
    
}



- (UIImage *)imageRotatedByDegrees:(UIImage*)oldImage deg:(CGFloat)degrees{
    //Calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,oldImage.size.width, oldImage.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degrees * M_PI / 180);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    //Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    //Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //Rotate the image context
    CGContextRotateCTM(bitmap, (degrees * M_PI / 180));
    
    //Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-oldImage.size.width / 2, -oldImage.size.height / 2, oldImage.size.width, oldImage.size.height), [oldImage CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
