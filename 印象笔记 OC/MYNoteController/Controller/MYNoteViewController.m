//
//  MYNoteViewController.m
//  印象笔记 OC
//
//  Created by Mac on 2017/5/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "MYNoteViewController.h"
#import "MYNoteTopView.h"


#define  screenW    [UIScreen mainScreen].bounds.size.width
#define  screenH    [UIScreen mainScreen].bounds.size.height
#define  space      10

CGFloat cellHeight = 47;

@interface MYNoteViewController ()<UITableViewDelegate,UITableViewDataSource,MYNoteTopViewDidClickBackBtn>

@property (nonatomic, weak)UITableView *tableView;

@end

@implementation MYNoteViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
   

}



-(void)initView
{
    self.view.backgroundColor = [UIColor lightGrayColor];

    self.backView = [[UIView alloc]initWithFrame:CGRectMake(space, space, screenW - 2 *space, screenH -4 *space)];
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
    self.backView.backgroundColor = [UIColor whiteColor];

    
    MYNoteTopView *topView = [[MYNoteTopView alloc]initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width, cellHeight)];
    topView.titleLabel.text = self.centerTitle;
    topView.delegate = self;

    [self.backView addSubview:topView];
    
    
    
    
    
    
    

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), self.backView.frame.size.width, self.backView.frame.size.height - topView.frame.size.height) style:UITableViewStylePlain];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    self.tableView = tableView;
    [self.backView addSubview:tableView];
    [self.view addSubview: _backView];


}


#pragma mark- tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return  self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = self.dataSource[indexPath.row];
       return cell;


}

#pragma mark- tableViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    self.contentOffsetY = self.tableView.contentOffset.y;
    
}



-(void)noteTopViewDidClickBackBtn
{

    [self dismissViewControllerAnimated:YES completion:nil];

}








@end
