//
//  GestureAnimation.h
//  印象笔记 OC
//
//  Created by Mac on 2017/5/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYNoteViewController;
@interface GestureAnimation : UIPercentDrivenInteractiveTransition
@property (nonatomic,assign)BOOL isInteracting;

-(void)handleGestureViewController:(MYNoteViewController *)controller andCollectionVC:(UIViewController *)colVC;

@end
