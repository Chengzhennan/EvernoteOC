//
//  PresentDelegate.h
//  印象笔记 OC
//
//  Created by Mac on 2017/5/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYCollectionViewCell;

@interface PresentAnimation : NSObject<UIViewControllerAnimatedTransitioning>

-(void)configVisibleCells:(NSArray *)visibleCells selectedCell:(MYCollectionViewCell *)selCell originalFrame:(CGRect)originalFrame finalFrame:(CGRect)finalFrame gestureVC:(UIViewController *)gestureVC collectionVC:(UIViewController *)colVC;

@end
