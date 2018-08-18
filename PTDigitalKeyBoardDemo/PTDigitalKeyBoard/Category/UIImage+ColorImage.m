//
//  UIImage+ColorImage.m
//  PTDigitalKeyBoardDemo
//
//  Created by Mac on 2018/8/18.
//  Copyright © 2018年 Shenzhen LvPai Culture Communication Co., Ltd. All rights reserved.
//

#import "UIImage+ColorImage.h"

@implementation UIImage (ColorImage)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return colorImage;
}

@end
