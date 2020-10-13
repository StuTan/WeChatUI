//
//  triangleView.h
//  Wechat
//
//  Created by tanwenmeng on 2020/10/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface triangleView : UIView

- (instancetype)initStartPoint:(CGPoint)startPoint
                   middlePoint:(CGPoint)middlePoint
                      endPoint:(CGPoint)endPoint
                         color:(UIColor*)color ;
@end

NS_ASSUME_NONNULL_END
