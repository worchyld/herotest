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
    cell.imageView.image = box.image;

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
