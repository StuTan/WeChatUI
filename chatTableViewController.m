//
//  chatTableViewController.m
//  Wechat
//
//  Created by tanwenmeng on 2020/9/28.
//
 
#import "Masonry.h"
#import "KeyBoard.h"
#import "InputGetFrame.h"
#import "AppDelegate.h"
#import "MessageModel.h"
#import "DBManager.h"
#import "MessageController.h"
#import "SqliteManager.h"
#import "timeInfoTableViewCell.h"
#import "sendInfoTableViewCell.h"
#import "receiveTableViewCell.h"
#import "baseCellTableViewCell.h"
#import "chatTableViewController.h"
 
 
#define K_Width [UIScreen mainScreen].bounds.size.width
#define K_Height self.view.frame.size.height

@interface chatTableViewController ()<UITableViewDelegate,UITableViewDataSource,KeyboardDelegate,UIGestureRecognizerDelegate>
 
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) KeyBoard *keyView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic) BOOL keyShow;

@end

@implementation chatTableViewController

- (instancetype)init{
    self = [super init];
    if(self){
        
        //监听键盘出现、消失，判断键盘是否出现
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.backgroundColor =  [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 100;
    
    // 约束布局1：
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 约束布局2：
    self.tableView.estimatedRowHeight = 100.0;
     
    [self.view addSubview:self.tableView];
    
    
    //给TableView添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    tapGesture.delegate = self;
    [self.tableView addGestureRecognizer:tapGesture];
    
    //文本输入框
    self.keyView = [[KeyBoard alloc] initWithFrame:CGRectMake(0, K_Height - 64 - 52, K_Width, 52)];
    //设置代理方法
    self.keyView.delegate = self;
    [self.view addSubview:_keyView];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
     
    //设置navigationbar的透明度
    self.navigationController.navigationBar.translucent = NO;
    
    [self loadMessage];
    
//    [self registerCell];
    
    // 隐藏多余的分割线
    //方法一：
//    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = [UIColor clearColor]; //clearColor设置为透明颜色
//    [self.tableView setTableFooterView:view];
    //方法二：
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //隐藏所有分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //模拟发送消息
    [self setRightItem];
    
}

- (void)registerCell
{
    [_tableView registerClass:[timeInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([timeInfoTableViewCell class])];
    [_tableView registerClass:[sendInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([sendInfoTableViewCell class])];
    [_tableView registerClass:[receiveTableViewCell class] forCellReuseIdentifier:NSStringFromClass([receiveTableViewCell class])]; 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _models.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
////    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
////    return cell.frame.size.height;
//    return 100;
//}

//点击后的响应函数
//- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIViewController *controller = [[UIViewController alloc] init];
//    controller.title = [NSString stringWithFormat:@"%@",@(indexPath.row)];
//    [self.navigationController pushViewController:controller animated:YES];
//}


- (void)loadMessage{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        self.models = [[DBManager DBManagerr] messagesWithChat];
        NSLog(@"%@",self.models);
        
        [self registerCell];
        
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.tableView reloadData];
            [self scrollToBottom];
            
        });
        
    });
}

- (void)setRightItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"模拟收到消息" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)rightItemClick {
    
    [self addTimeInfo];
    
    MessageModel *msgModel = [MessageController createTextMessage:@"你收到一条消息" messageType:(UserShowType *) userReceiveInfo];
    [[DBManager DBManagerr] insertMessage:msgModel];
    [_models addObject:msgModel];
    
    [self.tableView reloadData];
    [self scrollToBottom];
}

-(void)textViewContentText:(NSString *)textStr {
    
    [self addTimeInfo];
    
    MessageModel *msgModel = [MessageController createTextMessage:textStr messageType: (UserShowType *)userSendInfo];
    [[DBManager DBManagerr] insertMessage:msgModel];
    [_models addObject:msgModel];
    
    [self.tableView reloadData];
    [self scrollToBottom];
}

-(void)addTimeInfo{
    
    if([_models count] <= 0)
    {
        NSString *timeMessage = [MessageModel timeFromDate:[NSDate date]];
        MessageModel *model = [MessageController createTextMessage:timeMessage messageType:(UserShowType *) userTimeInfo];
        
        [[DBManager DBManagerr] insertMessage:model];
        [_models addObject:model];
    }else{
        MessageModel *frontModel = [_models objectAtIndex: [_models count] - 1];
        NSInteger timeInteger1 = frontModel.timestmp;
        NSInteger timeInteger2 = [MessageModel getTimeNow];
        
        if([MessageModel compareTwoTime:(long long)timeInteger1 time2:(long long)timeInteger2]){
            
            NSString *timeMessage = [MessageModel timeFromDate:[NSDate date]];
            MessageModel *model = [MessageController createTextMessage:timeMessage messageType:(UserShowType *) userTimeInfo];
            
            [[DBManager DBManagerr] insertMessage:model];
            [_models addObject:model];
            
        }
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageModel *messageModel = _models[indexPath.row];
    baseCellTableViewCell *cell;
    NSString *cellIdentifier;

    cellIdentifier = messageModel.cellIdentifier;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击效果(不设置这一项的话，点击时会出现分割线)
    
    [cell setMessageModel:messageModel];
    
    return cell;
};

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self scrollToBottom];
}

- (void)scrollToBottom {
    
    if (self.models.count >= 1)
    {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:MAX(0, self.models.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
//    [self keyboardChangeFrameWithMinY:555];
}
 
//改变keyboard的frame
- (void)keyboardChangeFrameWithMinY:(CGFloat)minY {
    
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.models.count - 1 inSection:0];
    CGRect rect = [self.tableView rectForRowAtIndexPath:lastIndex];
    CGFloat lastMaxY = rect.origin.y + rect.size.height;
     
    
    if (lastMaxY <= self.tableView.height) {
        if (lastMaxY >= minY) {
            self.tableView.y = minY - lastMaxY;
        } else {
            self.tableView.y = 0;
        }
    } else {
        self.tableView.y += minY - self.tableView.maxY;
    }
    
}

//点击UITableView收回键盘
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //收回键盘
    //[NSNotificationCenter defaultCenter] 创建了一个消息中心，
    if( _keyShow == YES)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"keyboardHide" object:nil];
    }
    //若为UITableViewCellContentView，即点击了tableViewCell的内容，则不响应收起键盘的操作
    if([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}
 
- (void)keyboardDidShow:(NSNotification *)notification {
    _keyShow = YES;
}

- (void)keyboardDidHide:(NSNotification *)notification {
    _keyShow = NO;
}

@end
