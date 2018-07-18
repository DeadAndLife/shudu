//
//  SudokuModel.m
//  sudoku
//
//  Created by iOSDeveloper on 2018/7/10.
//  Copyright © 2018年 iOSDeveloper. All rights reserved.
//

#import "SudokuManager.h"

/**
 *自定义格式输出
 */
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

@implementation SudokuManager

+ (NSArray<NodeModel *> *)initSimpleSudoku {
    NSMutableArray<NodeModel *> *sudokuArray = [NSMutableArray array];
    
    //初始化空数独
    for (int i = 0; i<81; i++) {
        NodeModel *initModel = [[NodeModel alloc] init];
        initModel.index = i;
        initModel.finalNumber = @0;
        initModel.currentNumber = @0;
        initModel.optionNumberArray = [NSMutableArray array];
        initModel.currentOptionNumberArray = [NSMutableArray array];
        
        [sudokuArray addObject:initModel];
    }
    
    //初始化中心9个方格索引为
    NSMutableArray *initCenterArray = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9]];
    for (int i = 0; i<9; i++) {
        NSUInteger randomNumber = arc4random()%initCenterArray.count;
        
        NSUInteger index = 30+(i/3)*6+i;
        
        NodeModel *initModel = sudokuArray[index];
        initModel.finalNumber = initCenterArray[randomNumber];
        initModel.currentNumber = initCenterArray[randomNumber];
        
        [initCenterArray removeObjectAtIndex:randomNumber];
    }
    
    //行列变换生成上、下九宫格和左右九宫格,在生成其他位置九宫格
    //randomPortraitUpDown 0表示左边向上平移一行， 1表示左边向下平移一行
    NSUInteger randomPortraitUpDown = arc4random()%2;
    //randomLandscapeLeftRight 0表示上边向左平移一行， 1表示上边向右平移一行
    NSUInteger randomLandscapeLeftRight = arc4random()%2;
    for (int i = 0; i<9; i++) {
        NSUInteger orignIndex = 30+(i/3)*6+i;
        NodeModel *orignModel = sudokuArray[orignIndex];
        
        NSUInteger upIndex = 3+(i/3)*6+i;
        NSUInteger downIndex = 57+(i/3)*6+i;
        NSUInteger leftIndex = 27+(i/3)*6+i;
        NSUInteger rightIndex = 33+(i/3)*6+i;
        NSUInteger leftUpIndex = 0+(i/3)*6+i;
        NSUInteger leftDownIndex = 54+(i/3)*6+i;
        NSUInteger rightUpIndex = 6+(i/3)*6+i;
        NSUInteger rightDownIndex = 60+(i/3)*6+i;
        
        if (randomLandscapeLeftRight == 0) {//上边向左平移一行
            if ((i%3-1) < 0) {//up出框+2
                upIndex += 2;
                leftUpIndex += 2;
                rightUpIndex += 2;
            } else {//up不出框-1
                upIndex -= 1;
                leftUpIndex -= 1;
                rightUpIndex -= 1;
            }
            if ((i%3+1) > 2) {//down出框-2
                downIndex -= 2;
                leftDownIndex -= 2;
                rightDownIndex -= 2;
            } else {//down不出框+1
                downIndex += 1;
                leftDownIndex += 1;
                rightDownIndex += 1;
            }
        } else {//上边向右平移一行
            if ((i%3+1) > 2) {//up出框-2
                upIndex -= 2;
                leftUpIndex -= 2;
                rightUpIndex -= 2;
            } else {//up不出框+1
                upIndex += 1;
                leftUpIndex += 1;
                rightUpIndex += 1;
            }
            if ((i%3-1) < 0) {//down出框+2
                downIndex += 2;
                leftDownIndex += 2;
                rightDownIndex += 2;
            } else {//down不出框-1
                downIndex -= 1;
                leftDownIndex -= 1;
                rightDownIndex -= 1;
            }
        }
        if (randomPortraitUpDown == 0) {//左边向上平移一行
            if ((i-3) < 0) {//left出框+18
                leftIndex += 18;
                leftUpIndex += 18;
                leftDownIndex += 18;
            } else {//left不出框-9
                leftIndex -= 9;
                leftUpIndex -= 9;
                leftDownIndex -= 9;
            }
            if ((i+3) > 8) {//right出框-18
                rightIndex -= 18;
                rightUpIndex -= 18;
                rightDownIndex -= 18;
            } else {//right不出框+9
                rightIndex += 9;
                rightUpIndex += 9;
                rightDownIndex += 9;
            }
        } else {//左边向下平移一行
            if ((i+3) > 8) {//left出框-18
                leftIndex -= 18;
                leftUpIndex -= 18;
                leftDownIndex -= 18;
            } else {//left不出框+9
                leftIndex += 9;
                leftUpIndex += 9;
                leftDownIndex += 9;
            }
            if ((i-3) < 0) {//right出框+18
                rightIndex += 18;
                rightUpIndex += 18;
                rightDownIndex += 18;
            } else {//right不出框-9
                rightIndex -= 9;
                rightUpIndex -= 9;
                rightDownIndex -= 9;
            }
        }
        
        NodeModel *upModel = sudokuArray[upIndex];
        NodeModel *downModel = sudokuArray[downIndex];
        NodeModel *leftModel = sudokuArray[leftIndex];
        NodeModel *rightModel = sudokuArray[rightIndex];
        NodeModel *leftUpModel = sudokuArray[leftUpIndex];
        NodeModel *leftDownModel = sudokuArray[leftDownIndex];
        NodeModel *rightUpModel = sudokuArray[rightUpIndex];
        NodeModel *rightDownModel = sudokuArray[rightDownIndex];
        
        upModel.finalNumber = orignModel.finalNumber;
        upModel.currentNumber = orignModel.currentNumber;
        downModel.finalNumber = orignModel.finalNumber;
        downModel.currentNumber = orignModel.currentNumber;
        leftModel.finalNumber = orignModel.finalNumber;
        leftModel.currentNumber = orignModel.currentNumber;
        rightModel.finalNumber = orignModel.finalNumber;
        rightModel.currentNumber = orignModel.currentNumber;
        leftUpModel.finalNumber = orignModel.finalNumber;
        leftUpModel.currentNumber = orignModel.currentNumber;
        leftDownModel.finalNumber = orignModel.finalNumber;
        leftDownModel.currentNumber = orignModel.currentNumber;
        rightUpModel.finalNumber = orignModel.finalNumber;
        rightUpModel.currentNumber = orignModel.currentNumber;
        rightDownModel.finalNumber = orignModel.finalNumber;
        rightDownModel.currentNumber = orignModel.currentNumber;
    }
    
    return sudokuArray;
}

