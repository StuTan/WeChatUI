//
//  ChatTableViewController.h
//  Wechat
//
//  Created by tanwenmeng on 2020/9/28.
//

#import <UIKit/UIKit.h>
#import "KeyBoard.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatTableViewController : UIViewController

- (void)textViewContentText:(NSString *)textStr;
@property (nonatomic, weak) id <KeyboardDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
