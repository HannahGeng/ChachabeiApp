//
//  DatabaseManager.m
//  什么值得买
//
//  Created by iJeff on 16/1/12.
//  Copyright (c) 2016年 iJeff. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager
{
    FMDatabase *db;
    AppDelegate * app;
}

//单例
+(DatabaseManager *)sharedManger
{
    static DatabaseManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DatabaseManager alloc] init];
    });
    return instance;
}

-(instancetype)init
{
    if (self = [super init]) {
        
        //1, 创建数据库操作对象
        db = [FMDatabase databaseWithPath:[self dbPath]];
        
        //打开数据库
        BOOL ret = [db open];
        NSLog(@"数据库打开:%@", ret ? @"成功" : @"失败");
        
        //2, 创建表
        BOOL ret2 = [self createTable];
        NSLog(@"表创建:%@", ret2 ? @"成功" : @"失败");
    }
    return self;
}

//创建表
-(BOOL)createTable
{
    NSString *sql = @"create table if not exists Companys(id integer primary key autoincrement, company_name text, province_name text)";
    
    return [db executeUpdate:sql];
}

//插入数据
-(BOOL)insertCompanys:(NSString *)companyName cityName:(NSString *)cityName
{
    app = [AppDelegate sharedAppDelegate];
    NSString *sql = @"insert into Companys(company_name,province_name) values(?,?)";
        
    //插入搜索历史
    return [db executeUpdate:sql, app.keyword,app.province];
}

//获取数据
-(NSArray *)getAllCompanys
{
    app = [AppDelegate sharedAppDelegate];
    NSMutableArray * marr = [NSMutableArray new];
    
    NSString *sql = @"select * from Companys";
    
    FMResultSet *set = [db executeQuery:sql];
    
    while ([set next]) {
        
        //model
        NSString * company_name = [set stringForColumn:@"company_name"];
        NSString * province_name = [set stringForColumn:@"province_name"];
                
        app.keyword = company_name;
        app.province = province_name;
        
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:app.keyword,@"company_name",app.province,@"province_name", nil];
        
        [marr addObject:dic];
    }
    
    return marr;
}

- (void)removeAllCompanys
{
    NSString *sql = @"delete from Companys";
    //执行sql语句: 删除
    BOOL ret = [db executeUpdate:sql];
    
    NSLog(@"删除数据:%@", ret ? @"成功!":@"失败!");

}

//数据库文件的存储路径
-(NSString *)dbPath
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    return [path stringByAppendingPathComponent:@"company.db"];
}

@end
