//
//  InputTextView.m
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/9.
//

#import "InputTextView.h"

static float textFont = 25; //输入框字体大小


@interface InputTextView ()

@property (nonatomic, assign) CGFloat maxTextH;

@end

@implementation InputTextView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        if (!self.textFont) {
            self.textFont = [UIFont systemFontOfSize:textFont];
        }
        [self setup];
    }
    return self;
}

-(void)setup {
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}
 
-(void)textDidChange {
    CGFloat height = ceilf([self sizeThatFits:CGSizeMake(self.frame.size.width, MAXFLOAT)].height);
    if (height > _maxTextH) {
        height = _maxTextH;
        self.scrollEnabled = YES;   //当textView大于最大高度的时候让其可以滚动
    } else {
        self.scrollEnabled = NO;
        if (_textChangedBlock && self.scrollEnabled == NO) {
            _textChangedBlock(height);
        }
    }
    [self layoutIfNeeded];
}
 
-(void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines {
    _maxNumberOfLines = maxNumberOfLines;
    _maxTextH = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
}
 
-(void)textValueDidChanged:(TextHeightChangedBlock)block {
    _textChangedBlock = block;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
