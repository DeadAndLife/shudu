//
//  AppDelegate.h
//  sudoku
//
//  Created by iOSDeveloper on 2018/7/6.
//  Copyright © 2018年 iOSDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

