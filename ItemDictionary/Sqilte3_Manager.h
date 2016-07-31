//
//  Sqilte3_Manager.h
//  ItemDictionary
//
//  Created by 3014 on 16/7/21.
//  Copyright © 2016年 3014. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "describeModel.h"
@interface Sqilte3_Manager : NSObject
//@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) NSString *pinyin;
- (NSArray *)sqilte3;

- (void)collectFMDB:(describeModel *)describe;
- (BOOL)deleteData:(NSString *)describe;
+ (NSArray *)collectCell;
@end
