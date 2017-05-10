//
//  DismissAnimation.m
//  印象笔记 OC
//
//  Created by Mac on 2017/5/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "DismissAnimation.h"
#import "MYCollectionViewCell.h"
#import "MYNoteViewController.h"
@interface DismissAnimation ()

@property (nonatomic,strong)NSArray *visibleCellArr;
@property (nonatomic,assign)CGRect originalFrame;
@property (nonatomic,assign)CGRect finalFrame;

@property (nonatomic,strong)MYCollectionViewCell *selectCell;

@property (nonatomic, strong)MYNoteViewController* gestureVC;
@property (nonatomic, strong)UIViewController* colVC;

@end

@implementation DismissAnimation

-(void)configVisibleCells:(NSArray *)visibleCells selectedCell:(MYCollectionViewCell *)selCell originalFrame:(CGRect)originalFrame finalFrame:(CGRect)finalFrame gestureVC:(MYNoteViewController *)gestureVC collectionVC:(UIViewController *)colVC
{

    self.gestureVC = gestureVC;
    self.colVC = colVC;

    self.visibleCellArr = visibleCells;
    self.selectCell = selCell;
    self.originalFrame = originalFrame;
    self.finalFrame = finalFrame;
    
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}



-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    //要回到的的控制器
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    MYNoteViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
 
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];

    CGRect labelOriFrame = CGRectMake(CGRectGetMaxX(self.selectCell.imageView.frame) + 15, self.selectCell.titleLabel.frame.origin.y, self.selectCell.titleLabel.frame.size.width, self.selectCell.titleLabel.frame.size.height);
    
    
    self.selectCell.tableView.contentOffset = CGPointMake(0,fromVC.contentOffsetY) ;
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        for (MYCollectionViewCell *visibleCell in self.visibleCellArr)
        {
            
            if (self.selectCell != visibleCell)
            {
                CGRect frame = visibleCell.frame;
                if (visibleCell.tag < self.selectCell.tag)
                {
                    CGFloat distance = self.originalFrame.origin.y - self.finalFrame.origin.y + 30;
                    
                    frame.origin.y += distance;
                }
                else if (visibleCell.tag > self.selectCell.tag)
                {
                    
                    CGFloat distance = CGRectGetMaxY(self.finalFrame) - CGRectGetMaxY(self.originalFrame) + 30;
                    frame.origin.y -= distance;
                    
                }
                
                visibleCell.frame = frame;
                visibleCell.transform = CGAffineTransformIdentity;

            }
            
            
            
        }
        
        
        self.selectCell.frame = self.originalFrame;
        self.selectCell.tableView.alpha = 0.0;
        self.selectCell.backBtn.alpha = 0.0;
        self.selectCell.imageView.alpha = 1.0;
        self.selectCell.titleLabel.frame = labelOriFrame;
        

        

        
        
    } completion:^(BOOL finished) {

        NSLog(@"动画结束");

        fromVC.view.hidden = YES;
        self.selectCell.tableView.contentOffset = CGPointMake(0,0);

        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //转场失败后的处理
        if ([transitionContext transitionWasCancelled])
        {
            NSLog(@"转场被取消");
            fromVC.view.hidden = NO;
            [containerView bringSubviewToFront:fromVC.view];
            
        }

        
    }];
    

}










@end
