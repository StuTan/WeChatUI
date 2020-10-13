//
//  KeyBoard.m
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/9.
//
 
#import "KeyBoard.h"
#import "InputTextView.h"
#import "InputMoreView.h"
#import "InputEmojiView.h"
#import "InputGetFrame.h"
#import "AppDelegate.h"
#import "MessageModel.h"
#import "MessageController.h"
#import "chatTableViewController.h"

//状态栏和导航栏的总高度
#define StatusNav_Height (isIphoneX ? 88 : 64)
//判断是否是iPhoneX
#define isIphoneX (K_Width == 375.f && K_Height == 812.f ? YES : NO)
#define K_Width [UIScreen mainScreen].bounds.size.width
#define K_Height [UIScreen mainScreen].bounds.size.height

static float bottomHeight = 230.0f; //底部视图高度
static float viewMargin = 8.0f; //按钮距离上边距
static float viewHeight = 36.0f; //按钮视图高度


@interface KeyBoard () <UITextViewDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *emojiBtn;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) InputTextView *textView;
@property (nonatomic, strong) InputMoreView *moreView;
@property (nonatomic, strong) InputEmojiView *emojiView;

@property (nonatomic, assign) CGFloat totalYOffset;
@property (nonatomic, assign) float keyboardHeight; //键盘高度
@property (nonatomic, assign) double keyboardTime; //键盘动画时长
@property (nonatomic, assign) BOOL emojiClick; //点击表情按钮
@property (nonatomic, assign) BOOL moreClick; //点击更多按钮

@end


@implementation KeyBoard

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];

        //监听键盘出现、消失
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        //点击其他空白的地方隐藏键盘
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide) name:@"keyboardHide" object:nil];
        
        //创建视图
        [self creatView];
    }
    return self;
}

- (void)creatView {
    
    self.backView.frame = CGRectMake(0, 0, self.width, self.height);
    
    //表情按钮
    self.emojiBtn.frame = CGRectMake(viewMargin, viewMargin, viewHeight, viewHeight);
    
    //输入视图
    self.textView.frame = CGRectMake(CGRectGetMaxX(self.emojiBtn.frame) + viewMargin, viewMargin, K_Width - (CGRectGetMaxX(self.emojiBtn.frame) + viewMargin) * 2, viewHeight);
    
    //加号按钮
    self.moreBtn.frame = CGRectMake(CGRectGetMaxX(self.textView.frame) + viewMargin, self.height - viewMargin - viewHeight, viewHeight, viewHeight);
}
 
- (void)emojiBtn:(UIButton *)btn {
    self.moreClick = NO;
    if (self.emojiClick == NO) {
        self.emojiClick = YES;
        [self.textView resignFirstResponder];
        [self.moreView removeFromSuperview];
        self.moreView = nil;
        [self addSubview:self.emojiView];
        [UIView animateWithDuration:0.25 animations:^{
            self.emojiView.frame = CGRectMake(0, self.backView.height, K_Width, bottomHeight);
            self.frame = CGRectMake(0, K_Height - StatusNav_Height - self.backView.height - bottomHeight, K_Width, self.backView.height + bottomHeight);
            [self changeTableViewFrame];
        }];
    } else {
        [self.textView becomeFirstResponder];
    }
}
 
- (void)moreBtn:(UIButton *)btn {
    self.emojiClick = NO;
    if (self.moreClick == NO) {
        self.moreClick = YES;
        //回收键盘
        [self.textView resignFirstResponder];
        [self.emojiView removeFromSuperview];
        self.emojiView = nil;
        [self addSubview:self.moreView];
        //改变更多、self的frame
        [UIView animateWithDuration:0.25 animations:^{
            self.moreView.frame = CGRectMake(0, self.backView.height, K_Width, bottomHeight);
            self.frame = CGRectMake(0, K_Height - StatusNav_Height - self.backView.height - bottomHeight, K_Width, self.backView.height + bottomHeight);
            [self changeTableViewFrame];
        }];
    } else { //再次点击更多按钮
        //键盘弹起
        [self.textView becomeFirstResponder];
    }
}

