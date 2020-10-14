//
//  InputEmojiView.m
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/9.
//

#import "InputEmojiView.h" 


@implementation InputEmojiView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [UILabel new];
        label.text = @"😁";
        label.frame = CGRectMake(30, 20, 30, 30);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}

@end
