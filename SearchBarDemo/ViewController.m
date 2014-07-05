//
//  ViewController.m
//  SearchBarDemo
//
//  Created by sskh on 14-7-5.
//  Copyright (c) 2014年 sskh. All rights reserved.
//

#import "ViewController.h"
#import "UtilityFunc.h"

@interface ViewController ()<UISearchDisplayDelegate, UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDC;

@end

@implementation ViewController


- (void)createSearchBar
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    
//    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    
    
    UIImage *backgroundImg = [UtilityFunc createImageWithColor:UIColorFromHex(0xf0eaf3) size:_searchBar.frame.size];
    
    
    [_searchBar setBackgroundImage:backgroundImg];//设置背景图片，可以去掉边框的黑线
    
    _searchBar.placeholder = @"输入你想查询内容";
    _searchBar.tintColor = [UIColor greenColor];
    
    _searchBar.delegate = self;
    
    
    _searchDC = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
//    _searchDC.searchResultsDataSource = self;
//    _searchDC.searchResultsDelegate = self;
//    _searchDC.delegate = self;
    
    
    [self.view addSubview:_searchBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self createSearchBar];
}

/*递归*/
//（深度优先算法）
-(void)allview:(UIView *)rootview indent:(NSInteger)indent
{
    //    NSLog(@"[%2d] %@",indent, rootview);
    indent++;
    for (UIView *aview in rootview.subviews)
    {
        //NSLog(@"[%2d] %@",indent, aview);
        
        
        
        if([aview isKindOfClass:NSClassFromString(@"UINavigationButton")]){
            
            
            /** 1.
             简单的方法就是信息本地化：在Project -> Localizations 添加 Chinese (Simplified) 即可.
             
             运行就可以发现 Cancel 变成 取消 了。
             */
            
            
            /** 2.
             可以深度定制取消按钮，即在此按钮上加上自己的视图
             */

            UIButton *btn = (UIButton *)aview;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
            
            [btn setTintColor:[UIColor colorWithRed:176.f/255.f green:86.f/255.f blue:150.f/255.f alpha:1.f]];
            [[UIButton appearanceWhenContainedIn:[UISearchBar class], nil] setTintColor:[UIColor clearColor]];
            break;
        }
        
        
        /**
         在这里还可以遍历得到 UISearchBarTextField，即搜索输入框，
         */
        
        [self allview:aview indent:indent];
    }
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    /**
     这一句是关键，从而可以在下面：
     -(void)allview:(UIView *)rootview indent:(NSInteger)indent
     中拿到 取消按钮，
     */
    [searchBar setShowsCancelButton:YES animated:YES];
    
    
    [self allview:searchBar indent:0];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/** PS:
 
  Displaying the search bar in a navigation bar will override the contentsController's navigationItem if it has one.
可以让搜索框位于导航条里面
@property (nonatomic, assign) BOOL displaysSearchBarInNavigationBar NS_AVAILABLE_IOS(7_0);




//当使用UISearchDisplayController之后，你是否发现，当键盘弹出来的时候，会默认把navagationBar给隐藏起来，如果说不需要隐藏navagationBar，最好的处理方式就是重写UISearchDisplayController的-(void)setActive:(BOOL)visible animated:(BOOL)animated方法：
//首先，自定义一个类CustomSearchDisplayController，继承自UISearchDisplayController，然后在.m文件中重写该方法，并在该方法中主动显示navagationBar，
#import "CustomSearchDisplayController.h"

@implementation CustomSearchDisplayController

-(void)setActive:(BOOL)visible animated:(BOOL)animated
{
    [super setActive:visible animated:animated];
    [self.searchContentsController.navigationController setNavigationBarHidden: NO animated: NO];
}

@end





//当没有匹配的结果时，默认会在tableView上显示一个“No Result”的标签，如果说想自定义这个标签，可以在tableview中循环遍历出该标签，然后按照你的想法去设置：
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    if ([filteredListPinYin count] == 0) {
        UITableView *tableView1 = self.searchDisplayController.searchResultsTableView;
        for( UIView *subview in tableView1.subviews ) {
            if( [subview class] == [UILabel class] ) {
                UILabel *lbl = (UILabel*)subview; // sv changed to subview.
                lbl.text = @"没有结果";
            }
        }
    }
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

 */

@end













