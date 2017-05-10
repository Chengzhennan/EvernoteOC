//
//  TransitionDelegate.m
//  印象笔记 OC
//
//  Created by Mac on 2017/5/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

//
#import "DismissAnimation.h"
#import "TransitionDelegate.h"
#import "PresentAnimation.h"
#import "MYCollectionViewCell.h"
#import "GestureAnimation.h"
@interface TransitionDelegate ()

@property (nonatomic,strong)PresentAnimation *presentAnimation;
@property (nonatomic,strong)UIViewController *collectionVC;
@property (nonatomic,strong)DismissAnimation *dismissAnimation;
@property (nonatomic, strong) GestureAnimation *gestureAnimation;


@end

@implementation TransitionDelegate

-(instancetype)init
{

    if ([super init])
    {
        _presentAnimation = [[PresentAnimation alloc]init];
        _dismissAnimation = [[DismissAnimation alloc]init];
        _gestureAnimation = [[GestureAnimation alloc]init];
    }

    return self;
}


-(void)configVisibleCells:(NSArray *)visibleCells selectedCell:(MYCollectionViewCell *)selCell originalFrame:(CGRect)originalFrame finalFrame:(CGRect)finalFrame gestureVC:(MYNoteViewController *)gestureVC collectionVC:(UIViewController *)colVC
{
    [self.presentAnimation configVisibleCells:visibleCells selectedCell:selCell originalFrame:originalFrame finalFrame:finalFrame gestureVC:nil collectionVC:colVC];
    
    [self.dismissAnimation configVisibleCells:visibleCells selectedCell:selCell originalFrame:originalFrame finalFrame:finalFrame gestureVC:gestureVC collectionVC:colVC];
    
    [self.gestureAnimation handleGestureViewController:gestureVC andCollectionVC:colVC];

    
    

    self.collectionVC = colVC;



}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
        return self.presentAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissAnimation;

}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.gestureAnimation.isInteracting ? self.gestureAnimation : nil;

}



@end
