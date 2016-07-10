//
//  UIImage+cutImage.h
//  圆形裁剪框
//
//  Created by 廖晓帆 on 16/5/20.
//  Copyright © 2016年 廖晓帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (cutImage)

//颜色转换成图片(带圆角的)
+ (UIImage *)imageWithColor:(UIColor *)color redius:(CGFloat)redius size:(CGSize)size;
//将图片截成圆形图片
+ (UIImage *)imagewithImage:(UIImage *)image;

@end
