//
//  Bushou_FMDB.m
//  ItemDictionary
//
//  Created by 3014 on 16/7/22.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "Bushou_FMDB.h"
#import "BusouModel.h"
@implementation Bushou_FMDB

+ (NSArray *)buShoudataBase{
    NSMutableArray *array = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"aaaaa2" ofType:@"sqlite"];

    FMDatabase *data = [[FMDatabase alloc] initWithPath:path];
    [data open];
    FMResultSet *result = [data executeQuery:@"select * from ol_bushou"];
    while ([result next]) {
        BusouModel *bushou = [BusouModel new];
        bushou.title = [result stringForColumn:@"title"];
        bushou.bihua = [result intForColumn:@"bihua"];
        bushou.ID = [result intForColumn:@"id"];
        [array addObject:bushou];
        
        
    }
    return array;
}
@end
