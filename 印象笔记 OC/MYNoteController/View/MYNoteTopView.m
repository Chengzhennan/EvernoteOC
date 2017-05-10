//
//  MYNoteTopView.m
//  印象笔记 OC
//
//  Created by Cheng on 2017/5/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "MYNoteTopView.h"


@interface MYNoteTopView ()

@property (nonatomic, strong)UIImageView* imageView;
@property (nonatomic, strong)UIButton* backBtn;

@end

@implementation MYNoteTopView


-(instancetype)initWithFrame:(CGRect)frame
{
    
    if ( [super initWithFrame:frame])
    {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;

        [self initLabel];
        [self initBackBtn];
        
    }
    
    return self;
    
    
}


-(void)initBackBtn
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.backBtn = backBtn;
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    
    
    
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:16];

    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    backBtn.frame = CGRectMake(0, 0, 90, 20);
    self.backBtn.center = CGPointMake(self.backBtn.center.x,  self.frame.size.height * 0.5);

    [self addSubview:backBtn];
    
    
    
    
    
}

-(void)initLabel
{
    UILabel *titleLabel= [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentCenter;

    self.titleLabel.frame = CGRectMake(0, 0, 100, 30);
    self.titleLabel.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);

    [self addSubview:titleLabel];

    

    
    
}

-(void)initImageView
{
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 20   , 20)];
    
    imageV.image = [UIImage imageNamed:@"notebook"];
    self.imageView = imageV;
    [self addSubview:imageV];
    
    
}

    

-(void)backBtnClick
{

    if ([self.delegate respondsToSelector:@selector(noteTopViewDidClickBackBtn)])
    {
        [self.delegate noteTopViewDidClickBackBtn];
    }


}


@end
