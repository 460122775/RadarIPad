//
//  RVWDrawData.m
//  RadarIPad
//
//  Created by Yachen Dai on 12/6/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import "RVWDrawData.h"

@implementation RVWDrawData

-(id)init
{
    return [super init];
}

-(void)getImageData:(UIImageView *) productImgView andData:(NSData *) data
{
    DLog(@">>>>>>>>Start Draw Product.[%i]", data.length);
    
    
}

-(void)getProductInfo:(UIView *)productInfoView andData:(NSData *) data
{
    [data getBytes:&fileHeadStruct range:NSMakeRange(0, sizeof(fileHeadStruct))];
    
    UILabel *productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft, labelWidth, 20)];
    [productNameLabel setTextColor:ProductTextColor];
    [productNameLabel setText:@"产品名称：基本反射率(Z)"];
    [productInfoView addSubview:productNameLabel];
    
    UILabel *radarTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + 20 + VGap, labelWidth, 20)];
    [radarTypeLabel setTextColor:ProductTextColor];
    [radarTypeLabel setText:[NSString stringWithFormat:@"雷达型号：%s", fileHeadStruct.addSec.RadarType]];
    [productInfoView addSubview:radarTypeLabel];
    
    UILabel *siteNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 2, labelWidth, 20)];
    [siteNameLabel setTextColor:ProductTextColor];
    [siteNameLabel setText:[NSString stringWithFormat:@"站点名称：%s", fileHeadStruct.addSec.Station]];
    [productInfoView addSubview:siteNameLabel];
    
    UILabel *siteLongitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 3, labelWidth, 20)];
    [siteLongitudeLabel setTextColor:ProductTextColor];
    [siteLongitudeLabel setText:[NSString stringWithFormat:@"站点经度：E %li°%li′%li″",
                                 fileHeadStruct.addSec.LongitudeV/360000,
                                 (fileHeadStruct.addSec.LongitudeV / 100) % 3600 / 60,
                                 (fileHeadStruct.addSec.LongitudeV / 100) % 60]];
    [productInfoView addSubview:siteLongitudeLabel];
    
    UILabel *siteLatitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 4, labelWidth, 20)];
    [siteLatitudeLabel setTextColor:ProductTextColor];
    [siteLatitudeLabel setText:[NSString stringWithFormat:@"站点纬度：N %li°%li′%li″",
                                fileHeadStruct.addSec.LatitudeV/360000,
                                (fileHeadStruct.addSec.LatitudeV / 100) % 3600 / 60,
                                (fileHeadStruct.addSec.LatitudeV / 100) % 60]];
    [productInfoView addSubview:siteLatitudeLabel];
    
    UILabel *heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 5, labelWidth, 20)];
    [heightLabel setTextColor:ProductTextColor];
    [heightLabel setText:[NSString stringWithFormat:@"天线海拔：%.f m", fileHeadStruct.addSec.Height/1000.0f]];
    [productInfoView addSubview:heightLabel];
    
    UILabel *maxDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 6, labelWidth, 20)];
    [maxDistanceLabel setTextColor:ProductTextColor];
    [maxDistanceLabel setText:[NSString stringWithFormat:@"最大测距：%i km", fileHeadStruct.obserSec.iRefBinLen[0] * fileHeadStruct.obserSec.usRefBinNumber[0]/1000]];
    [productInfoView addSubview:maxDistanceLabel];
    
    UILabel *distancePixLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 7, labelWidth, 20)];
    [distancePixLabel setTextColor:ProductTextColor];
    [distancePixLabel setText:[NSString stringWithFormat:@"距离分辨率：%i m", fileHeadStruct.obserSec.iRefBinLen[0]]];
    [productInfoView addSubview:distancePixLabel];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 8, labelWidth, 20)];
    [dateLabel setTextColor:ProductTextColor];
    [dateLabel setText:[NSString stringWithFormat:@"日       期：%04i/%02i/%02i",
                        fileHeadStruct.obserSec.iObsStartTimeYear,
                        fileHeadStruct.obserSec.iObsStartTimeMonth,
                        fileHeadStruct.obserSec.iObsStartTimeDay]];
    [productInfoView addSubview:dateLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 9, labelWidth, 20)];
    [timeLabel setTextColor:ProductTextColor];
    [timeLabel setText:[NSString stringWithFormat:@"时       间：%02i:%02i:%02i",
                        fileHeadStruct.obserSec.iObsStartTimeHour,
                        fileHeadStruct.obserSec.iObsStartTimeMinute,
                        fileHeadStruct.obserSec.iObsStartTimeSecond]];
    [productInfoView addSubview:timeLabel];
    
    UILabel *eleLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 10, labelWidth, 20)];
    [eleLabel setTextColor:ProductTextColor];
    [eleLabel setText:[NSString stringWithFormat:@"仰       角：%.2f",fileHeadStruct.obserSec.iElevation[0] / 100.f]];
    [productInfoView addSubview:eleLabel];
}



@end
