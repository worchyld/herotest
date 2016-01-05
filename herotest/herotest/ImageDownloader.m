//
//  ImageDownloader.m
//  herotest
//
//  Created by Amarjit on 05/01/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

#import "ImageDownloader.h"
#import <UIKit/UIKit.h>

NSString *const kUrlString = @"https://placeholdit.imgix.net/~text?txtsize=20&txt=100%C3%97100&w=100&h=100";

static ImageDownloader *_sharedClient = nil;

@implementation ImageDownloader

#pragma mark Singleton Methods

+ (instancetype)sharedClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
    });

    return _sharedClient;
}

+(UIImage *) downloadImage
{
    NSURL *url = [NSURL URLWithString:kUrlString];

    // Block variable to be assigned in block.
    __block NSData *imageData;
    __block UIImage *image;

    dispatch_queue_t backgroundQueue  = dispatch_queue_create("imagegrabber.bgqueue", NULL);

    // Dispatch a background thread for download
    dispatch_async(backgroundQueue, ^(void) {
        imageData = [NSData dataWithContentsOfURL:url];
        if (imageData.length >0)
        {
            image  = [[UIImage alloc] initWithData:imageData];

            // Update UI on main thread
            dispatch_async(dispatch_get_main_queue(), ^(void) {

            });
        }
        else {
            image = nil;
        }
    });

    return image;
}

@end
