//
//  HeroCollectionViewCell.m
//  herotest
//
//  Created by Amarjit on 04/01/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

#import "HeroCollectionViewCell.h"

@implementation HeroCollectionViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.selected=NO;
}

@end
