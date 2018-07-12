//
//  SudokuModel.h
//  sudoku
//
//  Created by iOSDeveloper on 2018/7/10.
//  Copyright © 2018年 iOSDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SudokuManager : NSObject

/**
 初始化完整数独表

 @return 完整数独表
 */
+ (NSArray<NSArray<NSNumber *> *> *)initSudoku;

/**
 当前位置可填写的数字数组

 @param suduku 当前数独表
 @param x 横坐标
 @param y 纵坐标
 @return 当前位置可填写的数字数组
 */
+ (NSArray<NSNumber *> *)optionalNumbers:(NSMutableArray<NSMutableArray<NSNumber *> *> *)suduku  x:(NSUInteger)x y:(NSUInteger)y;

/**
 验证规则一横行不重复

 @param suduku 当前数独表
 @param x 横坐标
 @param y 纵坐标
 @return 重复为NO，不重复为YES
 */
+ (BOOL)passRuleOne:(NSArray<NSArray<NSNumber *> *> *)suduku x:(NSUInteger)x y:(NSUInteger)y;

/**
 验证规则二竖行不重复

 @param suduku 当前数独表
 @param x 横坐标
 @param y 纵坐标
 @return 重复为NO，不重复为YES
 */
+ (BOOL)passRuleTwo:(NSArray<NSArray<NSNumber *> *> *)suduku x:(NSUInteger)x y:(NSUInteger)y;

/**
 验证规则三小九宫格不重复

 @param suduku 当前数独表
 @param x 横坐标
 @param y 纵坐标
 @return 重复为NO，不重复为YES
 */
+ (BOOL)passRuleThree:(NSArray<NSArray<NSNumber *> *> *)suduku x:(NSUInteger)x y:(NSUInteger)y;

@end
