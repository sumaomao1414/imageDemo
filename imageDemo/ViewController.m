//
//  ViewController.m
//  imageDemo
//
//  Created by maomao on 16/6/17.
//  Copyright © 2016年 maomao. All rights reserved.
//

#import "ViewController.h"
#import "YYPhotoGroupView.h"
#import "UIImageView+WebCache.h"


@interface ViewController ()
@property(nonatomic,strong)NSMutableArray *pics;
@property(nonatomic,strong)NSMutableArray *subViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat x = 10;
    CGFloat y = 5;
    CGFloat w = self.view.frame.size.width/3 - 10;
    CGFloat h = 90;
    
    _pics = [NSMutableArray array];
    _subViews = [NSMutableArray array];
      
    for (NSInteger i = 0; i < 9; i++) {
        
       [_pics addObject:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1466066885&di=7e3dc96da227dc591efa1ec82e24396e&src=http://www.one101.com/htm/fengjxsh/tp/fh/wu-long-shan/da/62.jpg"];
       // [_pics addObject:@"tangwei2webp"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 5;
        imageView.backgroundColor = [UIColor redColor];
        [imageView sd_setImageWithURL:[NSURL URLWithString:_pics[i]]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:imageView];
        [_subViews addObject:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dealTap:)];
        [imageView addGestureRecognizer:tap];
        
        //改变坐标
        if (i%3 != 2) {
            x = x + w+5;
        }
        else //换行
        {
            x=10;
            y = y +h+5;
        }
        
    }

    
    
    
}

- (void)dealTap:(UITapGestureRecognizer *)tap
{
    NSLog(@"%ld",tap.view.tag);
    UIView *fromView = nil;
    NSMutableArray *items = [NSMutableArray new];

    for (NSUInteger i = 0, max = _pics.count; i < max; i++) {
        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
        item.thumbView = self.subViews[i];
        item.largeImageURL = [NSURL URLWithString:_pics[i]];
        item.largeImageSize = tap.view.frame.size;
        [items addObject:item];
        if (i == tap.view.tag) {
            fromView = tap.view;
        }
    }
    
    UIViewController *mainVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    YYPhotoGroupView *photoVc = [[YYPhotoGroupView alloc] initWithGroupItems:items];
    [photoVc presentFromImageView:fromView toContainer:mainVc.view animated:YES completion:nil];
    
    
}















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
