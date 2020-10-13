//
//  timeInfoTableViewCell.m
//  Wechat
//
//  Created by tanwenmeng on 2020/10/1.
//

#import "timeInfoTableViewCell.h"
#import "Masonry.h"
#import "MessageModel.h"

@interface timeInfoTableViewCell () 

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation timeInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1];
        _timeLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_timeLabel];
    }
    return self;
}

- (void)setMessageModel:(MessageModel *)messageModel
{
    NSDate *dataShow = [MessageModel dateFromTimeStamp:[NSString stringWithFormat:@"%@",@(messageModel.timestmp)]];
    _timeLabel.text = [MessageModel timeFromDate: dataShow];
//    _timeLabel.text = messageModel.message;
    
    [self.timeLabel sizeToFit];
    [self layoutTableViewCell];
    
}

-(void) layoutTableViewCell{
    
    [self.timeLabel setTextAlignment:NSTextAlignmentCenter];
    
    //在Cell居中显示，Cell的高度设置不确定
//    self.timeLabel.frame = CGRectMake(0 , 0, self.frame.size.width, self.frame.size.height);
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置时间信息的约束，最重要的思想是：给时间信息的top与contentView.mas_top之间建立约束
        make.top.equalTo(self.contentView.mas_top).offset(10.0);
        // 设置size与leading（left）的约束
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.leading.equalTo(self.contentView.mas_leading).offset(10.0);
        
        // 步骤5：设置时间信息的bottom与contentView.mas_bottom之间的约束
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10.0); //底部
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-40.0);//右侧
    }];
    
}
@end
