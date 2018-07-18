//
//  SudokuModel.h
//  sudoku
//
//  Created by iOSDeveloper on 2018/7/10.
//  Copyright © 2018年 iOSDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NodeModel.h"

@interface SudokuManager : NSObject

/**
 生成简单数独表

 @return 简单的数独表
 */
+ (NSArray<NodeModel *> *)initSimpleSudoku;

/**
 生成中等难度数独表

 @return 中等难度数独表
 */
+ (NSArray<NodeModel *> *)initMiddleSudoku;

/**
 生成困难难度数独表

 @return 困难难度数独表
 */
+ (NSArray<NodeModel *> *)initHardSudoku;

/**
 当前位置可填写的数字数组

 @param suduku 当前数独表
 @param index 索引
 @return 当前位置可填写的数字数组
 */
//+ (NSMutableArray<NSNumber *> *)optionalNumbers:(NSArray<NodeModel *> *)suduku index:(NSUInteger)index;

/**
 移除某位置填写的值在其他位置的可选择性

 @param suduku 当前数独表
 @param index 填写数字的索引
 */
+ (void)removeOptionNumber:(NSArray<NodeModel *> *)suduku index:(NSUInteger)index;

/**
 验证规则一横行不重复

 @param suduku 当前数独表
 @param index 索引
 @return 重复为NO，不重复为YES
 */
+ (BOOL)passRuleOne:(NSArray<NodeModel *> *)suduku index:(NSUInteger)index;

/**
 验证规则二竖行不重复

 @param suduku 当前数独表
 @param index 索引
 @return 重复为NO，不重复为YES
 */
+ (BOOL)passRuleTwo:(NSArray<NodeModel *> *)suduku index:(NSUInteger)index;

/**
 验证规则三小九宫格不重复

 @param suduku 当前数独表
 @param index 索引
 @return 重复为NO，不重复为YES
 */
+ (BOOL)passRuleThree:(NSArray<NodeModel *> *)suduku index:(NSUInteger)index;

@end
