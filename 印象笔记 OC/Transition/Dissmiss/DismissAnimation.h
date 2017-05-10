//
//  DismissAnimation.h
//  印象笔记 OC
//
//  Created by Mac on 2017/5/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYCollectionViewCell;
@class MYNoteViewController;

@interface DismissAnimation : NSObject<UIViewControllerAnimatedTransitioning>

-(void)configVisibleCells:(NSArray *)visibleCells selectedCell:(MYCollectionViewCell *)selCell originalFrame:(CGRect)originalFrame finalFrame:(CGRect)finalFrame gestureVC:(MYNoteViewController *)gestureVC collectionVC:(UIViewController *)colVC;

@end
