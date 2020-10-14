//
//  AppDelegate.m
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/9.
//

#import "AppDelegate.h"
#import "SessionViewController.h"
#import "UserViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     
    UITabBarController *rootVC = [[UITabBarController alloc] init];
    rootVC.tabBar.translucent = NO;
    
    SessionViewController *firstViewController = [[SessionViewController alloc] init];
    UserViewController *secondViewController = [[UserViewController alloc] init];
    
    [rootVC setViewControllers:@[firstViewController,secondViewController]];
    [self setConfig:rootVC];
     
    UINavigationController *firstNavigationController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    [self.window setRootViewController: firstNavigationController];
    
    [[UIView appearance] setExclusiveTouch:YES];                    //禁止多点触控 ,同一个界面有多个按钮，为了避免都响应
     
      
    [self.window makeKeyAndVisible];
    return YES;
}
 
- (void)setConfig:(UITabBarController *)tabBarController {
    NSArray *titles = @[@"会话",@"好友"];
    NSArray *normalImages = @[@"session_normal",@"friend_normal"];
    NSArray *selectImages = @[@"session_selected",@"friend_selected"];
    
    for (NSInteger i = 0; i < tabBarController.viewControllers.count; i ++) {
        
        UIViewController *viewController = tabBarController.viewControllers[i];
        
        UIColor *color = [UIColor colorWithRed:34/255. green:207/255. blue:172/255. alpha:1];
        NSDictionary *atts = @{NSForegroundColorAttributeName:[UIColor darkTextColor],NSFontAttributeName:[UIFont systemFontOfSize:12]};
        NSDictionary *selAtts = @{NSForegroundColorAttributeName:color,NSFontAttributeName:[UIFont systemFontOfSize:12]};
        
        UIImage *img = [[UIImage imageNamed:normalImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selImg = [[UIImage imageNamed:selectImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        viewController.tabBarItem.title = titles[i];
        viewController.tabBarItem.image = img;
        viewController.tabBarItem.selectedImage = selImg;
        
        if (@available(iOS 13.0, *)) {
            UITabBarAppearance *appearance = [UITabBarAppearance new];
            appearance.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = atts;
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selAtts;
            viewController.tabBarItem.standardAppearance = appearance;
        } else {
            [viewController.tabBarItem setTitleTextAttributes:atts forState:UIControlStateNormal];
            [viewController.tabBarItem setTitleTextAttributes:selAtts forState:UIControlStateSelected];
        }
    }
}

@end
