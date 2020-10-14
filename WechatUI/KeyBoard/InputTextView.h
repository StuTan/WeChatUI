//
//  InputTextView.h
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/9.
//

#import <UIKit/UIKit.h>
 
typedef void(^TextHeightChangedBlock) (CGFloat textHeight);


@interface InputTextView : UITextView

@property (nonatomic, assign) NSUInteger maxNumberOfLines;  // textView最大行数
@property (nonatomic, strong) UIFont *textFont;             // 文字大小
@property (nonatomic, strong) TextHeightChangedBlock textChangedBlock;

- (void)textValueDidChanged:(TextHeightChangedBlock)block;

@end
