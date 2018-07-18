//
//  SUUser.m
//  sudoku
//
//  Created by iOSDeveloper on 2018/7/10.
//  Copyright © 2018年 iOSDeveloper. All rights reserved.
//

#import "SUUser.h"

@implementation SUUser

+ (instancetype)defaultUser {
    SUUser *anonymousUser = [SUUser getCurrentUser];
    [anonymousUser save];
    
    return anonymousUser;
}

@end
