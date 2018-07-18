//
//  NodeModel.h
//  sudoku
//
//  Created by iOSDeveloper on 2018/7/10.
//  Copyright © 2018年 iOSDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NodeModel : NSObject

/**
 最终结果
 */
@property (nonatomic, strong) NSNumber *finalNumber;

/**
 当前填写的值
 */
@property (nonatomic, strong) NSNumber *currentNumber;

/**
 索引0-80
 */
@property (nonatomic, assign) NSUInteger index;

/**
 可选数字数组
 */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *optionNumberArray;

/**
 当前填入的可选数字数组
 */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *currentOptionNumberArray;

@end
