//
//  MYNoteTopView.h
//  印象笔记 OC
//
//  Created by Cheng on 2017/5/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MYNoteTopViewDidClickBackBtn <NSObject>

-(void)noteTopViewDidClickBackBtn;

@end

@interface MYNoteTopView : UIView
@property (nonatomic, strong)UILabel* titleLabel;

@property (nonatomic, weak)id<MYNoteTopViewDidClickBackBtn> delegate;
@end
