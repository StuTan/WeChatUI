//
//  SessionViewController.m
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/9.
//

#import "SessionViewController.h"
#import "SessionTableViewCell.h"
#import "chatTableViewController.h"

@interface SessionViewController ()<UITableViewDelegate,UITableViewDataSource>
 
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SessionViewController

- (instancetype)init{
    self = [super init];
    if(self){
        self.title = @"会话";
    }
    return self;
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor redColor];
//    _tableView.tableHeaderView = view;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    //隐藏多余分割线
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
     
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIViewController *controller = [[UIViewController alloc] init];
    
//    controller.title = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    
    
    chatTableViewController *chatController=[[chatTableViewController alloc]init ];
    chatController.title = @"好友1";
    [self.navigationController pushViewController:chatController animated:YES];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SessionTableViewCell *cell = [[SessionTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[SessionTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    } 
    
    return cell;
};


@end
