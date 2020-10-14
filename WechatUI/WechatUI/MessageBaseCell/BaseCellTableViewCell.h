//
//  BaseCellTableViewCell.h
//  Wechat
//
//  Created by tanwenmeng on 2020/10/1.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
#import "TriangleView.h"
  


@interface BaseCellTableViewCell : UITableViewCell

-(void)setMessageModel:(MessageModel *)messageModel;

@end
 
