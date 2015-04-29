//
//  DarknessView.m
//  CameraApp
//
//  Created by annutech on 2/11/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//
@import GoogleMobileAds;


#import "DarknessView.h"
#import "GAI.h"
#import <Parse/Parse.h>
#import "GAIDictionaryBuilder.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"
#define DegreesToRadians(x) ((x) * M_PI / 180.0)

@interface DarknessView ()
@property (weak, nonatomic) IBOutlet UIButton *videoButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) UIImage *imageBuffer;

@end

@implementation DarknessView
@synthesize stillImageOutput, imagePreview,darkView,buttonView,interstitial,bannerView;
bool isShown = false;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Darkness View"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    [tracker set:kGAIScreenName value:nil];

    
    darkView = [[UIView alloc]init];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRotate:)
                                                 name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    
    
    
    
     [self.buttonView setHidden:YES];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    // Do any additional setup after loading the view.
    
   

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean ispasscodeOn =    [defaults boolForKey:@"isVibrateOn"];
    NSLog(@"switchcase%d",ispasscodeOn);
    
  
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.view addGestureRecognizer:gestureRecognizer];
    UISwipeGestureRecognizer *downGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandlerDown:)];
    [downGestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:downGestureRecognizer];
    self.cameraButton.hidden = TRUE;
    self.videoButton.hidden = TRUE;
    self.cancelButton.hidden = TRUE;
    
    
}


-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Swipe received.");
    
    // to show (implement in another method)
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.cameraButton.alpha = 1.0;
                         self.videoButton.alpha = 1.0;
                         self.cancelButton.alpha=1.0;
                     } 
                     completion:^(BOOL finished){
                         NSLog(@"Not done!");
                          self.cameraButton.hidden=FALSE;
                         self.videoButton.hidden=FALSE;
                         self.cancelButton.hidden=FALSE;
                     }];
    
   
}

-(void)swipeHandlerDown:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Swipe received down.");
    
    
    
    
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.cameraButton.alpha = 0.0;
                         self.videoButton.alpha = 0.0;
                         self.cancelButton.alpha=0.0;
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                         self.cameraButton.hidden=TRUE;
                         self.videoButton.hidden=TRUE;
                         self.cancelButton.hidden=TRUE;
                         
                         
                     }];
}

-(void)didRotate:(NSNotification *)notification
{
    
    UIDeviceOrientation  orientation = [[UIDevice currentDevice] orientation];
    if ((orientation == UIDeviceOrientationLandscapeLeft)||(orientation == UIDeviceOrientationLandscapeRight))
    {
        CGFloat heigt= self.imagePreview.frame.size.height;
        CGFloat width=self.imagePreview.frame.size.width;
        
        NSLog(@"height:%f :%f", width,heigt);
        
        [self.darkView setFrame:CGRectMake(0, 0, width,heigt)];
        
        
        //currentOrientation = @"landscape";
        
    }
    if((orientation == UIDeviceOrientationPortrait)||(orientation == UIDeviceOrientationPortraitUpsideDown))
    {
        
        CGFloat heigt= self.imagePreview.frame.size.height;
        CGFloat width=self.imagePreview.frame.size.width;
        
        NSLog(@"height:%f :%f", width,heigt);
        [self.darkView setFrame:CGRectMake(0, 0, width,heigt)];
        
        //currentOrientation = @"portrait";
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSUserDefaults *getAlert = [NSUserDefaults standardUserDefaults];
    Boolean isalerton =    [getAlert boolForKey:@"isAlertDialogue"];
   
    if(isalerton == TRUE)
        
    {      
        
        
        
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"黒い部分をタップすると写真を撮影します"
                                    message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"以後表示しない"
                                              otherButtonTitles:@"確認", nil];
        
        [alert show];
        
    }

}

- (void) initializeCamera {
    
    [self initCamera];
    
    
}


- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    
    if(cameraMode == TRUE)
        
    {
        
        [self recordVideo];
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        Boolean ispasscodeOn =    [defaults boolForKey:@"isVibrateOn"];
        
        NSLog(@"vid condition:%@",ispasscodeOn ? @"YES":@"NO");
        if(ispasscodeOn == FALSE)
            
        {
            
            if([[UIDevice currentDevice].model isEqualToString:@"iPhone"])
            {
                AudioServicesPlaySystemSound (1352); //works ALWAYS as of this post
            }
            else
            {
                
                AudioServicesPlayAlertSound (1105);
            }
            
        }
    }
    
    else
    {
        
        if (!isProcessingTakePhoto) {
            
            isRequireTakePhoto = YES;
        }
        

        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        Boolean ispasscodeOn =    [defaults boolForKey:@"isVibrateOn"];
        if(ispasscodeOn==FALSE)
            
        {
            
            if([[UIDevice currentDevice].model isEqualToString:@"iPhone"])
            {
                AudioServicesPlaySystemSound (1352); //works ALWAYS as of this post
            }
            else
            {
               
                AudioServicesPlayAlertSound (1105);
            }
            
        }
        
        
    }
    
    
    
   
  
    self.buttonView.hidden = NO;


}
- (void)setupAudio {
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
    UInt32 doSetProperty = 1;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof(doSetProperty), &doSetProperty);
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
}

