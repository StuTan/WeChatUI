//
//  InputMoreView.m
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/9.
//

#import "InputMoreView.h"

@implementation InputMoreView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(30, 20, 60, 60);
        imageView.image = [UIImage imageNamed:@"photoImg"];
        [self addSubview:imageView];
        
        UILabel *label = [UILabel new];
        label.text = @"照片"; 
        label.frame = CGRectMake(30,80, 60, 30);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}

@end
