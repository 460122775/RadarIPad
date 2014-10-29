//
//  DBModel.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/22/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "DBModel.h"

#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

@implementation DBModel

+ (void)initDB
{
//    NSString *dbPath = @"/tmp/bugreportsample.db";
//    NSString *dbPath = NSTemporaryDirectory();
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:DBPath withIntermediateDirectories:YES attributes:nil error:nil];
    if (bo)
    {
        // delete the old db if it exists
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:DBPath error:nil];
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:DBPath];
        [queue inDatabase:^(FMDatabase *db) {
            BOOL worked = [db executeUpdate:@"create table t_color (colorType integer, colorData text)"];
            FMDBQuickCheck(worked);
            
            worked = [db executeUpdate:@"CREATE TABLE t_productcfg (type integer, name text, ename text, config text, user_id integer, needConfig integer, isBaseProduct integer) "];
            FMDBQuickCheck(worked);
            
            //**************Test Data***************
            worked = [db executeUpdate:@"INSERT INTO t_productcfg VALUES ('3', '基本反射率', 'Z', null, '-1', '1', '0'),('65', '基本粒子', 'HCL', null, '-1', '0', '0'),('4', '基本速度', 'V', null, '-1', '1', '0'),('5', '基本谱宽', 'W', null, '-1', '1', '0'),('10', '垂直最大反射率', 'MAXREF', null, '-1', '1', '1'),('17', '多层反射率CAPPI', 'MZCAPPI', null, '-1', '0', '1'),('64', '多层粒子CAPPI', 'MHCLCAPPI', null, '-1', '0', '1'),('6', '回波顶高', 'ET', null, '-1', '1', '1'),('7', '回波底高', 'EB', null, '-1', '1', '1'),('25', '垂直累积液态含水量', 'VIL', null, '-1', '1', '1'),('29', '谱宽垂直切割', 'SCS', null, '-1', '0', '1'),('19', '阵风锋识别', 'GFD', null, '-1', '0', '1'),('22', '回波底高等值线', 'EBC', null, '-1', '0', '1'),('21', '回波顶高等值线', 'ETC', null, '-1', '0', '1'),('51', '下击暴流识别', 'DDPD', null, '-1', '0', '1'),('23', '垂直最大回波等值线', 'CRC', null, '-1', '0', '1'),('18', '一次产品(PPI)', 'PPI', null, '-1', '0', '0'),('2', '体扫', 'VOL', null, '-1', '0', '0'),('1', '距离高度显示', 'RHI', null, '-1', '1', '0'),('53', '大气波导', 'RFC', null, '-1', '0', '0'),('52', '未滤波反射率', 'UnZ', null, '-1', '0', '0'),('8', '等高平面位置显示', 'CAPPI', null, '-1', '1', '1'),('49', '风暴识别与追踪预报', 'STI', null, '-1', '0', '3'),('15', '龙卷涡旋识别', 'TVS', null, '-1', '0', '1'),('48', '风暴结构', 'SS', null, '-1', '0', '1'),('49', 'SCTI', 'SCTI', null, '-1', '0', '3'),('43', '方位涡度', 'ARD', null, '-1', '0', '1'),('14', '中尺度气旋识别', 'M', null, '-1', '0', '1'),('16', '风场反演', 'IVAP', null, '-1', '0', '1'),('38', '风暴总降水', 'STP', null, '-1', '0', '3'),('36', '一小时降水量', 'OHP', null, '-1', '0', '3'),('35', '强天气概率', 'SWP', null, '-1', '0', '1'),('39', '雨强', 'RZ', null, '-1', '0', '1'),('40', '冰雹潜势预测', 'HPF', null, '-1', '0', '1'),('37', '三小时降水量', 'THP', null, '-1', '0', '3'),('13', '区域降水总量', 'CATCH', null, '-1', '0', '3'),('11', 'MAX', 'MAX', null, '-1', '0', '1'),('50', '暴雨回波识别', 'SEI', null, '-1', '0', '1'),('55', '冰雹指数', 'HI', null, '-1', '0', '1'),('32', '垂直风廓线', 'VWP', null, '-1', '0', '3'),('26', '组合反射率平均值', 'LRA', null, '-1', '0', '1'),('34', '分层组合湍流最大值', 'LTM', null, '-1', '0', '1'),('33', '分层组合湍流平均值', 'LTA', null, '-1', '0', '1'),('27', '组合反射率最大值', 'LRM', null, '-1', '0', '1'),('28', '速度垂直切割', 'VCS', null, '-1', '0', '1'),('12', '用户可选降水', 'USP', null, '-1', '0', '3'),('9', '反射率垂直切割', 'RCS', null, '-1', '0', '1'),('42', '组合切变', 'CS', null, '-1', '0', '1'),('62', '多层速度CAPPI', 'MVCAPPI', null, '-1', '0', '1'),('63', '多层谱宽CAPPI', 'MWCAPPI', null, '-1', '0', '1'),('66', '粒子垂直切割', 'HCLCS', null, '-1', '0', '1'),('24', '速度方位显示', 'VAD', null, '-1', '0', '1'),('44', '径向速度散度', 'RVD', null, '-1', '0', '1')"];
            FMDBQuickCheck(worked);
            //**************Test Data***************
            
        }];
        [queue close];
    }
}

+ (NSString*) getProductData:(int) type andCurrentData:(NSString*) currentData
{
//    DLog(@"1:%@", currentData);
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:DBPath];
    if (queue)
    {
        __block NSString *resultStr = currentData;
        [queue inDatabase:^(FMDatabase *db){
            FMResultSet *rs = nil;
            int layer = [[currentData substringWithRange:NSMakeRange(17, 2)] intValue];
            int productType = [[currentData substringWithRange:NSMakeRange(20, 3)] intValue];
            
            if(type == 1 && layer >0)
            {
                layer--;
                rs = [db executeQuery:[NSString
                         stringWithFormat:@"select * from t_productdata where posFile like '%@%%' and type=%i and layer=%i", [currentData substringToIndex:17], productType, layer]];
            }else if(type == 2 && layer < 13){
                layer++;
                rs = [db executeQuery:[NSString
                                       stringWithFormat:@"select posFile from t_productdata where posFile like '%@%%' and type=%i and layer=%i", [currentData substringToIndex:17], productType, layer]];
            }else if(type == 3){
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyyMMdd_HHmmss"];
                NSDate *date = [dateFormatter dateFromString:[currentData substringWithRange:NSMakeRange(1, 15)]];
                rs = [db executeQuery:[NSString
                                       stringWithFormat:@"select posFile from t_productdata where time < %f and type=%i and layer=%i order by time desc limit 1", date.timeIntervalSince1970, productType, layer]];
            }else if (type == 4){
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyyMMdd_HHmmss"];
                NSDate *date = [dateFormatter dateFromString:[currentData substringWithRange:NSMakeRange(1, 15)]];
                rs = [db executeQuery:[NSString
                                       stringWithFormat:@"select posFile from t_productdata where time > %f and type=%i and layer=%i order by time asc limit 1", date.timeIntervalSince1970, productType, layer]];
            }
            if([rs next])
            {
                resultStr = [rs stringForColumn:@"posFile"];
//                DLog(@"2:%@", currentData);
            }
            [rs close];
        }];
        [queue close];
        if(resultStr != nil && resultStr.length > 0) currentData = resultStr;
    }
//    DLog(@"3:%@", currentData);
    return currentData;
}

@end
