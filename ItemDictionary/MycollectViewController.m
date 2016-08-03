//
//  MycollectViewController.m
//  ItemDictionary
//
//  Created by 3014 on 16/7/18.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "MycollectViewController.h"
#import "describeModel.h"
#import "MycollectTableViewCell.h"
#import "Sqilte3_Manager.h"
#import "DescribeViewController.h"
@interface MycollectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *urlstring;
}
@property(nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) NSArray *dataSource;
@end

@implementation MycollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]];
    
    self.myTableView.rowHeight = 85;
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
    [self.myTableView registerNib:[UINib nibWithNibName:@"MycollectTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([MycollectTableViewCell class])];

   
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUIView];
  
}
- (void)setUIView{
    self.dataSource = [Sqilte3_Manager collectCell];

       [self.myTableView reloadData];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   MycollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MycollectTableViewCell class])];
    cell.backgroundColor = [UIColor clearColor];
    describeModel *des = self.dataSource[indexPath.row];
    cell.miZiLabel.text = des.miZiTian;
    urlstring = des.miZiTian;
    cell.pinyinLabel.text = des.pinYin;
    cell.bushouLabel.text = des.bushou;
    cell.bihuaLabel.text = des.bihua;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DescribeViewController *des = [[DescribeViewController alloc] initWithNibName:@"DescribeViewController" bundle:[NSBundle mainBundle]];
    des.string = urlstring;
    des.describe = self.dataSource[indexPath.row];
    NSLog(@"base = %@",des.describe.baseMessege);
    [self.navigationController pushViewController:des animated:YES];
    
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
