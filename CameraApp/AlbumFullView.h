//
//  AlbumFullView.h
//  CameraApp
//
//  Created by annutech on 2/12/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "VideoPlayer.h"
#import "DeleteSaveView.h"
#import "NADView.h"
@class GADBannerView;

@interface AlbumFullView : UIViewController<UIImagePickerControllerDelegate,NADViewDelegate,GADBannerViewDelegate>

{
 NSString* receivedFileName;
   NSArray* receivedArray;
    int receivedposition;
    NSString*fileToSaveDelete;
    GADBannerView * bannerView;

}
@property (nonatomic) NSString* receivedFile;
@property (nonatomic) NSArray* receivedArray;
@property (nonatomic) int receivedposition;
@property (weak, nonatomic) IBOutlet UIImageView *albumImage;
@property (strong, atomic) ALAssetsLibrary* library;
@property (weak, nonatomic) IBOutlet GADBannerView *globalAdview;
@property (nonatomic, retain) GADBannerView * bannerView;

@end
