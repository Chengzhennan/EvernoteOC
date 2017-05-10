//
//  MYCellLayout.m
//  印象笔记 OC
//
//  Created by Mac on 2017/5/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "MYCellLayout.h"

#define  screenW    [UIScreen mainScreen].bounds.size.width
#define  screenH    [UIScreen mainScreen].bounds.size.height
#define  space      10
#define  cellH      47
CGFloat SpringFactor = 10.0;

@interface MYCellLayout ()


@end

@implementation MYCellLayout


-(instancetype)init
{

    if ([super init])
    {
        self.itemSize = CGSizeMake(screenW - 2 *space, cellH);
        self.headerReferenceSize = CGSizeMake(0, space);
        
    }
    return self;

}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{

    
    CGFloat offsetY = self.collectionView.contentOffset.y;
    
    NSArray *attrsArray = [super layoutAttributesForElementsInRect: rect];
    
    CGFloat collectionViewFrameHeight = self.collectionView.frame.size.height;
    
    CGFloat collectionViewContentHeight = self.collectionView.contentSize.height;

    CGFloat ScrollViewContentInsetBottom = self.collectionView.contentInset.bottom;

    CGFloat bottomOffset  = offsetY + collectionViewFrameHeight - collectionViewContentHeight - ScrollViewContentInsetBottom;
    
    
    CGFloat numOfItems = [self.collectionView numberOfSections];
    for (UICollectionViewLayoutAttributes *attr in attrsArray)
    {
        if (attr.representedElementCategory == UICollectionElementCategoryCell)
        {
            CGRect cellRect = attr.frame;
            if (offsetY <= 0)
            {

                CGFloat distance = fabs((offsetY) / SpringFactor);
                
                cellRect.origin.y += offsetY + distance * (attr.indexPath.section + 1);
                
            }else if (bottomOffset > 0) //滚动底部不能再滚的时候
            {
                CGFloat distance = bottomOffset / SpringFactor;
                cellRect.origin.y += bottomOffset - distance *
                (numOfItems - attr.indexPath.section);
            }
            attr.frame = cellRect;
        }
    }
    return attrsArray;
    

}



-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return  YES;
}













@end
