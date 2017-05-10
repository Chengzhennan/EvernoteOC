//
//  MYCollectionViewController.m
//  印象笔记 OC
//
//  Created by Mac on 2017/5/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "MYCollectionViewController.h"
#import "MYCellLayout.h"
#import "MYCollectionViewCell.h"
#import "MYNoteViewController.h"
#import "TransitionDelegate.h"

#define  screenW    [UIScreen mainScreen].bounds.size.width
#define  screenH    [UIScreen mainScreen].bounds.size.height
#define  space      10


@interface MYCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic,weak)UICollectionView *collectionView;
@property (nonatomic,strong)TransitionDelegate *transition;
///是否允许cell被点击
@property (nonatomic,assign)BOOL shouldSelectCell;

@end

@implementation MYCollectionViewController

static NSString * const reuseIdentifier = @"Cell";


-(instancetype)init
{
    if ([super init])
    {
        _transition = [[TransitionDelegate alloc]init];
        
    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.shouldSelectCell = YES;
  
    UICollectionView *colV = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[MYCellLayout new]];
    colV.dataSource = self;
    colV.delegate = self;
    self.collectionView = colV;
    [self.view addSubview:colV];
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    [self.collectionView registerClass:[MYCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 70;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"笔记本%ld",indexPath.section];
    cell.tag = indexPath.section;
    
    cell.backgroundColor = [UIColor whiteColor];

    
    return cell;
}




#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];

    if (self.shouldSelectCell)
    {
        
        NSArray *cellsArr = collectionView.visibleCells;
        MYCollectionViewCell *selCell = (MYCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        CGRect originalFrame = selCell.frame;
        
        
        CGRect finalFrame = CGRectMake(space, collectionView.contentOffset.y + space, screenW - 2 *space, screenH - 40);
        
        
        MYNoteViewController *noteVC = [[MYNoteViewController alloc]init];
        noteVC.centerTitle = selCell.titleLabel.text;
        noteVC.dataSource = selCell.dataSource;
        
        [self.transition configVisibleCells:cellsArr selectedCell:selCell  originalFrame:originalFrame finalFrame:finalFrame  gestureVC:noteVC collectionVC:self];
        
        
        
        noteVC.transitioningDelegate =  self.transition;
        
        
        [self presentViewController:noteVC animated:YES
                         completion:nil];
        
        
        
  
    }
    
    

}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{

    NSLog(@"scrollViewDidEndScrollingAnimation");
    self.shouldSelectCell = YES;


}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    NSLog(@"scrollViewDidEndDecelerating");
    self.shouldSelectCell = YES;


}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    NSLog(@"scrollViewDidEndDragging");
    self.shouldSelectCell = YES;


}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    NSLog(@"我还在滑动中,滑啊,滑啊,滑");
    self.shouldSelectCell = NO;

}


@end
