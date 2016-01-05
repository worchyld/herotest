//
//  ImageDownloader.h
//  herotest
//
//  Created by Amarjit on 05/01/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const kUrlString;

@interface ImageDownloader : NSObject

+ (instancetype)sharedClient;
- (UIImageView *) downloadImage;

@end
