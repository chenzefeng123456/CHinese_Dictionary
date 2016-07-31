//
//  Sqilte3_Manager.m
//  ItemDictionary
//
//  Created by 3014 on 16/7/21.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "Sqilte3_Manager.h"
#import "describeModel.h"

@implementation Sqilte3_Manager

- (NSArray *)sqilte3{
  
    FMDatabase *dataBase;
    NSString *string = [[NSBundle mainBundle] pathForResource:@"aaaaa2" ofType:@"sqlite"];
    NSMutableArray *array = [NSMutableArray array];
    dataBase = [FMDatabase databaseWithPath:string];
    [dataBase open];
    
    FMResultSet *result = [dataBase executeQuery:@"select * from ol_pinyins"];
    while ([result next]) {
        NSString *str =[result stringForColumn:@"pinyin"];
        
        [array addObject:str];
    }
    return array;
}

- (void)collectFMDB:(describeModel *)describe{
  
    NSLog(@"des = %p",describe);
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"document.sqlite"];
    NSLog(@"%@",path);
    FMDatabase *dataBase = [[FMDatabase alloc] initWithPath:path];
    [dataBase open];
    NSLog(@"path = %@",path);
    if ([dataBase executeUpdate:@"create table if not exists Dic(simp text primary key,pinyin text,bushou text,shenyin text,bihua text)"]) {
        if ([dataBase executeUpdate:@"insert or replace into Dic(simp,pinyin,bushou,shenyin,bihua)values(?,?,?,?,?)",describe.miZiTian,describe.pinYin,describe.bushou,describe.shenyin,describe.bihua]) {
            
        }
    }

}

+ (NSArray *)collectCell{
    
    NSMutableArray *muTable = [NSMutableArray array];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject] stringByAppendingPathComponent:@"document.sqlite"];
    FMDatabase *data = [[FMDatabase alloc] initWithPath:path];
    [data open];
    FMResultSet *result = [data executeQuery:@"select * from Dic"];
    while ([result next]) {
        describeModel *describe = [describeModel new];
        describe.miZiTian = [result stringForColumn:@"simp"];
        describe.pinYin = [result stringForColumn:@"pinyin"];
        describe.bushou = [result stringForColumn:@"bushou"];
        describe.shenyin = [result stringForColumn:@"shenyin"];
        describe.bihua = [result stringForColumn:@"bihua"];
        [muTable addObject:describe];
    }
    return muTable;
}

- (BOOL)deleteData:(NSString *)describe{
   
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"document.sqlite"];
    FMDatabase *data = [FMDatabase databaseWithPath:path];
    [data open];
    BOOL delete = [data executeUpdate:@"delete from Dic where simp = ?",describe];
    return delete;
    
}
@end
