//
//  ViewController.m
//  herotest
//
//  Created by Amarjit on 04/01/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

#import "ViewController.h"
#import "HeroCollectionViewCell.h"
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

    // Initial test to see if URL consumption is working
    ImageDownloader *imageDownloaderObj = [[ImageDownloader alloc] init];
    [imageDownloaderObj downloadPlaceholder];
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

    // from: http://stackoverflow.com/a/24884921/4883632
    CGFloat hue = ( arc4random() % 256 / 256.0 ); // 0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    cell.backgroundColor = color;

    NSString *urlString = @"https://placeholdit.imgix.net/~text?txtsize=20&txt=100%C3%97100&w=100&h=100";
    NSURL *url = [NSURL URLWithString:urlString];

    // Block variable to be assigned in block.
    __block NSData *imageData;
    dispatch_queue_t backgroundQueue  = dispatch_queue_create("imagegrabber.bgqueue", NULL);

    // Dispatch a background thread for download
    dispatch_async(backgroundQueue, ^(void) {
        imageData = [NSData dataWithContentsOfURL:url];
        UIImage *imageLoad = [[UIImage alloc] initWithData:imageData];

        // Update UI on main thread
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [cell.imageView setImage:imageLoad];
        });
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
