//
//  receiveTableViewCell.m
//  Wechat
//
//  Created by tanwenmeng on 2020/10/1.
//

#import "Masonry.h"
#import "receiveTableViewCell.h"
#import "triangleView.h"

 

@interface receiveTableViewCell () 

@property (nonatomic,strong) UILabel *sendInfoLabel;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *profileImageView;
@property (nonatomic,strong) UIImageView *chatBottomImageView;
@property (nonatomic,strong) triangleView *triangleBubble;
 

@end

@implementation receiveTableViewCell

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
        
        //聊天气泡中的小三角形
       CGPoint piont1;
       piont1.x = 80;
       piont1.y = 20;
       
       CGPoint piont2;
       piont2.x = 80;
       piont2.y = 40;
       
       CGPoint piont3;
       piont3.x = 70;
       piont3.y = 30;
    
       _triangleBubble = [[triangleView alloc] initStartPoint:piont1 middlePoint:piont2 endPoint:piont3 color:[UIColor whiteColor]];
       _triangleBubble.frame = CGRectMake(0, 0, 100, 100 );
       _triangleBubble.backgroundColor = [UIColor clearColor];
       [self.contentView addSubview: _triangleBubble];

        
    }
    return self;
}

- (void)setMessageModel:(MessageModel *)messageModel
{
    _sendInfoLabel.text = messageModel.message;
    _profileImageView.image = [UIImage imageNamed:@"avator.png"];
    _chatBottomImageView.image = [UIImage imageNamed:@"bg.jpeg"];
    [self layoutTableViewCell];
}

- (void) layoutTableViewCell{
    
    
    CGSize labelSize = [_sendInfoLabel sizeThatFits:CGSizeMake(230.f, MAXFLOAT)];
    CGFloat height = ceil(labelSize.height) + 1;
    CGFloat width = ceil(labelSize.width) + 1;
    
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 10;
    
    [self.profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置profileImageView的约束，给profileImageView的top与contentView.mas_top之间建立约束
        make.top.equalTo(self.contentView.mas_top).offset(10.0);
        // 设置size
        make.size.mas_equalTo(CGSizeMake( 40 ,40));
         
        make.leading.equalTo(self.contentView.mas_leading).offset(20);//左侧
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置bgView的约束，给bgView的top与contentView.mas_top之间建立约束
        make.top.equalTo(self.contentView.mas_top).offset(10.0);
        
        make.leading.equalTo(self.profileImageView.mas_trailing).offset(20.0);//右侧
    }];
    
    [self.sendInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置sendInfoLabel的约束,给sendInfoLabel的top与bgView.mas_top之间建立约束
        make.top.equalTo(self.bgView.mas_top).offset(10.0);
        
        // 设置size与leading（left）的约束
        make.size.mas_equalTo(CGSizeMake( width ,height));
        
        make.leading.equalTo(self.bgView.mas_leading).offset(10.0);
        
        //  bottom与contentView.mas_bottom之间的约束
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-10.0); //底部
        make.trailing.equalTo(self.bgView.mas_trailing).offset(-5.0);//右侧
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20.0);
    }];
    
}
   

@end
