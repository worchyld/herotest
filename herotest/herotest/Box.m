//
//  Box.m
//  herotest
//
//  Created by Amarjit on 05/01/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

#import "Box.h"


@implementation Box

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // from: http://stackoverflow.com/a/24884921/4883632
        CGFloat hue = ( arc4random() % 256 / 256.0 ); // 0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from black
        self.bgColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    }
    return self;
}

@end