- (void) capImage { //method to capture image from AVCaptureSession video feed
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean ispasscodeOn =    [defaults boolForKey:@"isVibrateOn"];
    NSLog(@"switchcase%d",ispasscodeOn);
    if(ispasscodeOn==TRUE)
        
    {
        [self setupAudio];
    }
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

- (void)vibrate {
    NSLog(@"I'm vibrating");
    AudioServicesPlaySystemSound (4095);
   // AudioServicesPlaySystemSoundWithVibration(4095,nil,dict);
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
    
    [captureImageSession startRunning];
    [CaptureSession stopRunning];
    
    [self initializeVideoCamera];
    
    cameraMode = TRUE;
    
    self.videoButton.highlighted = TRUE;
    self.cameraButton.highlighted = FALSE;
    
    self.videoButton.selected = TRUE;
    self.cameraButton.selected = FALSE;
    
    [self.cameraButton setImage:[UIImage imageNamed:@"icon_camera_off.png"] forState:UIControlStateNormal];
    [self.videoButton setImage:[UIImage imageNamed:@"icon_video_on.png"] forState:UIControlStateNormal];

    
    
}

- (void) initializeVideoCamera
{
    
    NSLog(@"Setting up capture session");
    CaptureSession = [[AVCaptureSession alloc] init];
    
    //----- ADD INPUTS -----
    NSLog(@"Adding video input");
    
    //ADD VIDEO INPUT
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
    NSLog(@"Adding audio input");
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
    
   
   
    CGFloat heigt= self.imagePreview.frame.size.height;
    CGFloat width=self.imagePreview.frame.size.width;
    

    darkView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, width, heigt)];
    
    darkView.backgroundColor = [UIColor blackColor];    //add code to customize, e.g. polygonView.backgroundColor = [UIColor blackColor];
    
    [imagePreview addSubview:darkView];
    
    
    //ADD MOVIE FILE OUTPUT
    NSLog(@"Adding movie file output");
    MovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    
    Float64 TotalSeconds = 60;			//Total seconds
    int32_t preferredTimeScale = 30;	//Frames per second
    CMTime maxDuration = CMTimeMakeWithSeconds(TotalSeconds, preferredTimeScale);	//<<SET MAX DURATION
    MovieFileOutput.maxRecordedDuration = maxDuration;
    
    MovieFileOutput.minFreeDiskSpaceLimit = 1024 * 1024;						//<<SET MIN FREE SPACE IN BYTES FOR RECORDING TO CONTINUE ON A VOLUME
    
    if ([CaptureSession canAddOutput:MovieFileOutput])
        [CaptureSession addOutput:MovieFileOutput];
    
    [self CameraSetOutputProperties];
    //----- START THE CAPTURE SESSION RUNNING -----
    [CaptureSession startRunning];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
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
        //----- START RECORDING -----
        NSLog(@"START RECORDING");
        WeAreRecording = YES;
        
        NSString *dataPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])    {
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
            NSLog(@"dataPath1 = %@ \n",dataPath);
        }
        
        NSString *videoFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media/"];
        // NSString*fileNmae=@"myphoto%d";
        
        
        
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
        
        //[MovieFileOutput writeToFile:videoFilePath atomically:YES];
        
        [MovieFileOutput startRecordingToOutputFileURL:outputURL recordingDelegate:self];
        
        
        NSLog(@"outputPath%@",outputURL);
    }
    else
    {
        
        
        WeAreRecording = NO;
        
        [MovieFileOutput stopRecording];
    }
    
}

- (IBAction)CameraAction:(id)sender {
    
    [captureImageSession startRunning];
    [CaptureSession stopRunning];
    
    [self initializeCamera];
   
    cameraMode = FALSE;
    
    self.videoButton.highlighted = FALSE;
    self.cameraButton.highlighted = TRUE;
    
    self.videoButton.selected = FALSE;
    self.cameraButton.selected = TRUE;
    [self.cameraButton setImage:[UIImage imageNamed:@"icon_camera_on.png"] forState:UIControlStateNormal];
    [self.videoButton setImage:[UIImage imageNamed:@"icon_video_off.png"] forState:UIControlStateNormal];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
   
    
    if (buttonIndex == 0)
    
    {
        NSUserDefaults *AlertViewDialog = [NSUserDefaults standardUserDefaults];
        [AlertViewDialog setBool:TRUE forKey:@"isAlertDialogue"];
        [AlertViewDialog synchronize];
    }
    
        
    
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
    //[self.imagePreview.layer addSublayer:previewLayer];
    
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
