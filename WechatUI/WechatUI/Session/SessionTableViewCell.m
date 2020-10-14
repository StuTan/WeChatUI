//
//  SessionTableViewCell.m
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/9.
//

#import "Masonry.h"
#import "SessionTableViewCell.h"

@interface SessionTableViewCell ()

@end

@implementation SessionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.text = @"会话";
    }
    return self;
}
  
@end
