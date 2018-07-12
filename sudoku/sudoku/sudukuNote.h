//
//  sudukuNote.h
//  sudoku
//
//  Created by iOSDeveloper on 2018/7/10.
//  Copyright © 2018年 iOSDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NodeModel.h"

@interface sudukuNote : NSObject

/**
 数独模型
 */
@property (nonatomic, strong) NSArray<NSArray<NodeModel *> *> *suduModel;

//开始时间
@property (nonatomic, assign) NSTimeInterval beginTime;

//结束时间
@property (nonatomic, assign) NSTimeInterval finishTime;

//当前持续时间
@property (nonatomic, assign) double nowTimer;

/**
 历史操作记录  {time:[oldNodeModel, newNodeModel]}
 */
@property (nonatomic, strong) NSMutableDictionary *historicalData;

@end
