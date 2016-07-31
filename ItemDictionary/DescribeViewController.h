//
//  DescribeViewController.h
//  ItemDictionary
//
//  Created by 3014 on 16/7/24.
//  Copyright © 2016年 3014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "describeModel.h"
@interface DescribeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *miziLabel;
@property (weak, nonatomic) IBOutlet UILabel *pinyinLabel;
@property (weak, nonatomic) IBOutlet UILabel *fantiLabel;
@property (weak, nonatomic) IBOutlet UILabel *bushouLabel;
@property (weak, nonatomic) IBOutlet UILabel *bishunLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuyinLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiegouLabel;
@property (weak, nonatomic) IBOutlet UILabel *bushouBIhuaLabel;
@property (weak, nonatomic) IBOutlet UILabel *bihuaLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *describeScroll;
@property(nonatomic,strong) NSString *yindiao;
@property(nonatomic,strong) NSString *string;
@property(nonatomic,strong) NSString *yinString;
@property(nonatomic,strong) NSString *zhu;
@property(nonatomic,strong) describeModel *describe;



@end
