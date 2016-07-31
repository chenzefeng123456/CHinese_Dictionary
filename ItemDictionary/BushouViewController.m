//
//  BushouViewController.m
//  ItemDictionary
//
//  Created by 3014 on 16/7/22.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "BushouViewController.h"
#import "BusouModel.h"
#import "Bushou_FMDB.h"
#import "SourcePinYinViewController.h"
@interface BushouViewController ()<UITableViewDelegate,UITableViewDataSource>

{
        NSArray *arr;
        NSArray *array;
}

@property(nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) NSMutableArray *muTable;

@end

@implementation BushouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_myTableView];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
     _muTable = [NSMutableArray array];
    [self initData];
      
}

- (void)initData{
     arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"1 2",@"13",@"14",@"15",@"16",@"17"];
    
      array = @[@"第一笔",@"第二笔",@"第三笔",@"第四笔",@"第五笔",@"第六笔",@"第七笔",@"第八笔",@"第九笔",@"第十笔",@"第十一笔",@"第十二笔",@"第十三笔",@"第十四笔",@"第十五笔",@"第十六笔",@"第十七笔"];
    NSArray *arrayBu = [Bushou_FMDB buShoudataBase];
    for (int i = 0; i < 17; i++) {
        NSMutableArray *muTa = [NSMutableArray array];
        for (BusouModel *bushou in arrayBu) {
            if (bushou.bihua == [arr[i] intValue] ) {
                [muTa addObject:bushou];
            }
        }
        [self.muTable addObject:muTa];
    }
       NSLog(@"muTable = %@",_muTable);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.index-1001];
    [self.myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr1 = self.muTable[section];
    return arr1.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   
    NSString *string = array[section];
    return string;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSArray *arr2 = self.muTable[indexPath.section];
    BusouModel *buShou = arr2[indexPath.row];
    cell.textLabel.text = buShou.title;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.muTable.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SourcePinYinViewController *bu = [SourcePinYinViewController new];
    bu.isPinyin = NO;
    NSArray *data = _muTable[indexPath.section];
    BusouModel *bushou = data[indexPath.row];
    bu.urlID = bushou.ID;
    [self.navigationController pushViewController:bu animated:YES];
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return array;
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