+ (NSArray<NodeModel *> *)initMiddleSudoku {
    NSMutableArray<NodeModel *> *sudokuArray = [NSMutableArray array];
    
    //初始化空数独
    for (int i = 0; i<81; i++) {
        NodeModel *initModel = [[NodeModel alloc] init];
        initModel.index = i;
        initModel.finalNumber = @0;
        initModel.currentNumber = @0;
        initModel.optionNumberArray = [NSMutableArray arrayWithObjects:@1, @2, @3, @4, @5, @6, @7, @8, @9, nil];
        initModel.currentOptionNumberArray = [NSMutableArray arrayWithObjects:@1, @2, @3, @4, @5, @6, @7, @8, @9, nil];
        
        [sudokuArray addObject:initModel];
    }
    
    //初始化中心、左上、又下3个九宫格
    NSMutableArray *initCenterArray = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9]];
    NSMutableArray *initLeftUpArray = [initCenterArray mutableCopy];
    NSMutableArray *initRightDownArray = [initCenterArray mutableCopy];
    for (int i = 0; i<9; i++) {
        NSUInteger randomCenter = arc4random()%initCenterArray.count;
        NSUInteger randomLeftUp = arc4random()%initLeftUpArray.count;
        NSUInteger randomRightDown = arc4random()%initRightDownArray.count;
        
        NSUInteger centerIndex = 30+(i/3)*6+i;
        NSUInteger leftUpIndex = 0+(i/3)*6+i;
        NSUInteger rightUpIndex = 60+(i/3)*6+i;
        
        NodeModel *centerModel = sudokuArray[centerIndex];
        NodeModel *leftUpModel = sudokuArray[leftUpIndex];
        NodeModel *rightUpModel = sudokuArray[rightUpIndex];
        
        centerModel.finalNumber = initCenterArray[randomCenter];
        centerModel.currentNumber = initCenterArray[randomCenter];
        [centerModel.optionNumberArray removeAllObjects];
        leftUpModel.finalNumber = initLeftUpArray[randomLeftUp];
        leftUpModel.currentNumber = initLeftUpArray[randomLeftUp];
        [leftUpModel.optionNumberArray removeAllObjects];
        rightUpModel.finalNumber = initRightDownArray[randomRightDown];
        rightUpModel.currentNumber = initRightDownArray[randomRightDown];
        [rightUpModel.optionNumberArray removeAllObjects];
        
        [initCenterArray removeObjectAtIndex:randomCenter];
        [initLeftUpArray removeObjectAtIndex:randomLeftUp];
        [initRightDownArray removeObjectAtIndex:randomRightDown];
        
        [self removeOptionNumber:sudokuArray index:centerIndex];
        [self removeOptionNumber:sudokuArray index:leftUpIndex];
        [self removeOptionNumber:sudokuArray index:rightUpIndex];
    }
    
    //按顺序随机其他位置，不合适者，回退一步
    [self randomSudoku:sudokuArray index:3 isBack:NO];
    
    //log一下
    for (int i = 0; i<81; i++) {
        NodeModel *initModel = sudokuArray[i];
        
        NSLog(@"%d\t%@\t%@", i, initModel.finalNumber, initModel.currentNumber);
    }
    
    return sudokuArray;
}

