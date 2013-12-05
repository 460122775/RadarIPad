//
//  UserVo.h
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-21.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserVo : NSObject{
    NSString *username;
    NSString *password;
    int privilige;
}

@property(nonatomic, retain) NSString *username;
@property(nonatomic, retain) NSString *password;
@property(nonatomic, assign) int privilige;

@end
