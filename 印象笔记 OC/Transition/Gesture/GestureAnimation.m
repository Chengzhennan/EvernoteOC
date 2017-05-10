//
//  GestureAnimation.m
//  印象笔记 OC
//
//  Created by Mac on 2017/5/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "GestureAnimation.h"
#import "MYNoteViewController.h"
#import "MYCollectionViewController.h"


@interface GestureAnimation ()
@property (nonatomic,strong)UIViewController *presentingController;
@property (nonatomic,assign)BOOL shouldComplete;
@property (nonatomic,strong)MYCollectionViewController *collectionVC;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) CGFloat percent;
@property (nonatomic, assign) CGFloat timeDis;
@end

@implementation GestureAnimation

-(void)handleGestureViewController:(MYNoteViewController *)controller andCollectionVC:(MYCollectionViewController *)colVC
{
    self.presentingController = controller;
    [self prepareGestureRecongnizerInview:controller.view];
    self.collectionVC = colVC;


}

-(void)prepareGestureRecongnizerInview:(UIView *)view
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    
    [view addGestureRecognizer:pan];
    
    
}


-(void)handleGesture:(UIPanGestureRecognizer *)pan
{
    
    CGPoint translation = [pan translationInView:pan.view.superview];
    
    
    
    switch (pan.state)
    {
            
        case UIGestureRecognizerStateBegan:
        {
            self.isInteracting = YES;
            //正在转场中, 不与用户交互
            self.collectionVC.view.userInteractionEnabled = NO;
            self.presentingController.view.userInteractionEnabled = NO;
            [self.presentingController dismissViewControllerAnimated:YES completion:nil];
            break;
        }
            
            
        case UIGestureRecognizerStateChanged:
        {
            CGFloat fraction = translation.x / [UIScreen mainScreen].bounds.size.width;
            // 取值0-1 并且过滤掉负值
            fraction =  fminf(fmaxf(fraction, 0.0), 1.0);
            _percent = fraction;
            self.shouldComplete = (fraction > 0.7);
            [self updateInteractiveTransition:fraction];
            
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            
            self.isInteracting = NO;

            if (!self.shouldComplete || pan.state == UIGestureRecognizerStateCancelled) //如果拖动比例不足
            {
                //开启timer
                [self _xw_setEndAnimationTimerWithPercent:_percent];
//                [self cancelInteractiveTransition];

                
            }else
            {
                self.presentingController.view.userInteractionEnabled = YES;
                self.collectionVC.view.userInteractionEnabled = YES;
                [self finishInteractiveTransition];
            }
            
            break;
        }
            
        default:
            break;
    }
    
    
}



//设置开启timer
- (void)_xw_setEndAnimationTimerWithPercent:(CGFloat)percent
{
    _percent = percent;
    _timeDis = percent / (percent * 60);
    //开启timer
    [self _xw_startTimer];
}


- (void)_xw_startTimer{
    if (_timer) {
        return;
    }
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(_xw_timerEvent)];
    [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

//timer 事件
- (void)_xw_timerEvent{
    
    _percent -= _timeDis;
    //通过timer不断刷新转场进度
    [self _xw_updatingWithPercent:_percent];
    BOOL canEnd = [self _xw_canEndInteractiveTransitionWithPercent:_percent];
    if (canEnd) {
        [self _xw_stopTimer];
    }
}

- (void)_xw_stopTimer{
    if (!_timer) {
        return;
    }
    [_timer invalidate];
    _timer = nil;
    
}
- (void)_xw_updatingWithPercent:(CGFloat)percent{
    [self updateInteractiveTransition:percent];
    
}





- (BOOL)_xw_canEndInteractiveTransitionWithPercent:(CGFloat)percent{
    BOOL can = NO;
    if (percent <= 0)
    {
        [self _xw_cancle];
        can = YES;
    }
    return can;
}






- (void)_xw_cancle{
    
    [self cancelInteractiveTransition];
    self.presentingController.view.userInteractionEnabled = YES;
    self.collectionVC.view.userInteractionEnabled = YES;

    _percent = 0.0f;
    _isInteracting = NO;
}




@end
