//
//  DeleteSaveView.h
//  CameraApp
//
//  Created by annutech on 3/9/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "NADView.h"
#import "NADInterstitial.h" 
@class GADBannerView;
@interface DeleteSaveView : UIViewController<NADViewDelegate>

{
    NSFileManager *fileManage;
    NSString *imageFilePath;

NSString *videoFileName;
    NSMutableArray *tempContents;
    NSMutableArray*deleteArrayupdate;
     NSString *FilePath;
     UIImage* didselectImage;
}
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)saveAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
- (IBAction)deleteAction:(id)sender;
@property(nonatomic,retain) NSString *videoFileName;
@property (weak, nonatomic) IBOutlet UIView *globalAdview;

@property (nonatomic, retain) NADView * nadView;

@property (nonatomic, retain) GADBannerView * bannerView;
@end
