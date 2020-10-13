//
//  sendInfoTableViewCell.m
//  Wechat
//
//  Created by tanwenmeng on 2020/10/1.
//

#import "sendInfoTableViewCell.h"
#import "Masonry.h"
#import "triangleView.h"

@interface sendInfoTableViewCell () 

@property (nonatomic,strong) UILabel *sendInfoLabel;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *profileImageView;
@property (nonatomic,strong) UIImageView *chatBottomImageView;
@property (nonatomic,strong) triangleView *triangleBubble;
 

@end

@implementation sendInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _sendInfoLabel = [[UILabel alloc] init];
        _bgView = [[UIView alloc] init];
        _profileImageView = [[UIImageView alloc] init];
        _chatBottomImageView = [[UIImageView alloc] init];
        
//        self.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1];
        [self.contentView addSubview:_bgView];
        [self.contentView addSubview:_profileImageView];
//        [self.contentView addSubview:_chatBottomImageView];
        [self.contentView addSubview:_sendInfoLabel];
        
        _sendInfoLabel.numberOfLines = 0;
        _sendInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _sendInfoLabel.textAlignment = NSTextAlignmentLeft;
        _sendInfoLabel.font = [UIFont systemFontOfSize:16];
        
        //聊天气泡的小三角形
       CGPoint piont1;
       piont1.x = self.frame.size.width - 25;
       piont1.y = 20;
       
       CGPoint piont2;
       piont2.x = self.frame.size.width - 25;
       piont2.y = 40;
       
       CGPoint piont3;
       piont3.x = self.frame.size.width - 15;
       piont3.y = 30;
    
       _triangleBubble = [[triangleView alloc] initStartPoint:piont1 middlePoint:piont2 endPoint:piont3 color:[UIColor colorWithRed:148.0/255.0 green:237.0/255.0 blue:105.0/255.0 alpha:1]];
       _triangleBubble.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height );
       _triangleBubble.backgroundColor = [UIColor clearColor];
       [self.contentView addSubview: _triangleBubble];
        
        
        
    }
    return self;
}

- (void)setMessageModel:(MessageModel *)messageModel
{
    _sendInfoLabel.text = messageModel.message;
    _profileImageView.image = [UIImage imageNamed:@"avator2.jpeg"];
    _chatBottomImageView.image = [UIImage imageNamed:@"bg.jpeg"];
    [self layoutTableViewCell];
}

- (void) layoutTableViewCell{
    
    
    
    CGSize labelSize = [_sendInfoLabel sizeThatFits:CGSizeMake(230.f, MAXFLOAT)];
    CGFloat height = ceil(labelSize.height) + 1;
    CGFloat width = ceil(labelSize.width) + 1;
     
     
    _bgView.backgroundColor = [UIColor colorWithRed:148.0/255.0 green:237.0/255.0 blue:105.0/255.0 alpha:1];
    _bgView.layer.cornerRadius = 10;
    
    [self.profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置bgView的约束，给bgView的top与contentView.mas_top之间建立约束
        make.top.equalTo(self.contentView.mas_top).offset(10.0);
        // 设置size与leading（left）的约束
        make.size.mas_equalTo(CGSizeMake( 40 ,40));
         
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-20);//右侧
        
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置bgView的约束，给bgView的top与contentView.mas_top之间建立约束
        make.top.equalTo(self.contentView.mas_top).offset(10.0);
        
        make.trailing.equalTo(self.profileImageView.mas_leading).offset(-20.0);//右侧
        
    }];
    
    [self.sendInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置sendInfoLabel的约束,给sendInfoLabel的top与bgView.mas_top之间建立约束
        make.top.equalTo(self.bgView.mas_top).offset(10.0);
        make.leading.equalTo(self.bgView.mas_leading).offset(10.0);
        
        //  bottom与contentView.mas_bottom之间的约束
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-10.0); //底部
        make.trailing.equalTo(self.bgView.mas_trailing).offset(-5.0);//右侧
        
        // 设置size 
        make.size.mas_equalTo(CGSizeMake( width ,height));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20.0);
    }];
    
}
  

@end