+ (NSArray<NodeModel *> *)initHardSudoku {
    NSMutableArray<NodeModel *> *sudokuArray = [NSMutableArray array];
    
    //初始化空数独
    for (int i = 0; i<81; i++) {
        NodeModel *initModel = [[NodeModel alloc] init];
        initModel.index = i;
        initModel.finalNumber = @0;
        initModel.currentNumber = @0;
        
        [sudokuArray addObject:initModel];
    }
    
    //初始化首行9个方格
    NSMutableArray *initArray = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9]];
    for (int i = 0; i<9; i++) {
        NSUInteger randomNumber = arc4random()%initArray.count;
        
        NodeModel *initModel = sudokuArray[i];
        initModel.finalNumber = initArray[randomNumber];
        initModel.currentNumber = initArray[randomNumber];
        
        [initArray removeObjectAtIndex:randomNumber];
    }
    
    //按顺序随机其他位置，不合适者，回退一步
    [self randomSudoku:sudokuArray index:9 isBack:NO];
    
    //log一下
    for (int i = 0; i<81; i++) {
        NodeModel *initModel = sudokuArray[i];
        
        NSLog(@"%d\t%@\t%@", i, initModel.finalNumber, initModel.currentNumber);
    }
    
    return sudokuArray;
}

//递归调用随机填数函数
+ (void)randomSudoku:(NSMutableArray<NodeModel *> *)sudoku index:(NSUInteger)index isBack:(BOOL)isBack {
    if (index > 80) return;
    
    NodeModel *orignModel = sudoku[index];
    
    if (isBack) {//表示回退的
        //先增加可选值
        [self addOptionNumber:sudoku index:index];
        if (![orignModel.finalNumber isEqualToNumber:@0]) {//表示本来就有,继续回退
            [self randomSudoku:sudoku index:(index-1) isBack:YES];
            return;
        } else {
            
        }
    }
    
    if (![orignModel.finalNumber isEqualToNumber:@0]) {//表示当前填入过数字
        if (orignModel.currentOptionNumberArray.count == 0) {//
            
        } else {//表示回退回来的
            [orignModel.currentOptionNumberArray removeObject:orignModel.finalNumber];
        }
    }
    
    //判断是否为无数可填，如无数可填，则回退一步
    if (orignModel.currentOptionNumberArray.count == 0) {
        [self randomSudoku:sudoku index:(index-1) isBack:YES];
        return;
    }
    //随机数字填写
    NSUInteger randomIndex = arc4random()%orignModel.currentOptionNumberArray.count;
    orignModel.currentNumber = orignModel.currentOptionNumberArray[randomIndex];
    [orignModel.currentOptionNumberArray removeObject:orignModel.currentNumber];
    
    [self randomSudoku:sudoku index:(index+1) isBack:NO];
}







//+ (NSArray<NSArray<NSNumber *> *> *)initSudoku {
//    //生成完整数独
//    NSMutableArray<NSMutableArray<NSNumber *> *> *sudokuArray;
//    sudokuArray = [NSMutableArray arrayWithArray:@[
//                                                   [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9]],
//                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]],
//                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]],
//                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]],
//                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]],
//                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]],
//                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]],
//                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]],
//                                                   [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0, @0, @0, @0]]
//                                                   ]];
//
//    //首行打乱顺序
//    for (int y = 0; y < 9; y++) {
//        NSUInteger randomNumber = arc4random()%9;
//
//        NSNumber *tempNumber = sudokuArray[0][y];
//        [sudokuArray[0] replaceObjectAtIndex:y withObject:sudokuArray[0][randomNumber]];
//        [sudokuArray[0] replaceObjectAtIndex:randomNumber withObject:tempNumber];
//    }
//
//    return sudokuArray;
//}

