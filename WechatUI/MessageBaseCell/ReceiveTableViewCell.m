//
//  receiveTableViewCell.m
//  Wechat
//
//  Created by tanwenmeng on 2020/10/1.
//

#import "Masonry.h"
#import "ReceiveTableViewCell.h"
#import "TriangleView.h"

@interface receiveTableViewCell ()

@property (nonatomic,strong) UILabel *textInfoLabel;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *profileImageView;
@property (nonatomic,strong) TriangleView *triangleBubble;

@end

@implementation receiveTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10;
        [self.contentView addSubview:_bgView];
        
        _profileImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_profileImageView];
        
        _textInfoLabel = [[UILabel alloc] init];
        _textInfoLabel.numberOfLines = 0;
        _textInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _textInfoLabel.textAlignment = NSTextAlignmentLeft;
        _textInfoLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_textInfoLabel];
        
        CGPoint piont1;
        piont1.x = 80;
        piont1.y = 20;
       
        CGPoint piont2;
        piont2.x = 80;
        piont2.y = 40;
       
        CGPoint piont3;
        piont3.x = 70;
        piont3.y = 30;
    
       _triangleBubble = [[TriangleView alloc] initStartPoint:piont1 middlePoint:piont2 endPoint:piont3 color:[UIColor whiteColor]];
       _triangleBubble.frame = CGRectMake(0, 0, 100, 100 );
       _triangleBubble.backgroundColor = [UIColor clearColor];
       [self.contentView addSubview: _triangleBubble];
    }
    return self;
}

- (void)setMessageModel:(MessageModel *)messageModel {
    _textInfoLabel.text = messageModel.message;
    _profileImageView.image = [UIImage imageNamed:@"avator.png"]; 
    [self layoutTableViewCell];
}

- (void) layoutTableViewCell {
    
    CGSize labelSize = [_textInfoLabel sizeThatFits:CGSizeMake(230.f, MAXFLOAT)];
    CGFloat height = ceil(labelSize.height) + 1;
    CGFloat width = ceil(labelSize.width) + 1;
    
    [self.profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10.0);
        make.size.mas_equalTo(CGSizeMake( 40 ,40));
        make.leading.equalTo(self.contentView.mas_leading).offset(20);        //左侧
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10.0);
        make.leading.equalTo(self.profileImageView.mas_trailing).offset(20.0); //右侧
    }];
    
    [self.textInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top).offset(10.0);
        make.size.mas_equalTo(CGSizeMake( width ,height));
        make.leading.equalTo(self.bgView.mas_leading).offset(10.0);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-10.0);             //底部
        make.trailing.equalTo(self.bgView.mas_trailing).offset(-5.0);          //右侧
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20.0);
    }];
    
}
   

@end
