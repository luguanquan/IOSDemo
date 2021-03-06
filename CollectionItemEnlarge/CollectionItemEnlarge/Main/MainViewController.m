//
//  MainViewController.m
//  CollectionItemEnlarge
//
//  Created by LGQ on 14-5-15.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

#import "MainViewController.h"
#import "ZRCollectionViewCell.h"
#import "ZRCardView.h"
#import "ZRPopoverView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_collectionView registerNib:[UINib nibWithNibName:@"ZRCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ZRCollectionViewCellIdentify];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self initData];
    [_collectionView reloadData];
}

- (void)initData{
    _dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; i++) {
        NSString* item = [NSString stringWithFormat:@"Item %d", i];
        [_dataArray addObject:item];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// UICollectionViewDataSource UICollectionDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_dataArray) {
        return [_dataArray count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZRCollectionViewCell* cell = [_collectionView dequeueReusableCellWithReuseIdentifier:ZRCollectionViewCellIdentify forIndexPath:indexPath];
    if ([_dataArray count] > indexPath.row &&[[_dataArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        [cell setContent:[_dataArray objectAtIndex:indexPath.row]];
        [cell showContent];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //TODO:
    ZRCardView* cardView = [[ZRCardView alloc] init];
    [cardView setContent:[_dataArray objectAtIndex:indexPath.row]];
    [cardView showContent];
   
    ZRCollectionViewCell *cell = [[_collectionView subviews] objectAtIndex:indexPath.row];
    if ([cell isKindOfClass:[ZRCollectionViewCell class]]) {
        CGRect frame = cell.frame;
        CGPoint point = CGPointMake(frame.origin.x + frame.size.width/2, frame.origin.y + frame.size.height/2);
        [ZRPopoverView showPopoverAtPoint:point inView:self.view withContentView:cardView];
        NSLog([NSString stringWithFormat:@"X:%f,Y:%f,Width:%f,Height:%f",frame.origin.x, frame.origin.y, frame.size.width, frame.size.height]);
    }
    
}

@end
