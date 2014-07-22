//
//  ColorModel.m
//  RadarIPad
//
//  Created by Yachen Dai on 12/9/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import "ColorModel.h"
#import "FMResultSet.h"
#import "FMDatabase.h"

@implementation ColorModel

static FMDatabaseQueue *queue;
static NSMutableDictionary* colorDataDic;

+ (void)initModel
{
    if(colorDataDic == nil) colorDataDic = [[NSMutableDictionary alloc] init];
}

#pragma -mark DB Control
+(void)selectControl:(int) colorType
{
    [ColorModel initModel];
    if ([colorDataDic objectForKey:[NSString stringWithFormat:@"%i",colorType]]) return;
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:DBPath];
    if (queue)
    {
        [queue inDatabase:^(FMDatabase *db) {
            FMResultSet *rs = [db executeQuery:
                               [NSString stringWithFormat:@"select * from t_color where colorType=%i",colorType]];
            if([rs next])
            {
                [colorDataDic setValue:[[rs stringForColumn:@"colorData"] componentsSeparatedByString:@","]
                            forKey:[NSString stringWithFormat:@"%i",[rs intForColumn:@"colorType"]]];
            }
            [rs close];
        }];
        [queue close];
    }
}

+(void) insertControl:(NSString*) colorStr
{
    
}

+(void) deleteControl
{
    
}

#pragma -mark Draw Control
+ (void)drawColor:(int)colorType andColorImgView:(UIImageView *) colorImgView;
{
    [ColorModel selectControl:colorType];
    NSArray *colorArray = [colorDataDic objectForKey:[NSString stringWithFormat:@"%i",colorType]];
    if (!colorArray)
    {
        DLog(@">>>>>ERROR: No Color Data");
        return;
    }
    
    int paddingTop = 10;
    int paddingLeft = 20;
    int width = (int)(colorImgView.frame.size.width - paddingLeft * 2) / [(NSString*)colorArray[0] integerValue];
    int height = (int)(colorImgView.frame.size.height - paddingTop * 2 - 20);
    
    
    UIGraphicsBeginImageContext(colorImgView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);
    CGContextBeginPath(context);
    // Draw first number...
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0f], NSFontAttributeName, nil];
    [(NSString*)colorArray[2] drawAtPoint:
     CGPointMake(paddingLeft / 1.5, paddingTop + height + 7) withAttributes:dic];
    // Draw middle
    for (int i = 0; i < [(NSString*)colorArray[0] integerValue]; i++)
    {
        // Draw block...
        CGContextSetRGBFillColor(context,
                                   [(NSString*)colorArray[3 + i * 5] integerValue]/256.0,
                                   [(NSString*)colorArray[4 + i * 5] integerValue]/256.0,
                                   [(NSString*)colorArray[5 + i * 5] integerValue]/256.0, 1.0);
        CGContextFillRect(context,
                          CGRectMake(paddingLeft + i * width, paddingTop, width, height));
        // Draw line...
        CGContextMoveToPoint(context, paddingLeft + i * width + 1, paddingTop + height);
        CGContextAddLineToPoint(context, paddingLeft + i * width + 1, paddingTop + height + 5);
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 0.5);
        CGContextStrokePath(context);
        // Draw font...
        [(NSString*)colorArray[7 + i * 5] drawAtPoint:
         CGPointMake((i + 1) * width + paddingLeft / 1.5, paddingTop + height + 7) withAttributes:dic];
    }
    // Draw line...
    CGContextMoveToPoint(context,
                         paddingLeft + [(NSString*)colorArray[0] integerValue] * width - 1, paddingTop + height);
    CGContextAddLineToPoint(context,
                            paddingLeft + [(NSString*)colorArray[0] integerValue] * width - 1, paddingTop + height + 5);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 0.5);
    CGContextStrokePath(context);
    // Draw Unit...
    [(NSString*)colorArray[1] drawAtPoint:
     CGPointMake(([(NSString*)colorArray[0] integerValue] + 1) * width - paddingLeft / 1.8, paddingTop + height - 12) withAttributes:dic];
    // Show image...
    colorImgView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
