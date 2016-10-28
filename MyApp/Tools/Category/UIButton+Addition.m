//
//  UIButton+Addition.m
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "UIButton+Addition.h"

@implementation UIButton (Addition)

/**
 设置边框及其颜色
 
 @param width 边框大小
 @param color 边框颜色
 */
- (void)setButtonBorderWidth:(CGFloat)width andColor:(UIColor *)color{
    [self setViewBorderWidth:width andColor:color];
}

/**
 设置边框弧度
 
 @param radius 弧度大小
 */
- (void)setButtonBorderRadius:(CGFloat)radius{
    [self setViewBorderRadius:radius];
}


/**
 设置标题在图片正下方
 */
- (void)setButtonTitleAndImageShowInCenter{
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    CGFloat imageAndTitlePadding = 2.f;
    CGSize btnSize = self.frame.size;
    CGSize imageSize = self.imageView.image.size;
    CGSize titleSize = [self sizeWithString:self.titleLabel.text font:self.titleLabel.font maxSize:CGSizeMake(btnSize.width, btnSize.height)];
    CGFloat top = (btnSize.height - (imageSize.height + titleSize.height + imageAndTitlePadding))/2;
    [self setImageEdgeInsets:UIEdgeInsetsMake(top, (btnSize.width-imageSize.width)/2, 0, 0)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + top + imageAndTitlePadding, (btnSize.width - titleSize.width)/2 - imageSize.width, 0, 0)];
}


/**
 计算字体大小
 */
- (CGSize)sizeWithString:(NSString*)str font:(UIFont*)font maxSize:(CGSize)maxSize{
    NSDictionary *dic = @{NSFontAttributeName: font};
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;

}

@end
