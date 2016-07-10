//
//  ViewController.m
//  customAlbumCutOutBox
//
//  Created by asus on 16/7/10.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+cutImage.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define arcWitch [UIScreen mainScreen].bounds.size.width/2

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UIImageView *imageview;
@end

@implementation ViewController

@synthesize imageview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 50);
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    imageview = [[UIImageView alloc]init];
    imageview.backgroundColor = [UIColor redColor];
    imageview.frame = CGRectMake(0, 200, 320, 280);
    [self.view addSubview:imageview];
    
}

-(void)btnAction:(UIButton *)sender
{
    UIImagePickerController *pc = [[UIImagePickerController alloc]init];
    pc.delegate = self;
    [pc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    //    [pc setSourceType:UIImagePickerControllerSourceTypeCamera];
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    //    view.backgroundColor = [UIColor orangeColor];
    //    pc.cameraOverlayView = view;
    
    [pc setModalPresentationStyle:UIModalPresentationFullScreen];
    [pc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [pc setAllowsEditing:YES];
    [self presentViewController:pc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@", info);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *image2 = [UIImage imagewithImage:image];
    imageview.image = image2;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (navigationController.viewControllers.count == 3)
    {
        NSLog(@"%@", navigationController.viewControllers);
        /*针对的是相册,虽然现实出来的是圆圈，但是实际上截取的图片不是圆圈
         *"<PUUIAlbumListViewController: 0x15dad110>",
         "<PUUIPhotosAlbumViewController: 0x161b3400>",
         "<PLUIImageViewController: 0x15f34c10>"  选择照片控制器
         **/
        
        Method method = class_getInstanceMethod([self class], @selector(drawRect:));
        UIViewController *vc = [navigationController viewControllers][2];//选择照片控制器
        UIView *view = vc.view;
        NSLog(@"%@", [[view subviews][1] subviews]);
        //目的是替换选择照片控制器的子view的PLCropOverlayCropView 的drawRect方法。
        
        class_replaceMethod([[[view subviews][1] subviews][0] class], @selector(drawRect:),method_getImplementation(method),method_getTypeEncoding(method));
        
    }
}


-(void)drawRect:(CGRect)rect
{
    NSLog(@"drawRect");
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextAddRect(ref, rect);
    CGContextAddArc(ref, [UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2, arcWitch, 0, M_PI*2, NO);
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]setFill];
    CGContextDrawPath(ref, kCGPathEOFill);
    
    CGContextAddArc(ref, [UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2, arcWitch, 0, M_PI*2, NO);
    [[UIColor whiteColor]setStroke];
    CGContextStrokePath(ref);
}



@end
