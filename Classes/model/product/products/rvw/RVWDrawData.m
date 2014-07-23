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

-(void)getImageData:(UIImageView *) productImgView
{
    
}

-(void)getProductInfo:(UIView *)productInfoView
{
    UILabel *productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft, labelWidth, 20)];
    [productNameLabel setTextColor:ProductTextColor];
    [productNameLabel setText:@"产品名称：基本反射率(Z)"];
    [productInfoView addSubview:productNameLabel];
    
    UILabel *radarTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + 20 + VGap, labelWidth, 20)];
    [radarTypeLabel setTextColor:ProductTextColor];
    [radarTypeLabel setText:@"雷达型号：XDP9375"];
    [productInfoView addSubview:radarTypeLabel];
    
    UILabel *siteNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 2, labelWidth, 20)];
    [siteNameLabel setTextColor:ProductTextColor];
    [siteNameLabel setText:@"站点名称：双偏振天气雷达"];
    [productInfoView addSubview:siteNameLabel];
    
    UILabel *siteLongitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 3, labelWidth, 20)];
    [siteLongitudeLabel setTextColor:ProductTextColor];
    [siteLongitudeLabel setText:@"站点经度：E 85°34′28.01″"];
    [productInfoView addSubview:siteLongitudeLabel];
    
    UILabel *siteLatitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 4, labelWidth, 20)];
    [siteLatitudeLabel setTextColor:ProductTextColor];
    [siteLatitudeLabel setText:@"站点纬度：N 44°49′14.00″"];
    [productInfoView addSubview:siteLatitudeLabel];
    
    UILabel *heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 5, labelWidth, 20)];
    [heightLabel setTextColor:ProductTextColor];
    [heightLabel setText:@"天线海拔：312 m"];
    [productInfoView addSubview:heightLabel];
    
    UILabel *maxDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 6, labelWidth, 20)];
    [maxDistanceLabel setTextColor:ProductTextColor];
    [maxDistanceLabel setText:@"最大测距：100 km"];
    [productInfoView addSubview:maxDistanceLabel];
    
    UILabel *distancePixLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 7, labelWidth, 20)];
    [distancePixLabel setTextColor:ProductTextColor];
    [distancePixLabel setText:@"距离分辨率：150 m"];
    [productInfoView addSubview:distancePixLabel];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 8, labelWidth, 20)];
    [dateLabel setTextColor:ProductTextColor];
    [dateLabel setText:@"日       期：2014 / 07 / 23"];
    [productInfoView addSubview:dateLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 9, labelWidth, 20)];
    [timeLabel setTextColor:ProductTextColor];
    [timeLabel setText:@"时       间：15:33:46"];
    [productInfoView addSubview:timeLabel];
    
    UILabel *eleLabel = [[UILabel alloc] initWithFrame:CGRectMake(productPaddingTop, productPaddingLeft + (20 + VGap) * 10, labelWidth, 20)];
    [eleLabel setTextColor:ProductTextColor];
    [eleLabel setText:@"仰       角：5.3°"];
    [productInfoView addSubview:eleLabel];
}



@end
