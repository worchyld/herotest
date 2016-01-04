//
//  ViewController.m
//  herotest
//
//  Created by Amarjit on 04/01/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

#import "ViewController.h"

NSInteger const kNumberOfCells = 10;
NSString *const cellId = @"collectionCellReuseId";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *pictures;
@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self.pictures) self.pictures = [NSMutableArray arrayWithCapacity:kNumberOfCells];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 20.0f;
    flowLayout.minimumLineSpacing = 10.0f;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
    flowLayout.headerReferenceSize = CGSizeZero;

    [self.collectionView setCollectionViewLayout:flowLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    [self.pictures removeAllObjects];
    self.pictures = nil;
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
    UICollectionViewCell *cell = (UICollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    NSInteger item = (arc4random() %10) + 4;

    switch (item)
    {
        case 1:
            cell.backgroundColor = [UIColor redColor];
            break;
        case 2:
            cell.backgroundColor = [UIColor yellowColor];
            break;
        case 3:
            cell.backgroundColor = [UIColor blackColor];
            break;
        default:
            cell.backgroundColor = [UIColor blueColor];
            break;
    }

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (cell.selected) {
        cell.selected = YES;
    }

    // Move the item to the end of the collectionview
}


@end
