
#import "PingYingViewController.h"
#import <FMDB.h>
#import "Sqilte3_Manager.h"
#import "SourcePinYinViewController.h"

@interface PingYingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView1;
    NSArray *arrySpell;
    NSMutableArray *muTable1;
    NSArray *arr;
}
@end

@implementation PingYingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableView1 = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView1.delegate = self;
    tableView1.dataSource = self;
//    tableView1.sectionIndexBackgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"Key-frame3"]] ;
    self.dataSource = [NSMutableArray array];
    [self initData];
    tableView1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]];
    [self.view addSubview:tableView1];
    muTable1 = [NSMutableArray array];
    for (NSString *str in arrySpell) {
        NSString *string =[str uppercaseString];
        [muTable1 addObject:string];
    }
    
   
    
}


- (void)initData{
    Sqilte3_Manager *sqi = [Sqilte3_Manager new];
    arr = [sqi sqilte3];
   
    arrySpell = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    for (int i = 0; i < 26; i++) {
        
        int k = 0;
        NSMutableArray *muTable = [NSMutableArray array];

        for (NSString *str in arr) {
            
        k++;
        if (k <= 26) {
            continue;
            }
        if ([str hasPrefix:arrySpell[i]]) {
             [muTable addObject:str];
            }
           
            
        }
        [self.dataSource addObject:muTable];
       
    }
   // NSLog(@"%@",_dataSource);

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.index -1001];
    if (self.index-1001 == 8||self.index-1001==21) {
    indexPath = [NSIndexPath indexPathForRow:0 inSection:self.index - 1000];

    }else if (self.index-1001==20){
        indexPath = [NSIndexPath indexPathForRow:0 inSection:self.index - 999];

    }
    [tableView1 scrollToRowAtIndexPath:indexPath atScrollPosition: UITableViewScrollPositionTop animated:YES];
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
         cell.backgroundColor = [UIColor clearColor];
}
    NSArray *pin = self.dataSource[indexPath.section];
    cell.textLabel.text = pin[indexPath.row];
   // NSLog(@"cell = %@",cell.textLabel.text);

    
  
    return cell;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
   
       return muTable1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataSource[section];
    return array.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str = arrySpell[section];
    return [str uppercaseString];
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   SourcePinYinViewController *pin = [SourcePinYinViewController new];
    NSArray *arrayData = self.dataSource[indexPath.section];
    pin.isPinyin = YES;
    pin.urlString = arrayData[indexPath.row];
    NSLog(@"str = %@",pin.urlString);
    [self.navigationController pushViewController:pin animated:YES];
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
