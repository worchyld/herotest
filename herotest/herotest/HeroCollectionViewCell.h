//
//  HeroCollectionViewCell.h
//  herotest
//
//  Created by Amarjit on 04/01/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Box.h"

@interface HeroCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
-(void) initializeWithBox:(Box*)box;

@end
