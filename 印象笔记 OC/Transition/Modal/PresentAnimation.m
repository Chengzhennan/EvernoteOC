//
//  PresentDelegate.m
//  印象笔记 OC
//
//  Created by Mac on 2017/5/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "PresentAnimation.h"
#import "MYCollectionViewCell.h"

@interface PresentAnimation ()

@property (nonatomic,strong)NSArray *visibleCellArr;
@property (nonatomic,assign)CGRect originalFrame;
@property (nonatomic,assign)CGRect finalFrame;

@property (nonatomic,strong)MYCollectionViewCell *selectCell;


@end


@implementation PresentAnimation


-(void)configVisibleCells:(NSArray *)visibleCells selectedCell:(MYCollectionViewCell *)selCell originalFrame:(CGRect)originalFrame finalFrame:(CGRect)finalFrame gestureVC:(UIViewController *)gestureVC collectionVC:(UIViewController *)colVC
{
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
    
    //要 modal 出来的控制器
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    toVC.view.hidden = YES;
    [containerView addSubview:toVC.view];
    
    
    
    CGPoint finalCenter = CGPointMake(self.selectCell.contentView.frame.size.width * 0.5,self.selectCell.titleLabel.center.y);
    

    
    

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        for (MYCollectionViewCell *visibleCell in self.visibleCellArr)
        {
            
            if (self.selectCell != visibleCell)
            {
                
                //30 的距离是 noteVC 和 cell.height 之间高度之差
                CGRect frame = visibleCell.frame;
                if (visibleCell.tag < self.selectCell.tag)
                {
                    CGFloat distance = self.originalFrame.origin.y - self.finalFrame.origin.y + 30;
                    
                    frame.origin.y -= distance;
                }
                else if (visibleCell.tag > self.selectCell.tag)
                {
                    
                    CGFloat distance = CGRectGetMaxY(self.finalFrame) - CGRectGetMaxY(self.originalFrame) + 30;
                    frame.origin.y += distance;
                
                }
                
                visibleCell.frame = frame;
                visibleCell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 1.0);
            }
            
            
        }
        
        self.selectCell.frame = self.finalFrame;
        self.selectCell.backBtn.alpha = 1.0;
        self.selectCell.imageView.alpha = 0.0;
        self.selectCell.tableView.alpha = 1.0;
        self.selectCell.titleLabel.center = finalCenter;

    } completion:^(BOOL finished) {
        
        toVC.view.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
    

}



@end
