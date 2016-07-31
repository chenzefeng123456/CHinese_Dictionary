//
//  MorePageViewController.m
//  ItemDictionary
////  Created by 3014 on 16/7/18.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "MorePageViewController.h"
#import "AboutWeTableViewCell.h"
#import "UserScoreViewController.h"
#import "MycollectViewController.h"
#import "ShareViewController.h"
#import "GoodUseViewController.h"
#import "AboutViewController.h"
#import "OpinionViewController.h"
#import "MycollectViewController.h"
@interface MorePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@end

@implementation MorePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationUI];
    [self tableviewUI];

     self.dataSource = @[@"我的收藏",@"分享",@"意见反馈",@"精品应用",@"应用打分",@"关于我们"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AboutWeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([AboutWeTableViewCell class])];
    self.title = @"汉语字典";
}

- (void)setNavigationUI{
    UIImageView *imageviewBack = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageviewBack.image = [UIImage imageNamed:@"beijing"];
    [self.view addSubview:imageviewBack];
    UIImage *image = [UIImage imageNamed:@"return"];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(returnAction)];
    self.navigationItem.leftBarButtonItem = bar;
    
}

- (void)tableviewUI{
    
   self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
   self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AboutWeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AboutWeTableViewCell class])];
    cell.backgroundColor = [UIColor clearColor];
    cell.messageLabel.font = [UIFont systemFontOfSize:25];
   NSString *string  = self.dataSource[indexPath.row];
    cell.messageLabel.text =string;
    cell.backImage.image = [UIImage imageNamed:@"continue"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            MycollectViewController *myCollect = [MycollectViewController new];
            [self.navigationController pushViewController:myCollect animated:YES];
        }
            
            break;
        case 1:{
            UserScoreViewController *user = [UserScoreViewController new];
            [self.navigationController pushViewController:user animated:YES];
        }
            break;
        case 2:{
            OpinionViewController *opinion = [OpinionViewController new];
            [self.navigationController pushViewController:opinion animated:YES];
        }
            break;
        case 3:{
            GoodUseViewController *good = [GoodUseViewController new];
            [self.navigationController pushViewController:good animated:YES];
        }
            break;
        case 4:{
            UserScoreViewController *user = [UserScoreViewController new];
            [self.navigationController pushViewController:user animated:YES];
        }
            break;
        case 5:{
           AboutViewController *we = [AboutViewController new];
            [self.navigationController pushViewController:we animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)returnAction{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
