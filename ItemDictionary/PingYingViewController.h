//
//  PingYingViewController.h
//  ItemDictionary
//
//  Created by 3014 on 16/7/20.
//  Copyright © 2016年 3014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FMDB.h>
@interface PingYingViewController : UIViewController
@property(nonatomic,strong) NSMutableArray *dataSource;
@property(nonatomic,strong) FMDatabase *dataBase;
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,assign) BOOL pinyin;


@end
