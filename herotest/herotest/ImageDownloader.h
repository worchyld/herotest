//
//  ImageDownloader.h
//  herotest
//
//  Created by Amarjit on 04/01/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

// Use placehold.it and download image(s)

#import <Foundation/Foundation.h>

extern NSString *const urlToConsume;

@interface ImageDownloader : NSObject

-(void) downloadPlaceholder;

@end
