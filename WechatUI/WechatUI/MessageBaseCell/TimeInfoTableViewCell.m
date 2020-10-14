//
//  TimeCellTableViewCell.m
//  Wechat
//
//  Created by tanwenmeng on 2020/10/1.
//

#import "TimeInfoTableViewCell.h"
#import "Masonry.h"
#import "MessageModel.h"

@interface TimeCellTableViewCell () 

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation TimeCellTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _timeLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_timeLabel];
    }
    return self;
}

-(void)setMessageModel:(MessageModel *)messageModel {
    NSDate *dataShow = [MessageModel dateFromTimeStamp:[NSString stringWithFormat:@"%@",@(messageModel.timestmp)]];
    _timeLabel.text = [MessageModel timeFromDate: dataShow];
    [self.timeLabel sizeToFit];
    [self layoutTableViewCell];
}

-(void)layoutTableViewCell {
    [self.timeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10.0);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.leading.equalTo(self.contentView.mas_leading).offset(10.0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10.0);     //底部
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-40.0); //右侧
    }];
    
}
@end