+ (NSMutableArray<NSNumber *> *)optionalNumbers:(NSArray<NodeModel *> *)suduku index:(NSUInteger)index {
    if (![suduku[index].currentNumber isEqualToNumber:@0]) {//当前已填入数字
        return [NSMutableArray array];
    }
    
    __block NSMutableArray<NSNumber *> *resultArray = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9]];
    
    [suduku enumerateObjectsUsingBlock:^(NodeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (resultArray.count == 0) {//无可填数字，直接终止循环
            *stop = YES;
        }
        if (![obj.currentNumber isEqualToNumber:@0]) {//不为0，需要移除
            if (idx/9 == index/9) {//同行
                [resultArray removeObject:obj.currentNumber];
            } else if (idx%9 == index%9) {//同列
                [resultArray removeObject:obj.currentNumber];
            } else if ((idx/9/3 == index/9/3) && (idx%9/3 == index%9/3)) {//同区域
                [resultArray removeObject:obj.currentNumber];
            }
        }
    }];
    
    return resultArray;
}

+ (void)addOptionNumber:(NSArray<NodeModel *> *)suduku index:(NSUInteger)index {
    
    [suduku enumerateObjectsUsingBlock:^(NodeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx/9 == index/9) {//同行
            [obj.currentOptionNumberArray addObject:suduku[index].currentNumber];
        } else if (idx%9 == index%9) {//同列
            [obj.currentOptionNumberArray addObject:suduku[index].currentNumber];
        } else if ((idx/9/3 == index/9/3) && (idx%9/3 == index%9/3)) {//同区域
            [obj.currentOptionNumberArray addObject:suduku[index].currentNumber];
        }
    }];
}

+ (void)removeOptionNumber:(NSArray<NodeModel *> *)suduku index:(NSUInteger)index {
    __weak typeof(self) weakSelf = self;
    
    [suduku enumerateObjectsUsingBlock:^(NodeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx/9 == index/9) {//同行
            [obj.currentOptionNumberArray removeObject:suduku[index].currentNumber];
        } else if (idx%9 == index%9) {//同列
            [obj.currentOptionNumberArray removeObject:suduku[index].currentNumber];
        } else if ((idx/9/3 == index/9/3) && (idx%9/3 == index%9/3)) {//同区域
            [obj.currentOptionNumberArray removeObject:suduku[index].currentNumber];
        }
        
        //移除后若该位置只包含一个值，则直接赋值并继续移除
        if (obj.currentOptionNumberArray.count == 1) {
            obj.currentNumber = obj.currentOptionNumberArray.firstObject;
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf removeOptionNumber:suduku index:idx];
        }
    }];
}



//规则一：横行1-9
+ (BOOL)passRuleOne:(NSArray<NodeModel *> *)suduku index:(NSUInteger)index {
    __block BOOL isPass = YES;
    
    [suduku enumerateObjectsUsingBlock:^(NodeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx/9 == index/9) {//同行
            if ([suduku[index].currentNumber isEqualToNumber:obj.currentNumber]) {//出现相同
                isPass = NO;
                *stop = YES;
            }
        }
    }];
    
    return isPass;
}

//规则二：竖行1-9
+ (BOOL)passRuleTwo:(NSArray<NodeModel *> *)suduku index:(NSUInteger)index {
    __block BOOL isPass = YES;
    
    [suduku enumerateObjectsUsingBlock:^(NodeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx%9 == index%9) {//同列
            if ([suduku[index].currentNumber isEqualToNumber:obj.currentNumber]) {//出现相同
                isPass = NO;
                *stop = YES;
            }
        }
    }];
    
    return isPass;
}

//规则三：小九宫1-9
+ (BOOL)passRuleThree:(NSArray<NodeModel *> *)suduku index:(NSUInteger)index {
    __block BOOL isPass = YES;
    
    [suduku enumerateObjectsUsingBlock:^(NodeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ((idx/9/3 == index/9/3) && (idx%9/3 == index%9/3)) {//同区域
            if ([suduku[index].currentNumber isEqualToNumber:obj.currentNumber]) {//出现相同
                isPass = NO;
                *stop = YES;
            }
        }
    }];
    
    return isPass;
}

@end
