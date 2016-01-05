//
//  ViewController.m
//  herotest
//
//  Created by Amarjit on 04/01/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

#import "ViewController.h"
#import "HeroCollectionViewCell.h"
#import "Box.h"
#import "ImageDownloader.h"

NSInteger const kNumberOfCells = 10;
NSString *const cellId = @"collectionCellReuseId";


@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *picturesArray;
@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self.picturesArray) self.picturesArray = [NSMutableArray arrayWithCapacity:kNumberOfCells];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];

    for (int i=0; i<kNumberOfCells; i++)
    {
        Box *box = [[Box alloc] init];
        [self.picturesArray addObject:box];
        box = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    [self.picturesArray removeAllObjects];
    self.picturesArray = nil;
}

#pragma mark - UICollectionView Delegate methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kNumberOfCells;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroCollectionViewCell *cell = (HeroCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    Box *box = self.picturesArray[indexPath.row];
    
    cell.backgroundColor = box.bgColor;


    NSURL *url = [NSURL URLWithString:kUrlString];

    // Block variable to be assigned in block.
    __block NSData *imageData;

    dispatch_queue_t backgroundQueue  = dispatch_queue_create("imagegrabber.bgqueue", NULL);

    // Dispatch a background thread for download
    dispatch_async(backgroundQueue, ^(void) {
        imageData = [NSData dataWithContentsOfURL:url];
        if (imageData.length >0)
        {
            UIImage *image  = [[UIImage alloc] initWithData:imageData];

            // Update UI on main thread
            dispatch_async(dispatch_get_main_queue(), ^(void)
            {
                cell.imageView.image = image;

                // Animate imageview setup
                [UIView animateWithDuration:0.5f animations:^{
                    cell.imageView.alpha = 0;
                } completion:^(BOOL finished) {
                    if (finished == YES)
                    {
                        // Fade in
                        [UIView animateWithDuration:1.5f animations:^{
                            cell.imageView.alpha = 1;
                        } completion:^(BOOL finished) {
                        }];
                    }
                }];
            });
        }
    });

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (cell.selected)
    {
        NSLog(@"Selected cell #%ld", (long)indexPath.row);
    }
}



@end