- (void)changeFrame:(CGFloat)height {
    CGRect frame = self.textView.frame;
    frame.size.height = height;
    self.textView.frame = frame; //改变输入框的frame
    //当输入框大小改变时，改变backView的frame
    self.backView.frame = CGRectMake(0, 0, K_Width, height + (viewMargin * 2));
    self.frame = CGRectMake(0, K_Height - StatusNav_Height - self.backView.height - _keyboardHeight, K_Width, self.backView.height);
    //改变更多按钮、表情按钮的位置
    self.emojiBtn.frame = CGRectMake(viewMargin, self.backView.height - viewHeight - viewMargin, viewHeight, viewHeight);
    self.moreBtn.frame = CGRectMake(self.textView.maxX + viewMargin, self.backView.height - viewHeight - viewMargin, viewHeight, viewHeight);
    
    //改变VC的tableView的frame
    [self changeTableViewFrame];
}
 
- (void)keyboardHide {
    //收起键盘
    [self.textView resignFirstResponder];
    [self removeBottomViewFromSupview];
    [UIView animateWithDuration:0.25 animations:^{
        //设置self的frame到最底部
//        self.frame = CGRectMake(0, K_Height - StatusNav_Height - self.backView.height, K_Width, self.backView.height);
        [self changeTableViewFrame];
    }];
}
 
- (void)keyboardWillShow:(NSNotification *)notification {
    [self removeBottomViewFromSupview];
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //获取键盘的高度
    self.keyboardHeight = endFrame.size.height;
    
    //键盘的动画时长
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration delay:0 options:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] animations:^{
        self.frame = CGRectMake(0, endFrame.origin.y - self.backView.height - StatusNav_Height, K_Width, self.height);
        [self changeTableViewFrame];
    } completion:nil];
}
 
- (void)keyboardWillHide:(NSNotification *)notification {
    //弹出了底部视图时
    if (self.moreClick || self.emojiClick) {
        return;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, K_Height - StatusNav_Height - self.backView.height, K_Width, self.backView.height);
        [self changeTableViewFrame];
    }];
}
 
 
- (void)changeTableViewFrame {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardChangeFrameWithMinY:)]) {
        [self.delegate keyboardChangeFrameWithMinY:self.y];
    }
}
 
- (void)removeBottomViewFromSupview {
    [self.moreView removeFromSuperview];
    [self.emojiView removeFromSuperview];
    self.moreView = nil;
    self.emojiView = nil;
    self.moreClick = NO;
    self.emojiClick = NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //判断输入的字是否是回车
    
    if ([text isEqualToString:@"\n"]){
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(textViewContentText:)]) {
            [self.delegate textViewContentText:textView.text];
        }
        textView.text = @"";
//        [self changeFrame:viewHeight];
//        User *newUser = [[User alloc] init];
//        newUser.textInfo = textView.text;
//        newUser.showtype = userSendInfo;
//        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
//        [delegate.users addObject:newUser];
        
        
        return NO; //NO，就代表return键值失效，
    }
    return YES;//yes，则输入页面会换行
}


- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.layer.borderWidth = 1;
        _backView.layer.borderColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.89 alpha:1.00].CGColor;
        [self addSubview:_backView];
    }
    return _backView;
}



//表情按钮
- (UIButton *)emojiBtn {
    if (!_emojiBtn) {
        _emojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emojiBtn setBackgroundImage:[UIImage imageNamed:@"emojiImg"] forState:UIControlStateNormal];
        [_emojiBtn addTarget:self action:@selector(emojiBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:_emojiBtn];
    }
    return _emojiBtn;
}

//更多按钮
- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setBackgroundImage:[UIImage imageNamed:@"moreImg"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:_moreBtn];
    }
    return _moreBtn;
}

- (InputTextView *)textView {
    if (!_textView) {
        _textView = [[InputTextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:16];
        [_textView textValueDidChanged:^(CGFloat textHeight) {
            [self changeFrame:textHeight];
        }];
        _textView.maxNumberOfLines = 5;
        _textView.layer.cornerRadius = 4;
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.89 alpha:1.00].CGColor;
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeySend;
        [self.backView addSubview:_textView];
    }
    return _textView;
}

//更多视图
- (InputMoreView *)moreView {
    if (!_moreView) {
        _moreView = [[InputMoreView alloc] init];
        _moreView.frame = CGRectMake(0, K_Height, K_Width, bottomHeight);
    }
    return _moreView;
}

//表情视图
- (InputEmojiView *)emojiView {
    if (!_emojiView) {
        _emojiView = [[InputEmojiView alloc] init];
        _emojiView.frame = CGRectMake(0, K_Height, K_Width, bottomHeight);
    }
    return _emojiView;
}
 
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end

