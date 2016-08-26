
#import "SourcePinYinViewController.h"
#import "PinYinTableViewCell.h"
#import "PinYinModel.h"
#import "DescribeViewController.h"
#import "BushouViewController.h"
#import <MBProgressHUD.h>
#import <MJRefresh.h>
@interface SourcePinYinViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *str;
    int index;
}
@property(nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation SourcePinYinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
//    self.automaticallyAdjustsScrollViewInsets = NO;
  
    [self.view addSubview:_myTableView];
    [self.myTableView registerNib:[UINib nibWithNibName:@"PinYinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PinYinTableViewCell class])];
   
    self.myTableView.rowHeight = 75;
    [self initData];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self setNavigationBarUI];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initData)];
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerDataAction)];
   
}

- (void)footerDataAction{
   
    if (self.isPinyin) {
        str = [NSString stringWithFormat:@"http://www.chazidian.com/service/pinyin/%@/%d/10",self.urlString,index*10];
        
    }else{
        str = [NSString stringWithFormat:@"http://www.chazidian.com/service/bushou/%d/%d/10",self.urlID,index*10];
    }
    NSURL *url = [NSURL URLWithString:str];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        NSDictionary *dict = dic[@"data"];
        NSArray *array = dict[@"words"];
        for (NSDictionary *dic in array) {
            BOOL hasWord = NO;
            for (PinYinModel *pin in self.dataSource) {
                if ([pin.text isEqualToString:dic[@"simp"]]) {
                    hasWord = YES;
                    break;
                }
            }
            if (hasWord) {
                continue;
            }
            PinYinModel *pin = [PinYinModel new];
            pin.text = dic[@"simp"];
            pin.shenyin = dic[@"yin"][@"pinyin"];
            pin.yintiao = [NSString stringWithFormat:@"[ %@ ]", pin.shenyin];
            pin.bushou = dic[@"bushou"];
            //            pin.zhuyin = dic[@"yin"][@"zhuyin"];
            pin.bushou = [NSString stringWithFormat:@"部首 :  %@",pin.bushou];
            pin.sound = dic[@"sound"];
            pin.bihua = dic[@"num"];
            pin.bihua = [NSString stringWithFormat:@"笔画 :  %@",pin.bihua];
            [self.dataSource addObject:pin];
            dispatch_async(dispatch_get_main_queue(), ^{
            
                [self.myTableView.mj_header endRefreshing];
                [_myTableView reloadData];
                if ([dic[@"data"][@"page"][@"pagenum"] intValue] == [dic[@"data"][@"page"][@"curpage"] intValue]) {
                    [_myTableView.mj_footer endRefreshingWithNoMoreData];
                }
                  index++;
            });
            
            
        }
        
    }];
    [task resume];
}
- (void)setNavigationBarUI{
    self.myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]];
    self.title = self.urlString;
}

- (void)initData{
    self.myTableView.mj_footer.state = MJRefreshStateIdle;
    index = 0;

    if (self.isPinyin) {
    str = [NSString stringWithFormat:@"http://www.chazidian.com/service/pinyin/%@/0/10",self.urlString];

    }else{
        str = [NSString stringWithFormat:@"http://www.chazidian.com/service/bushou/%d/0/10",self.urlID];
    }
    NSURL *url = [NSURL URLWithString:str];
  

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
                _dataSource = [NSMutableArray array];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        NSDictionary *dict = dic[@"data"];
        NSArray *array = dict[@"words"];
        for (NSDictionary *dic in array) {
            PinYinModel *pin = [PinYinModel new];
            pin.text = dic[@"simp"];
            pin.shenyin = dic[@"yin"][@"pinyin"];
            pin.yintiao = [NSString stringWithFormat:@"[ %@ ]", pin.shenyin];
            pin.bushou = dic[@"bushou"];
//            pin.zhuyin = dic[@"yin"][@"zhuyin"];
            pin.bushou = [NSString stringWithFormat:@"部首 :  %@",pin.bushou];
            pin.sound = dic[@"sound"];
            pin.bihua = dic[@"num"];
            pin.bihua = [NSString stringWithFormat:@"笔画 :  %@",pin.bihua];
            [self.dataSource addObject:pin];
            dispatch_async(dispatch_get_main_queue(), ^{
              
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.myTableView.mj_header endRefreshing];
                  [_myTableView reloadData];
                 index++;
            });

            
        }
      
        
        
       
       
       
       
       
    }];
    [task resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PinYinTableViewCell *cell = (PinYinTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PinYinTableViewCell class])];
    PinYinModel *pinYin = self.dataSource[indexPath.row];
    cell.pinYinLabel.text = pinYin.text;
    cell.yindiaoLabel.text = pinYin.yintiao;
    cell.bushouLabel.text = pinYin.bushou;
    cell.bihuaLabel.text = pinYin.bihua;
//    cell.yindiaoTweLabel.text = pinYin.zhuyin;
    cell.backgroundColor = [UIColor clearColor];
    NSLog(@"cell = %@",cell.pinYinLabel.text);
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DescribeViewController *dis = [[DescribeViewController alloc] initWithNibName:@"DescribeViewController" bundle:[NSBundle mainBundle]];
    PinYinModel *pin = _dataSource[indexPath.row];
    dis.string = pin.text;
   
    NSLog(@"yin = %@",dis.yinString);
    [self.navigationController pushViewController:dis animated:YES];
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
