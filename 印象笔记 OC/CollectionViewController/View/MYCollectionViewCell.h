//
//  MYCollectionViewCell.h
//  印象笔记 OC
//
//  Created by Mac on 2017/5/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)UILabel  * titleLabel;
@property (nonatomic, strong)UIImageView* imageView;
@property (nonatomic, strong)UIButton* backBtn;

@property (nonatomic, strong)UITableView* tableView;
@property (nonatomic, strong)NSMutableArray* dataSource;


@end
