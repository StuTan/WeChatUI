//
//  KeyBoard.h
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/9.
//

#import <UIKit/UIKit.h>

@protocol KeyboardDelegate <NSObject>

@optional

//输入框中的内容
- (void)textViewContentText:(NSString *)textStr;

//改变键盘的大小
- (void)keyboardChangeFrameWithMinY:(CGFloat)minY;

@end


@interface KeyBoard : UIView <UITextViewDelegate>

@property (nonatomic, weak) id <KeyboardDelegate> delegate;

@end
