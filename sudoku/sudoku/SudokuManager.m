//
//  SudokuModel.m
//  sudoku
//
//  Created by iOSDeveloper on 2018/7/10.
//  Copyright © 2018年 iOSDeveloper. All rights reserved.
//

#import "SudokuManager.h"

@implementation SudokuManager

+ (NSArray<NSArray<NSNumber *> *> *)initSudoku {
    //生成完整数独
    NSMutableArray<NSMutableArray<NSNumber *> *> *sudokuArray;
    sudokuArray = [NSMutableArray arrayWithArray:@[
                                                   [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9]],
                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]],
                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]],
                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]],
                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]],
                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]],
                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]],
                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]],
                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]]
                                                   ]];
    
    //首行打乱顺序
    for (int y = 0; y < 9; y++) {
        NSUInteger randomNumber = arc4random()%9;
        
        NSNumber *tempNumber = sudokuArray[0][y];
        [sudokuArray[0] replaceObjectAtIndex:y withObject:sudokuArray[0][randomNumber]];
        [sudokuArray[0] replaceObjectAtIndex:randomNumber withObject:tempNumber];
    }
    
    
  
    return sudokuArray;
}

+ (void)createNumber:(NSMutableArray<NSMutableArray<NSNumber *> *> *)suduku x:(NSUInteger)x y:(NSUInteger)y {//对某位置生成一个数字
    
}

+ (NSArray<NSNumber *> *)optionalNumbers:(NSMutableArray<NSMutableArray<NSNumber *> *> *)suduku  x:(NSUInteger)x y:(NSUInteger)y {
    __block NSMutableArray<NSNumber *> *resultArray = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9]];
    
    [suduku enumerateObjectsUsingBlock:^(NSMutableArray<NSNumber *> * _Nonnull objA, NSUInteger idx, BOOL * _Nonnull stop) {
        [objA enumerateObjectsUsingBlock:^(NSNumber * _Nonnull objN, NSUInteger idy, BOOL * _Nonnull stop) {
            if (idx == x) {//同行
                [resultArray removeObject:objN];
            } else if (idy == y) {//同列
                [resultArray removeObject:objN];
            } else if ((x/3 == idx/3) && (y/3 == idy/3)) {//同区域
                [resultArray removeObject:objN];
            }
        }];
    }];
    
    return resultArray;
}

//规则一：横行1-9
+ (BOOL)passRuleOne:(NSArray<NSArray<NSNumber *> *> *)suduku x:(NSUInteger)x y:(NSUInteger)y {
    NSNumber *number = suduku[x][y];
    
    NSArray<NSNumber *> *HorizontalArray = suduku[x];
    
    __block BOOL isPass = YES;
    
    [HorizontalArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([number isEqualToNumber:obj]) {//出现相同
            isPass = NO;
            *stop = YES;
        }
    }];
    
    return isPass;
}

//规则二：竖行1-9
+ (BOOL)passRuleTwo:(NSArray<NSArray<NSNumber *> *> *)suduku x:(NSUInteger)x y:(NSUInteger)y {
    NSNumber *number = suduku[x][y];
    
    __block NSMutableArray<NSNumber *> *VerticalArray = [NSMutableArray array];
    [suduku enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [VerticalArray addObject:obj[y]];
    }];
    
    __block BOOL isPass = YES;
    
    [VerticalArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([number isEqualToNumber:obj]) {//出现相同
            isPass = NO;
            *stop = YES;
        }
    }];
    
    return isPass;
}

//规则三：小九宫1-9
+ (BOOL)passRuleThree:(NSArray<NSArray<NSNumber *> *> *)suduku x:(NSUInteger)x y:(NSUInteger)y {
    NSNumber *number = suduku[x][y];
    
    __block NSMutableArray<NSNumber *> *AreaArray = [NSMutableArray array];
    [suduku enumerateObjectsUsingBlock:^(NSArray<NSNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (x/3 == idx/3) {
            [obj enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (y/3 == idx/3) {
                    [AreaArray addObject:obj];
                }
            }];
        }
    }];
    
    __block BOOL isPass = YES;
    
    [AreaArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([number isEqualToNumber:obj]) {//出现相同
            isPass = NO;
            *stop = YES;
        }
    }];
    
    return isPass;
}

@end
