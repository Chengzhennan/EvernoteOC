//
//  MYCollectionViewCell.m
//  印象笔记 OC
//
//  Created by Mac on 2017/5/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "MYCollectionViewCell.h"
#define  screenW    [UIScreen mainScreen].bounds.size.width
#define  screenH    [UIScreen mainScreen].bounds.size.height
#define  space      10
CGFloat cellH = 47;
@interface MYCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIView* topView;


@end

@implementation MYCollectionViewCell


-(NSMutableArray *)dataSource
{

    if (!_dataSource)
    {
        
        _dataSource = [NSMutableArray arrayWithArray:@[@"笔记本1",@"笔记本2",@"笔记本3",@"笔记本4",@"笔记本5",@"笔记本6",@"笔记本7",@"笔记本8",@"笔记本9",@"笔记本10",@"笔记本11",@"笔记本12",@"笔记本13",@"笔记本14",@"笔记本15",@"笔记本16",@"笔记本17",@"笔记本18"]];
    }
    return  _dataSource;
}

-(instancetype)initWithFrame:(CGRect)frame
{

    if ( [super initWithFrame:frame])
    {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        [self initTopView];
        [self initTableView];
        
        
        
        
    }
    
    return self;


}

-(void)initTopView
{
    UIView *topV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, cellH)];
    self.topView = topV;
    
    
    [self initImageView];
    [self initLabel];
    [self initBackBtn];

    
    [self.contentView addSubview:topV];

    

}

-(void)initLabel
{
    UILabel *titleLabel= [[UILabel alloc]init];
    titleLabel.text = @"笔记本";
    self.titleLabel = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentCenter;

    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 15, 10, 100 , 30);
    self.titleLabel.center = CGPointMake(self.titleLabel.center.x, self.topView.frame.size.height * 0.5);

    [self.topView addSubview:titleLabel];
    
    
    
}

-(void)initImageView
{
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 20   , 20)];
    

    imageV.image = [UIImage imageNamed:@"notebook"];
    self.imageView = imageV;
    self.imageView.center = CGPointMake(self.imageView.center.x,  self.topView.frame.size.height * 0.5);

    [self.topView addSubview:imageV];
    

}


-(void)initBackBtn
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.alpha = 0.0;
    self.backBtn = backBtn;
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 90, 20);
    self.backBtn.center = CGPointMake(self.backBtn.center.x,  self.contentView.frame.size.height * 0.5);
    [self.contentView addSubview:backBtn];
    
}

-(void)initTableView
{
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,cellH, self.contentView.frame.size.width, screenH - (4 * space) - cellH) style:UITableViewStylePlain];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.userInteractionEnabled = NO;
    
    
    [self.contentView addSubview:tableView];

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;


}



















@end
