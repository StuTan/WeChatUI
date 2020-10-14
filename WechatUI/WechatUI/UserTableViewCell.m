//
//  UserTableViewCell.m
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/9.
//

#import "UserTableViewCell.h"

@implementation UserTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.text = @"好友1号";
    }
    return self;
}

@end
