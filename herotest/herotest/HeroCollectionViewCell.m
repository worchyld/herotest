//
//  HeroCollectionViewCell.m
//  herotest
//
//  Created by Amarjit on 04/01/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

#import "HeroCollectionViewCell.h"
#import "ViewController.h"


static const CGFloat kInitialAnimationDelta = 0.5f;
static const CGFloat kFadeInAnimationDelta = 1.5f;


@implementation HeroCollectionViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.selected=NO;
}


-(void) initializeWithBox:(Box*)box
{
    [self setBackgroundColor:[box bgColor]];

    NSURL *url = [NSURL URLWithString:kUrlString];
    __weak typeof(self) weakSelf = self;

    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (data)
        {
            UIImage *image = [UIImage imageWithData:data];

            if (image)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    typeof(self) strongSelf = weakSelf;
                    if(strongSelf)
                    {
                        [self.imageView setImage:image];

                        // Animate imageview setup
                        [UIView animateWithDuration:kInitialAnimationDelta animations:^{
                            self.imageView.alpha = 0;
                        } completion:^(BOOL finished) {
                            if (finished == YES)
                            {
                                // Fade in animation
                                [UIView animateWithDuration:kFadeInAnimationDelta animations:^{
                                    self.imageView.alpha = 1;
                                }];
                            }
                        }];
                    }
                });
            }
        }
    }];
    [task resume];
}

@end
