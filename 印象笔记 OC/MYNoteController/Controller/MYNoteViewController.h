//
//  MYNoteViewController.h
//  印象笔记 OC
//
//  Created by Mac on 2017/5/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYNoteViewController : UIViewController

@property (nonatomic,strong)UIColor *backColor;
@property (nonatomic,strong)UIView *backView;

@property (nonatomic, strong)NSMutableArray* dataSource;



@property (nonatomic, strong)NSString* centerTitle;


//记录tableView的偏移量
@property (nonatomic,assign)CGFloat  contentOffsetY ;


@end
