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
        [queue inDatabase:^(FMDatabase *db) { BOOL worked = [db executeUpdate:@"create table t_color (colorType integer, colorData text)"];
            FMDBQuickCheck(worked);
            
            worked = [db executeUpdate:@"CREATE TABLE t_productcfg (type integer, name text, ename text, config text, user_id integer, needConfig integer, isBaseProduct integer) "];
            FMDBQuickCheck(worked);
            
            worked = [db executeUpdate:@"CREATE TABLE t_productdata (name text, posFile text, filesize integer, posPicture text, type integer, radarID integer, time integer, layer integer, scanmode integer, process integer, note text, mcode text) "];
            FMDBQuickCheck(worked);
            
            //**************Test Data***************
            worked = [db executeUpdate:@"INSERT INTO t_productcfg VALUES ('3', '基本反射率', 'Z', null, '-1', '1', '0'),('65', '基本粒子', 'HCL', null, '-1', '0', '0'),('4', '基本速度', 'V', null, '-1', '1', '0'),('5', '基本谱宽', 'W', null, '-1', '1', '0'),('10', '垂直最大反射率', 'MAXREF', null, '-1', '1', '1'),('17', '多层反射率CAPPI', 'MZCAPPI', null, '-1', '0', '1'),('64', '多层粒子CAPPI', 'MHCLCAPPI', null, '-1', '0', '1'),('6', '回波顶高', 'ET', null, '-1', '1', '1'),('7', '回波底高', 'EB', null, '-1', '1', '1'),('25', '垂直累积液态含水量', 'VIL', null, '-1', '1', '1'),('29', '谱宽垂直切割', 'SCS', null, '-1', '0', '1'),('19', '阵风锋识别', 'GFD', null, '-1', '0', '1'),('22', '回波底高等值线', 'EBC', null, '-1', '0', '1'),('21', '回波顶高等值线', 'ETC', null, '-1', '0', '1'),('51', '下击暴流识别', 'DDPD', null, '-1', '0', '1'),('23', '垂直最大回波等值线', 'CRC', null, '-1', '0', '1'),('18', '一次产品(PPI)', 'PPI', null, '-1', '0', '0'),('2', '体扫', 'VOL', null, '-1', '0', '0'),('1', '距离高度显示', 'RHI', null, '-1', '1', '0'),('53', '大气波导', 'RFC', null, '-1', '0', '0'),('52', '未滤波反射率', 'UnZ', null, '-1', '0', '0'),('8', '等高平面位置显示', 'CAPPI', null, '-1', '1', '1'),('49', '风暴识别与追踪预报', 'STI', null, '-1', '0', '3'),('15', '龙卷涡旋识别', 'TVS', null, '-1', '0', '1'),('48', '风暴结构', 'SS', null, '-1', '0', '1'),('49', 'SCTI', 'SCTI', null, '-1', '0', '3'),('43', '方位涡度', 'ARD', null, '-1', '0', '1'),('14', '中尺度气旋识别', 'M', null, '-1', '0', '1'),('16', '风场反演', 'IVAP', null, '-1', '0', '1'),('38', '风暴总降水', 'STP', null, '-1', '0', '3'),('36', '一小时降水量', 'OHP', null, '-1', '0', '3'),('35', '强天气概率', 'SWP', null, '-1', '0', '1'),('39', '雨强', 'RZ', null, '-1', '0', '1'),('40', '冰雹潜势预测', 'HPF', null, '-1', '0', '1'),('37', '三小时降水量', 'THP', null, '-1', '0', '3'),('13', '区域降水总量', 'CATCH', null, '-1', '0', '3'),('11', 'MAX', 'MAX', null, '-1', '0', '1'),('50', '暴雨回波识别', 'SEI', null, '-1', '0', '1'),('55', '冰雹指数', 'HI', null, '-1', '0', '1'),('32', '垂直风廓线', 'VWP', null, '-1', '0', '3'),('26', '组合反射率平均值', 'LRA', null, '-1', '0', '1'),('34', '分层组合湍流最大值', 'LTM', null, '-1', '0', '1'),('33', '分层组合湍流平均值', 'LTA', null, '-1', '0', '1'),('27', '组合反射率最大值', 'LRM', null, '-1', '0', '1'),('28', '速度垂直切割', 'VCS', null, '-1', '0', '1'),('12', '用户可选降水', 'USP', null, '-1', '0', '3'),('9', '反射率垂直切割', 'RCS', null, '-1', '0', '1'),('42', '组合切变', 'CS', null, '-1', '0', '1'),('62', '多层速度CAPPI', 'MVCAPPI', null, '-1', '0', '1'),('63', '多层谱宽CAPPI', 'MWCAPPI', null, '-1', '0', '1'),('66', '粒子垂直切割', 'HCLCS', null, '-1', '0', '1'),('24', '速度方位显示', 'VAD', null, '-1', '0', '1'),('44', '径向速度散度', 'RVD', null, '-1', '0', '1')"];
            FMDBQuickCheck(worked);
            
            worked = [db executeUpdate:@"INSERT INTO t_color(colorType, colorData) values(3, '17,dbz,-32,0,0,3,26,-20,127,194,229,30,-5,0,174,165,10,0,198,195,255,10,5,123,113,239,10,10,24,36,214,10,15,165,255,173,10,20,0,235,0,10,25,16,146,24,10,30,255,247,99,10,35,206,203,0,10,40,140,142,0,10,45,255,174,173,10,50,255,101,90,10,55,239,0,49,10,60,214,142,255,10,65,173,36,255,59,94.5'),(4, '15,m/s,-63.5,0,0,0,2,-63.5,123,227,255,73,-27.0,0,227,255,14,-20.0,0,178,181,10,-15.0,0,255,0,10,-10.0,0,199,0,10,-5.0,0,130,0,8,-1.0,254,254,254,2,0.0,252,252,252,2,1.0,255,0,0,8,5.0,255,89,90,10,10.0,255,178,181,10,15.0,255,125,0,10,20.0,255,211,0,14,27.0,255,255,0,72,63.0'),(5, '15,m/s,-24.0,0,0,0,129,0.0,231,227,231,2,1.0,123,227,231,2,2.0,0,227,231,2,3.0,0,157,181,2,4.0,0,255,255,2,5.0,0,199,0,2,6.0,0,130,0,2,7.0,255,255,0,2,8.0,255,211,0,2,9.0,255,125,0,2,10.0,255,178,181,2,11.0,255,89,90,2,12.0,255,0,0,2,13.0,255,255,255,100,63.0')"];
            FMDBQuickCheck(worked);
            
            worked = [db executeUpdate:@"insert into t_productdata(name, posFile, filesize, posPicture, type, radarID, time, layer, scanmode, process, note, mcode)  values('20140701_000218.00.003.000_0.50.zdb','/20140701_000218.00.003.000_0.50.zdb',26739,'',3,0,1404144138,0,0,0,'','3-0.50'), ('20140701_000218.01.003.000_1.50.zdb','/20140701_000218.01.003.000_1.50.zdb',75619,'',3,0,1404144138,1,0,0,'','3-1.50'),('20140701_000218.02.003.000_2.40.zdb','/20140701_000218.02.003.000_2.40.zdb',97057,'',3,0,1404144138,2,0,0,'','3-2.40'),('20140701_000218.03.003.000_3.29.zdb','/20140701_000218.03.003.000_3.29.zdb',92011,'',3,0,1404144138,3,0,0,'','3-3.29'), ('20140701_000218.04.003.000_4.30.zdb','/20140701_000218.04.003.000_4.30.zdb',95693,'',3,0,1404144138,4,0,0,'','3-4.30'), ('20140701_000218.05.003.000_5.30.zdb','/20140701_000218.05.003.000_5.30.zdb',86010,'',3,0,1404144138,5,0,0,'','3-5.30'), ('20140701_000218.06.003.000_6.19.zdb','/20140701_000218.06.003.000_6.19.zdb',78401,'',3,0,1404144138,6,0,0,'','3-6.19'), ('20140701_00021, 8.07.003.000_7.50.zdb','/20140701_000218.07.003.000_7.50.zdb',70962,'',3,0,1404144138,7,0,0,'','3-7.50'), ('20140701_000218.08.003.000_8.69.zdb','/20140701_000218.08.003.000_8.69.zdb',67613,'',3,0,1404144138,8,0,0,'','3-8.69'), ('20140701_000218.09.003.000_10.00.zdb','/20140701_000218.09.003.000_10.00.zdb',54240,'',3,0,1404144138,9,0,0,'','3-10.00'), ('20140701_000218.10.003.000_12.00.zdb','/20140701_000218.10.003.000_12.00.zdb',52628,'',3,0,1404144138,10,0,0,'','3-12.00'), ('20140701_000218.11.003.000_14.00.zdb','/20140701_000218.11.003.000_14.00.zdb',43383,'',3,0,1404144138,11,0,0,'','3-14.00'), ('20140701_000218.12.003.000_16.70.zdb','/20140701_000218.12.003.000_16.70.zdb',38739,'',3,0,1404144138,12,0,0,'','3-16.70'), ('20140701_000218.13.003.000_19.50.zdb','/20140701_000218.13.003.000_19.50.zdb',33166,'',3,0,1404144138,13,0,0,'','3-19.50'), ('20140701_000908.00.003.000_0.50.zdb','/20140701_000908.00.003.000_0.50.zdb',24392,'',3,0,1404144548,0,0,0,'','3-0.50'), ('20140701_000908.01.003.000_1.50.zdb','/20140701_000908.01.003.000_1.50.zdb',67905,'',3,0,1404144548,1,0,0,'','3-1.50'), ('20140701_000908.02.003.000_2.40.zdb','/20140701_000908.02.003.000_2.40.zdb',94043,'',3,0,1404144548,2,0,0,'','3-2.40'), ('20140701_000908.03.003.000_3.29.zdb','/20140701_000908.03.003.000_3.29.zdb',96825,'',3,0,1404144548,3,0,0,'','3-3.29'), ('20140701_000908.04.003.000_4.30.zdb','/20140701_000908.04.003.000_4.30.zdb',94457,'',3,0,1404144548,4,0,0,'','3-4.30'), ('20140701_000908.05.003.000_5.30.zdb','/20140701_000908.05.003.000_5.30.zdb',83518,'',3,0,1404144548,5,0,0,'','3-5.30'), ('20140701_000908.06.003.000_6.19.zdb','/20140701_000908.06.003.000_6.19.zdb',75705,'',3,0,1404144548,6,0,0,'','3-6.19'), ('20140701_000908.07.003.000_7.50.zdb','/20140701_000908.07.003.000_7.50.zdb',67909,'',3,0,1404144548,7,0,0,'','3-7.50'), ('20140701_000908.08.003.000_8.69.zdb','/20140701_000908.08.003.000_8.69.zdb',56724,'',3,0,1404144548,8,0,0,'','3-8.69'), ('20140701_000908.09.003.000_10.00.zdb','/20140701_000908.09.003.000_10.00.zdb',49980,'',3,0,1404144548,9,0,0,'','3-10.00'), ('20140701_000908.10.003.000_12.00.zdb','/20140701_000908.10.003.000_12.00.zdb',50376,'',3,0,1404144548,10,0,0,'','3-12.00'), ('20140701_000908.11.003.000_14.00.zdb','/20140701_000908.11.003.000_14.00.zdb',35540,'',3,0,1404144548,11,0,0,'','3-14.00'), ('20140701_000908.12.003.000_16.70.zdb','/20140701_000908.12.003.000_16.70.zdb',31376,'',3,0,1404144548,12,0,0,'','3-16.70'), ('20140701_000908.13.003.000_19.50.zdb','/20140701_000908.13.003.000_19.50.zdb',31040,'',3,0,1404144548,13,0,0,'','3-19.50'), ('20140701_001556.00.003.000_0.50.zdb','/20140701_001556.00.003.000_0.50.zdb',25834,'',3,0,1404144956,0,0,0,'','3-0.50'), ('20140701_001556.01.003.000_1.50.zdb','/20140701_001556.01.003.000_1.50.zdb',69502,'',3,0,1404144956,1,0,0,'','3-1.50'), ('20140701_001556.02.003.000_2.40.zdb','/20140701_001556.02.003.000_2.40.zdb',99849,'',3,0,1404144956,2,0,0,'','3-2.40'), ('20140701_001556.03.003.000_3.29.zdb','/20140701_001556.03.003.000_3.29.zdb',99061,'',3,0,1404144956,3,0,0,'','3-3.29'), ('20140701_001556.04.003.000_4.30.zdb','/20140701_001556.04.003.000_4.30.zdb',97248,'',3,0,1404144956,4,0,0,'','3-4.30'), ('20140701_001556.05.003.000_5.30.zdb','/20140701_001556.05.003.000_5.30.zdb',89627,'',3,0,1404144956,5,0,0,'','3-5.30'), ('20140701_001556.06.003.000_6.19.zdb','/20140701_001556.06.003.000_6.19.zdb',70287,'',3,0,1404144956,6,0,0,'','3-6.19'), ('20140701_001556.07.003.000_7.50.zdb','/20140701_001556.07.003.000_7.50.zdb',66974,'',3,0,1404144956,7,0,0,'','3-7.50'), ('20140701_001556.08.003.000_8.69.zdb','/20140701_001556.08.003.000_8.69.zdb',56521,'',3,0,1404144956,8,0,0,'','3-8.69'), ('20140701_001556.09.003.000_10.00.zdb','/20140701_001556.09.003.000_10.00.zdb',57186,'',3,0,1404144956,9,0,0,'','3-10.00'), ('20140701_001556.10.003.000_12.00.zdb','/20140701_001556.10.003.000_12.00.zdb',41392,'',3,0,1404144956,10,0,0,'','3-12.00'), ('20140701_001556.11.003.000_14.00.zdb','/20140701_001556.11.003.000_14.00.zdb',44172,'',3,0,1404144956,11,0,0,'','3-14.00'), ('20140701_001556.12.003.000_16.70.zdb','/20140701_001556.12.003.000_16.70.zdb',36939,'',3,0,1404144956,12,0,0,'','3-16.70'), ('20140701_001556.13.003.000_19.50.zdb','/20140701_001556.13.003.000_19.50.zdb',36374,'',3,0,1404144956,13,0,0,'','3-19.50'), ('20140701_002311.00.003.000_0.50.zdb','/20140701_002311.00.003.000_0.50.zdb',25224,'',3,0,1404145391,0,0,0,'','3-0.50'), ('20140701_002311.01.003.000_1.50.zdb','/20140701_002311.01.003.000_1.50.zdb',70202,'',3,0,1404145391,1,0,0,'','3-1.50'), ('20140701_002311.02.003.000_2.40.zdb','/20140701_002311.02.003.000_2.40.zdb',84321,'',3,0,1404145391,2,0,0,'','3-2.40'), ('20140701_002311.03.003.000_3.29.zdb','/20140701_002311.03.003.000_3.29.zdb',93810,'',3,0,1404145391,3,0,0,'','3-3.29'), ('20140701_002311.04.003.000_4.30.zdb','/20140701_002311.04.003.000_4.30.zdb',89043,'',3,0,1404145391,4,0,0,'','3-4.30'), ('20140701_002311.05.003.000_5.30.zdb','/20140701_002311.05.003.000_5.30.zdb',82610,'',3,0,1404145391,5,0,0,'','3-5.30'), ('20140701_002311.06.003.000_6.19.zdb','/20140701_002311.06.003.000_6.19.zdb',73354,'',3,0,1404145391,6,0,0,'','3-6.19'), ('20140701_002311.07.003.000_7.50.zdb','/20140701_002311.07.003.000_7.50.zdb',59853,'',3,0,1404145391,7,0,0,'','3-7.50'), ('20140701_002311.08.003.000_8.69.zdb','/20140701_002311.08.003.000_8.69.zdb',54181,'',3,0,1404145391,8,0,0,'','3-8.69'), ('20140701_002311.09.003.000_10.00.zdb','/20140701_002311.09.003.000_10.00.zdb',53425,'',3,0,1404145391,9,0,0,'','3-10.00'), ('20140701_002311.10.003.000_12.00.zdb','/20140701_002311.10.003.000_12.00.zdb',47208,'',3,0,1404145391,10,0,0,'','3-12.00'), ('20140701_002311.11.003.000_14.00.zdb','/20140701_002311.11.003.000_14.00.zdb',40746,'',3,0,1404145391,11,0,0,'','3-14.00'), ('20140701_002311.12.003.000_16.70.zdb','/20140701_002311.12.003.000_16.70.zdb',36285,'',3,0,1404145391,12,0,0,'','3-16.70'), ('20140701_002311.13.003.000_19.50.zdb','/20140701_002311.13.003.000_19.50.zdb',34538,'',3,0,1404145391,13,0,0,'','3-19.50'), ('20140701_003003.00.003.000_0.50.zdb','/20140701_003003.00.003.000_0.50.zdb',24276,'',3,0,1404145803,0,0,0,'','3-0.50'), ('20140701_003003.01.003.000_1.50.zdb','/20140701_003003.01.003.000_1.50.zdb',67154,'',3,0,1404145803,1,0,0,'','3-1.50'), ('20140701_003003.02.003.000_2.40.zdb','/20140701_003003.02.003.000_2.40.zdb',86240,'',3,0,1404145803,2,0,0,'','3-2.40'), ('20140701_003003.03.003.000_3.29.zdb','/20140701_003003.03.003.000_3.29.zdb',86575,'',3,0,1404145803,3,0,0,'','3-3.29'), ('20140701_003003.04.003.000_4.30.zdb','/20140701_003003.04.003.000_4.30.zdb',82986,'',3,0,1404145803,4,0,0,'','3-4.30'), ('20140701_003003.05.003.000_5.30.zdb','/20140701_003003.05.003.000_5.30.zdb',69805,'',3,0,1404145803,5,0,0,'','3-5.30'), ('20140701_003003.06.003.000_6.19.zdb','/20140701_003003.06.003.000_6.19.zdb',64904,'',3,0,1404145803,6,0,0,'','3-6.19'), ('20140701_003003.07.003.000_7.50.zdb','/20140701_003003.07.003.000_7.50.zdb',59283,'',3,0,1404145803,7,0,0,'','3-7.50'), ('20140701_003003.08.003.000_8.69.zdb','/20140701_003003.08.003.000_8.69.zdb',52143,'',3,0,1404145803,8,0,0,'','3-8.69'), ('20140701_003003.09.003.000_10.00.zdb','/20140701_003003.09.003.000_10.00.zdb',48116,'',3,0,1404145803,9,0,0,'','3-10.00'), ('20140701_003003.10.003.000_12.00.zdb','/20140701_003003.10.003.000_12.00.zdb',41991,'',3,0,1404145803,10,0,0,'','3-12.00'), ('20140701_003003.11.003.000_14.00.zdb','/20140701_003003.11.003.000_14.00.zdb',33918,'',3,0,1404145803,11,0,0,'','3-14.00'), ('20140701_003003.12.003.000_16.70.zdb','/20140701_003003.12.003.000_16.70.zdb',33857,'',3,0,1404145803,12,0,0,'','3-16.70'), ('20140701_003003.13.003.000_19.50.zdb','/20140701_003003.13.003.000_19.50.zdb',27033,'',3,0,1404145803,13,0,0,'','3-19.50'), ('20140701_000218.00.004.000_0.50.zdb','/20140701_000218.00.004.000_0.50.zdb',36884,'',4,0,1404144138,0,0,0,'','4-0.50'), ('20140701_000218.01.004.000_1.50.zdb','/20140701_000218.01.004.000_1.50.zdb',80838,'',4,0,1404144138,1,0,0,'','4-1.50'), ('20140701_000218.02.004.000_2.40.zdb','/20140701_000218.02.004.000_2.40.zdb',115458,'',4,0,1404144138,2,0,0,'','4-2.40'), ('20140701_000218.03.004.000_3.29.zdb','/20140701_000218.03.004.000_3.29.zdb',107972,'',4,0,1404144138,3,0,0,'','4-3.29'), ('20140701_000218.04.004.000_4.30.zdb','/20140701_000218.04.004.000_4.30.zdb',101269,'',4,0,1404144138,4,0,0,'','4-4.30'), ('20140701_000218.05.004.000_5.30.zdb','/20140701_000218.05.004.000_5.30.zdb',87718,'',4,0,1404144138,5,0,0,'','4-5.30'), ('20140701_000218.06.004.000_6.19.zdb','/20140701_000218.06.004.000_6.19.zdb',70786,'',4,0,1404144138,6,0,0,'','4-6.19'), ('20140701_000218.07.004.000_7.50.zdb','/20140701_000218.07.004.000_7.50.zdb',61855,'',4,0,1404144138,7,0,0,'','4-7.50'), ('20140701_000218.08.004.000_8.69.zdb','/20140701_000218.08.004.000_8.69.zdb',59587,'',4,0,1404144138,8,0,0,'','4-8.69'), ('20140701_000218.09.004.000_10.00.zdb','/20140701_000218.09.004.000_10.00.zdb',52955,'',4,0,1404144138,9,0,0,'','4-10.00'), ('20140701_000218.10.004.000_12.00.zdb','/20140701_000218.10.004.000_12.00.zdb',46971,'',4,0,1404144138,10,0,0,'','4-12.00'), ('20140701_000218.11.004.000_14.00.zdb','/20140701_000218.11.004.000_14.00.zdb',37591,'',4,0,1404144138,11,0,0,'','4-14.00'), ('20140701_000218.12.004.000_16.70.zdb','/20140701_000218.12.004.000_16.70.zdb',32728,'',4,0,1404144138,12,0,0,'','4-16.70'), ('20140701_000218.13.004.000_19.50.zdb','/20140701_000218.13.004.000_19.50.zdb',27214,'',4,0,1404144138,13,0,0,'','4-19.50'), ('20140701_000908.00.004.000_0.50.zdb','/20140701_000908.00.004.000_0.50.zdb',34611,'',4,0,1404144548,0,0,0,'','4-0.50'), ('20140701_000908.01.004.000_1.50.zdb','/20140701_000908.01.004.000_1.50.zdb',72189,'',4,0,1404144548,1,0,0,'','4-1.50'), ('20140701_000908.02.004.000_2.40.zdb','/20140701_000908.02.004.000_2.40.zdb',112945,'',4,0,1404144548,2,0,0,'','4-2.40'), ('20140701_000908.03.004.000_3.29.zdb','/20140701_000908.03.004.000_3.29.zdb',114416,'',4,0,1404144548,3,0,0,'','4-3.29'), ('20140701_000908.04.004.000_4.30.zdb','/20140701_000908.04.004.000_4.30.zdb',99980,'',4,0,1404144548,4,0,0,'','4-4.30'), ('20140701_000908.05.004.000_5.30.zdb','/20140701_000908.05.004.000_5.30.zdb',85242,'',4,0,1404144548,5,0,0,'','4-5.30'), ('20140701_000908.06.004.000_6.19.zdb','/20140701_000908.06.004.000_6.19.zdb',69685,'',4,0,1404144548,6,0,0,'','4-6.19'), ('20140701_000908.07.004.000_7.50.zdb','/20140701_000908.07.004.000_7.50.zdb',59972,'',4,0,1404144548,7,0,0,'','4-7.50'), ('20140701_000908.08.004.000_8.69.zdb','/20140701_000908.08.004.000_8.69.zdb',50106,'',4,0,1404144548,8,0,0,'','4-8.69'), ('20140701_000908.09.004.000_10.00.zdb','/20140701_000908.09.004.000_10.00.zdb',46073,'',4,0,1404144548,9,0,0,'','4-10.00'), ('20140701_000908.10.004.000_12.00.zdb','/20140701_000908.10.004.000_12.00.zdb',43363,'',4,0,1404144548,10,0,0,'','4-12.00'), ('20140701_000908.11.004.000_14.00.zdb','/20140701_000908.11.004.000_14.00.zdb',29849,'',4,0,1404144548,11,0,0,'','4-14.00'), ('20140701_000908.12.004.000_16.70.zdb','/20140701_000908.12.004.000_16.70.zdb',27063,'',4,0,1404144548,12,0,0,'','4-16.70'), ('20140701_000908.13.004.000_19.50.zdb','/20140701_000908.13.004.000_19.50.zdb',26969,'',4,0,1404144548,13,0,0,'','4-19.50'), ('20140701_001556.00.004.000_0.50.zdb','/20140701_001556.00.004.000_0.50.zdb',34466,'',4,0,1404144956,0,0,0,'','4-0.50'), ('20140701_001556.01.004.000_1.50.zdb','/20140701_001556.01.004.000_1.50.zdb',71206,'',4,0,1404144956,1,0,0,'','4-1.50'), ('20140701_001556.02.004.000_2.40.zdb','/20140701_001556.02.004.000_2.40.zdb',118297,'',4,0,1404144956,2,0,0,'','4-2.40'), ('20140701_001556.03.004.000_3.29.zdb','/20140701_001556.03.004.000_3.29.zdb',117510,'',4,0,1404144956,3,0,0,'','4-3.29'), ('20140701_001556.04.004.000_4.30.zdb','/20140701_001556.04.004.000_4.30.zdb',102385,'',4,0,1404144956,4,0,0,'','4-4.30'), ('20140701_001556.05.004.000_5.30.zdb','/20140701_001556.05.004.000_5.30.zdb',90236,'',4,0,1404144956,5,0,0,'','4-5.30'), ('20140701_001556.06.004.000_6.19.zdb','/20140701_001556.06.004.000_6.19.zdb',63087,'',4,0,1404144956,6,0,0,'','4-6.19'), ('20140701_001556.07.004.000_7.50.zdb','/20140701_001556.07.004.000_7.50.zdb',58899,'',4,0,1404144956,7,0,0,'','4-7.50'), ('20140701_001556.08.004.000_8.69.zdb','/20140701_001556.08.004.000_8.69.zdb',46569,'',4,0,1404144956,8,0,0,'','4-8.69'), ('20140701_001556.09.004.000_10.00.zdb','/20140701_001556.09.004.000_10.00.zdb',51732,'',4,0,1404144956,9,0,0,'','4-10.00'), ('20140701_001556.10.004.000_12.00.zdb','/20140701_001556.10.004.000_12.00.zdb',35282,'',4,0,1404144956,10,0,0,'','4-12.00'), ('20140701_001556.11.004.000_14.00.zdb','/20140701_001556.11.004.000_14.00.zdb',35318,'',4,0,1404144956,11,0,0,'','4-14.00'), ('20140701_001556.12.004.000_16.70.zdb','/20140701_001556.12.004.000_16.70.zdb',29972,'',4,0,1404144956,12,0,0,'','4-16.70'), ('20140701_001556.13.004.000_19.50.zdb','/20140701_001556.13.004.000_19.50.zdb',30092,'',4,0,1404144956,13,0,0,'','4-19.50'), ('20140701_002311.00.004.000_0.50.zdb','/20140701_002311.00.004.000_0.50.zdb',33622,'',4,0,1404145391,0,0,0,'','4-0.50'), ('20140701_002311.01.004.000_1.50.zdb','/20140701_002311.01.004.000_1.50.zdb',71308,'',4,0,1404145391,1,0,0,'','4-1.50'), ('20140701_002311.02.004.000_2.40.zdb','/20140701_002311.02.004.000_2.40.zdb',101689,'',4,0,1404145391,2,0,0,'','4-2.40'), ('20140701_002311.03.004.000_3.29.zdb','/20140701_002311.03.004.000_3.29.zdb',114972,'',4,0,1404145391,3,0,0,'','4-3.29'), ('20140701_002311.04.004.000_4.30.zdb','/20140701_002311.04.004.000_4.30.zdb',95047,'',4,0,1404145391,4,0,0,'','4-4.30'), ('20140701_002311.05.004.000_5.30.zdb','/20140701_002311.05.004.000_5.30.zdb',82063,'',4,0,1404145391,5,0,0,'','4-5.30'), ('20140701_002311.06.004.000_6.19.zdb','/20140701_002311.06.004.000_6.19.zdb',67763,'',4,0,1404145391,6,0,0,'','4-6.19'), ('20140701_002311.07.004.000_7.50.zdb','/20140701_002311.07.004.000_7.50.zdb',51139,'',4,0,1404145391,7,0,0,'','4-7.50'), ('20140701_002311.08.004.000_8.69.zdb','/20140701_002311.08.004.000_8.69.zdb',46561,'',4,0,1404145391,8,0,0,'','4-8.69'), ('20140701_002311.09.004.000_10.00.zdb','/20140701_002311.09.004.000_10.00.zdb',48000,'',4,0,1404145391,9,0,0,'','4-10.00'), ('20140701_002311.10.004.000_12.00.zdb','/20140701_002311.10.004.000_12.00.zdb',40676,'',4,0,1404145391,10,0,0,'','4-12.00'), ('20140701_002311.11.004.000_14.00.zdb','/20140701_002311.11.004.000_14.00.zdb',34009,'',4,0,1404145391,11,0,0,'','4-14.00'), ('20140701_002311.12.004.000_16.70.zdb','/20140701_002311.12.004.000_16.70.zdb',31076,'',4,0,1404145391,12,0,0,'','4-16.70'), ('20140701_002311.13.004.000_19.50.zdb','/20140701_002311.13.004.000_19.50.zdb',29450,'',4,0,1404145391,13,0,0,'','4-19.50'), ('20140701_003003.00.004.000_0.50.zdb','/20140701_003003.00.004.000_0.50.zdb',32635,'',4,0,1404145803,0,0,0,'','4-0.50'), ('20140701_003003.01.004.000_1.50.zdb','/20140701_003003.01.004.000_1.50.zdb',69779,'',4,0,1404145803,1,0,0,'','4-1.50'), ('20140701_003003.02.004.000_2.40.zdb','/20140701_003003.02.004.000_2.40.zdb',104125,'',4,0,1404145803,2,0,0,'','4-2.40'), ('20140701_003003.03.004.000_3.29.zdb','/20140701_003003.03.004.000_3.29.zdb',104648,'',4,0,1404145803,3,0,0,'','4-3.29'), ('20140701_003003.04.004.000_4.30.zdb','/20140701_003003.04.004.000_4.30.zdb',89719,'',4,0,1404145803,4,0,0,'','4-4.30'), ('20140701_003003.05.004.000_5.30.zdb','/20140701_003003.05.004.000_5.30.zdb',72834,'',4,0,1404145803,5,0,0,'','4-5.30'), ('20140701_003003.06.004.000_6.19.zdb','/20140701_003003.06.004.000_6.19.zdb',61829,'',4,0,1404145803,6,0,0,'','4-6.19'), ('20140701_003003.07.004.000_7.50.zdb','/20140701_003003.07.004.000_7.50.zdb',53853,'',4,0,1404145803,7,0,0,'','4-7.50'), ('20140701_003003.08.004.000_8.69.zdb','/20140701_003003.08.004.000_8.69.zdb',46491,'',4,0,1404145803,8,0,0,'','4-8.69'), ('20140701_003003.09.004.000_10.00.zdb','/20140701_003003.09.004.000_10.00.zdb',44124,'',4,0,1404145803,9,0,0,'','4-10.00'), ('20140701_003003.10.004.000_12.00.zdb','/20140701_003003.10.004.000_12.00.zdb',38466,'',4,0,1404145803,10,0,0,'','4-12.00'), ('20140701_003003.11.004.000_14.00.zdb','/20140701_003003.11.004.000_14.00.zdb',31158,'',4,0,1404145803,11,0,0,'','4-14.00'), ('20140701_003003.12.004.000_16.70.zdb','/20140701_003003.12.004.000_16.70.zdb',30585,'',4,0,1404145803,12,0,0,'','4-16.70'), ('20140701_003003.13.004.000_19.50.zdb','/20140701_003003.13.004.000_19.50.zdb',25615,'',4,0,1404145803,13,0,0,'','4-19.50'), ('20140701_000218.00.005.000_0.50.zdb','/20140701_000218.00.005.000_0.50.zdb',28013,'',5,0,1404144138,0,0,0,'','5-0.50'), ('20140701_000218.01.005.000_1.50.zdb','/20140701_000218.01.005.000_1.50.zdb',50875,'',5,0,1404144138,1,0,0,'','5-1.50'), ('20140701_000218.02.005.000_2.40.zdb','/20140701_000218.02.005.000_2.40.zdb',60613,'',5,0,1404144138,2,0,0,'','5-2.40'), ('20140701_000218.03.005.000_3.29.zdb','/20140701_000218.03.005.000_3.29.zdb',52105,'',5,0,1404144138,3,0,0,'','5-3.29'), ('20140701_000218.04.005.000_4.30.zdb','/20140701_000218.04.005.000_4.30.zdb',52434,'',5,0,1404144138,4,0,0,'','5-4.30'), ('20140701_000218.05.005.000_5.30.zdb','/20140701_000218.05.005.000_5.30.zdb',45950,'',5,0,1404144138,5,0,0,'','5-5.30'), ('20140701_000218.06.005.000_6.19.zdb','/20140701_000218.06.005.000_6.19.zdb',44114,'',5,0,1404144138,6,0,0,'','5-6.19'), ('20140701_000218.07.005.000_7.50.zdb','/20140701_000218.07.005.000_7.50.zdb',41877,'',5,0,1404144138,7,0,0,'','5-7.50'), ('20140701_000218.08.005.000_8.69.zdb','/20140701_000218.08.005.000_8.69.zdb',40830,'',5,0,1404144138,8,0,0,'','5-8.69'), ('20140701_000218.09.005.000_10.00.zdb','/20140701_000218.09.005.000_10.00.zdb',35595,'',5,0,1404144138,9,0,0,'','5-10.00'), ('20140701_000218.10.005.000_12.00.zdb','/20140701_000218.10.005.000_12.00.zdb',32239,'',5,0,1404144138,10,0,0,'','5-12.00'), ('20140701_000218.11.005.000_14.00.zdb','/20140701_000218.11.005.000_14.00.zdb',29839,'',5,0,1404144138,11,0,0,'','5-14.00'), ('20140701_000218.12.005.000_16.70.zdb','/20140701_000218.12.005.000_16.70.zdb',26198,'',5,0,1404144138,12,0,0,'','5-16.70'), ('20140701_000218.13.005.000_19.50.zdb','/20140701_000218.13.005.000_19.50.zdb',21508,'',5,0,1404144138,13,0,0,'','5-19.50'), ('20140701_000908.00.005.000_0.50.zdb','/20140701_000908.00.005.000_0.50.zdb',26765,'',5,0,1404144548,0,0,0,'','5-0.50'), ('20140701_000908.01.005.000_1.50.zdb','/20140701_000908.01.005.000_1.50.zdb',45977,'',5,0,1404144548,1,0,0,'','5-1.50'), ('20140701_000908.02.005.000_2.40.zdb','/20140701_000908.02.005.000_2.40.zdb',58576,'',5,0,1404144548,2,0,0,'','5-2.40'), ('20140701_000908.03.005.000_3.29.zdb','/20140701_000908.03.005.000_3.29.zdb',54545,'',5,0,1404144548,3,0,0,'','5-3.29'), ('20140701_000908.04.005.000_4.30.zdb','/20140701_000908.04.005.000_4.30.zdb',51577,'',5,0,1404144548,4,0,0,'','5-4.30'), ('20140701_000908.05.005.000_5.30.zdb','/20140701_000908.05.005.000_5.30.zdb',45349,'',5,0,1404144548,5,0,0,'','5-5.30'), ('20140701_000908.06.005.000_6.19.zdb','/20140701_000908.06.005.000_6.19.zdb',43194,'',5,0,1404144548,6,0,0,'','5-6.19'), ('20140701_000908.07.005.000_7.50.zdb','/20140701_000908.07.005.000_7.50.zdb',41267,'',5,0,1404144548,7,0,0,'','5-7.50'), ('20140701_000908.08.005.000_8.69.zdb','/20140701_000908.08.005.000_8.69.zdb',34750,'',5,0,1404144548,8,0,0,'','5-8.69'), ('20140701_000908.09.005.000_10.00.zdb','/20140701_000908.09.005.000_10.00.zdb',32424,'',5,0,1404144548,9,0,0,'','5-10.00'), ('20140701_000908.10.005.000_12.00.zdb','/20140701_000908.10.005.000_12.00.zdb',30389,'',5,0,1404144548,10,0,0,'','5-12.00'), ('20140701_000908.11.005.000_14.00.zdb','/20140701_000908.11.005.000_14.00.zdb',23746,'',5,0,1404144548,11,0,0,'','5-14.00'), ('20140701_000908.12.005.000_16.70.zdb','/20140701_000908.12.005.000_16.70.zdb',21415,'',5,0,1404144548,12,0,0,'','5-16.70'), ('20140701_000908.13.005.000_19.50.zdb','/20140701_000908.13.005.000_19.50.zdb',21747,'',5,0,1404144548,13,0,0,'','5-19.50'), ('20140701_001556.00.005.000_0.50.zdb','/20140701_001556.00.005.000_0.50.zdb',26750,'',5,0,1404144956,0,0,0,'','5-0.50'), ('20140701_001556.01.005.000_1.50.zdb','/20140701_001556.01.005.000_1.50.zdb',45520,'',5,0,1404144956,1,0,0,'','5-1.50'), ('20140701_001556.02.005.000_2.40.zdb','/20140701_001556.02.005.000_2.40.zdb',60496,'',5,0,1404144956,2,0,0,'','5-2.40'), ('20140701_001556.03.005.000_3.29.zdb','/20140701_001556.03.005.000_3.29.zdb',55268,'',5,0,1404144956,3,0,0,'','5-3.29'), ('20140701_001556.04.005.000_4.30.zdb','/20140701_001556.04.005.000_4.30.zdb',53218,'',5,0,1404144956,4,0,0,'','5-4.30'), ('20140701_001556.05.005.000_5.30.zdb','/20140701_001556.05.005.000_5.30.zdb',47227,'',5,0,1404144956,5,0,0,'','5-5.30'), ('20140701_001556.06.005.000_6.19.zdb','/20140701_001556.06.005.000_6.19.zdb',39773,'',5,0,1404144956,6,0,0,'','5-6.19'), ('20140701_001556.07.005.000_7.50.zdb','/20140701_001556.07.005.000_7.50.zdb',40234,'',5,0,1404144956,7,0,0,'','5-7.50'), ('20140701_001556.08.005.000_8.69.zdb','/20140701_001556.08.005.000_8.69.zdb',32987,'',5,0,1404144956,8,0,0,'','5-8.69'), ('20140701_001556.09.005.000_10.00.zdb','/20140701_001556.09.005.000_10.00.zdb',35647,'',5,0,1404144956,9,0,0,'','5-10.00'), ('20140701_001556.10.005.000_12.00.zdb','/20140701_001556.10.005.000_12.00.zdb',25143,'',5,0,1404144956,10,0,0,'','5-12.00'), ('20140701_001556.11.005.000_14.00.zdb','/20140701_001556.11.005.000_14.00.zdb',28420,'',5,0,1404144956,11,0,0,'','5-14.00'), ('20140701_001556.12.005.000_16.70.zdb','/20140701_001556.12.005.000_16.70.zdb',23987,'',5,0,1404144956,12,0,0,'','5-16.70'), ('20140701_001556.13.005.000_19.50.zdb','/20140701_001556.13.005.000_19.50.zdb',23753,'',5,0,1404144956,13,0,0,'','5-19.50'), ('20140701_002311.00.005.000_0.50.zdb','/20140701_002311.00.005.000_0.50.zdb',26159,'',5,0,1404145391,0,0,0,'','5-0.50'), ('20140701_002311.01.005.000_1.50.zdb','/20140701_002311.01.005.000_1.50.zdb',45790,'',5,0,1404145391,1,0,0,'','5-1.50'), ('20140701_002311.02.005.000_2.40.zdb','/20140701_002311.02.005.000_2.40.zdb',52483,'',5,0,1404145391,2,0,0,'','5-2.40'), ('20140701_002311.03.005.000_3.29.zdb','/20140701_002311.03.005.000_3.29.zdb',53396,'',5,0,1404145391,3,0,0,'','5-3.29'), ('20140701_002311.04.005.000_4.30.zdb','/20140701_002311.04.005.000_4.30.zdb',48878,'',5,0,1404145391,4,0,0,'','5-4.30'), ('20140701_002311.05.005.000_5.30.zdb','/20140701_002311.05.005.000_5.30.zdb',43483,'',5,0,1404145391,5,0,0,'','5-5.30'), ('20140701_002311.06.005.000_6.19.zdb','/20140701_002311.06.005.000_6.19.zdb',41447,'',5,0,1404145391,6,0,0,'','5-6.19'), ('20140701_002311.07.005.000_7.50.zdb','/20140701_002311.07.005.000_7.50.zdb',34786,'',5,0,1404145391,7,0,0,'','5-7.50'), ('20140701_002311.08.005.000_8.69.zdb','/20140701_002311.08.005.000_8.69.zdb',32076,'',5,0,1404145391,8,0,0,'','5-8.69'), ('20140701_002311.09.005.000_10.00.zdb','/20140701_002311.09.005.000_10.00.zdb',33021,'',5,0,1404145391,9,0,0,'','5-10.00'), ('20140701_002311.10.005.000_12.00.zdb','/20140701_002311.10.005.000_12.00.zdb',28566,'',5,0,1404145391,10,0,0,'','5-12.00'),  ('20140701_002311.11.005.000_14.00.zdb','/20140701_002311.11.005.000_14.00.zdb',27125,'',5,0,1404145391,11,0,0,'','5-14.00'),  ('20140701_002311.12.005.000_16.70.zdb','/20140701_002311.12.005.000_16.70.zdb',24415,'',5,0,1404145391,12,0,0,'','5-16.70'),  ('20140701_002311.13.005.000_19.50.zdb','/20140701_002311.13.005.000_19.50.zdb',23242,'',5,0,1404145391,13,0,0,'','5-19.50'),  ('20140701_003003.00.005.000_0.50.zdb','/20140701_003003.00.005.000_0.50.zdb',25673,'',5,0,1404145803,0,0,0,'','5-0.50'),  ('20140701_003003.01.005.000_1.50.zdb','/20140701_003003.01.005.000_1.50.zdb',44235,'',5,0,1404145803,1,0,0,'','5-1.50'),  ('20140701_003003.02.005.000_2.40.zdb','/20140701_003003.02.005.000_2.40.zdb',53915,'',5,0,1404145803,2,0,0,'','5-2.40'),  ('20140701_003003.03.005.000_3.29.zdb','/20140701_003003.03.005.000_3.29.zdb',50026,'',5,0,1404145803,3,0,0,'','5-3.29'),  ('20140701_003003.04.005.000_4.30.zdb','/20140701_003003.04.005.000_4.30.zdb',47024,'',5,0,1404145803,4,0,0,'','5-4.30'),  ('20140701_003003.05.005.000_5.30.zdb','/20140701_003003.05.005.000_5.30.zdb',39047,'',5,0,1404145803,5,0,0,'','5-5.30'),  ('20140701_003003.06.005.000_6.19.zdb','/20140701_003003.06.005.000_6.19.zdb',39062,'',5,0,1404145803,6,0,0,'','5-6.19'),  ('20140701_003003.07.005.000_7.50.zdb','/20140701_003003.07.005.000_7.50.zdb',36218,'',5,0,1404145803,7,0,0,'','5-7.50'),  ('20140701_003003.08.005.000_8.69.zdb','/20140701_003003.08.005.000_8.69.zdb',32300,'',5,0,1404145803,8,0,0,'','5-8.69'),  ('20140701_003003.09.005.000_10.00.zdb','/20140701_003003.09.005.000_10.00.zdb',30830,'',5,0,1404145803,9,0,0,'','5-10.00'),  ('20140701_003003.10.005.000_12.00.zdb','/20140701_003003.10.005.000_12.00.zdb',27105,'',5,0,1404145803,10,0,0,'','5-12.00'),  ('20140701_003003.11.005.000_14.00.zdb','/20140701_003003.11.005.000_14.00.zdb',24885,'',5,0,1404145803,11,0,0,'','5-14.00'),  ('20140701_003003.12.005.000_16.70.zdb','/20140701_003003.12.005.000_16.70.zdb',24202,'',5,0,1404145803,12,0,0,'','5-16.70'),  ('20140701_003003.13.005.000_19.50.zdb','/20140701_003003.13.005.000_19.50.zdb',20493,'',5,0,1404145803,13,0,0,'','5-19.50')"];
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
