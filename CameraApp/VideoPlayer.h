//
//  VideoPlayer.h
//  Download
//
//  Created by Admin on 2/19/15.
//  Copyright (c) 2015 CWD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/Mediaplayer.h>
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerLayer.h>
#import <AVFoundation/AVFoundation.h>
#import "DeleteSaveView.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
@interface VideoPlayer : UIViewController<GADInterstitialDelegate> {

    AVPlayerLayer *playerLayer;
    AVPlayer *player;
    NSString *videoFileName;
    UITapGestureRecognizer *singleTapGestureRecognizer;

    __weak IBOutlet UIView *videoPlayerContainer;
    
    NSFileManager *fileManage;
    NSString *imageFilePath;
    
    NSMutableArray *tempContents;
    NSString *FilePath;
    NSMutableArray*deleteArrayupdate;
    UIImage* didselectImage;
    NSTimer	*hideControlsTimer; 
    
}
@property(nonatomic,retain)AVPlayerLayer *playerLayer;
@property(nonatomic,retain)AVPlayer *player;
@property(nonatomic,retain) NSString *videoFileName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
- (IBAction)saveVideo:(id)sender;
@property (nonatomic) MPMusicPlaybackState playbackState;


@end
