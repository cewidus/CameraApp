//
//  ApSDKAd.h
//  AMoAdSDK
//
//  Copyright © CyberAgent, Inc. All Rights Reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APSDKAd : NSObject
@property (nonatomic, readonly) NSString *appKey;
@property (nonatomic, readonly) NSString *appName;
@property (nonatomic, readonly) NSString *appText;
@property (nonatomic, readonly) NSString *image;
@property (nonatomic, readonly) NSString *imageType;
@property (nonatomic, readonly) NSString *pAppKey;


#define APSDK_LOW_LEVEL_API_AD_IMAGE_TYPE_URL_STRING            @"AP_LOW_LEVEL_API_AD_IMAGE_TYPE_URL_STRING"
#define APSDK_LOW_LEVEL_API_AD_IMAGE_TYPE_BASE64_ENCODED_STRING @"AP_LOW_LEVEL_API_AD_IMAGE_TYPE_BASE64_ENCODED_STRING"


+(NSArray*)getFromAdsDictionaries:(NSArray*)adsJSONDictionaries publisherAppKey:(NSString*)publisherAppKey;
+(APSDKAd*)getFromDictionary:(NSDictionary*)dic publisherAppKey:(NSString*)publisherAppKey;
-(UIImage*)getImage;

@end
