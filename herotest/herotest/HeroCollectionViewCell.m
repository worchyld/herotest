//
//  HeroCollectionViewCell.m
//  herotest
//
//  Created by Amarjit on 04/01/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

#import "HeroCollectionViewCell.h"

@implementation HeroCollectionViewCell

- (instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
    }
    return self;
}


- (void)prepareForReuse
{
    [super prepareForReuse];
    self.selected=NO;
}

@end
