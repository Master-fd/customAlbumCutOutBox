//
//  UIImage+cutImage.m
//  圆形裁剪框
//
//  Created by 廖晓帆 on 16/5/20.
//  Copyright © 2016年 廖晓帆. All rights reserved.
//

#import "UIImage+cutImage.h"

@implementation UIImage (cutImage)

+ (UIImage *)imageWithColor:(UIColor *)color redius:(CGFloat)redius size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ref, color.CGColor);
    CGContextFillRect(ref, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(image.size);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, image.size.width, image.size.height) cornerRadius:redius];
    [path addClip];
    [image drawAtPoint:CGPointZero];
    UIImage *image1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image1;
}

+ (UIImage *)imagewithImage:(UIImage *)image
{
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat redius = ((width <= height) ? width : height)/2;
    CGRect  rect = CGRectMake(width/2-redius, height/2-redius, redius*2, redius*2);
    
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newImage.size.width, newImage.size.height), NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(newImage.size.width/2, newImage.size.height/2) radius:redius startAngle:0 endAngle:M_PI*2 clockwise:0];
    [path addClip];
    [newImage drawAtPoint:CGPointZero];
    UIImage *imageCut = UIGraphicsGetImageFromCurrentImageContext();
    
    return imageCut;
    
}

@end
