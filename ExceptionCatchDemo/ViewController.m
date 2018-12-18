//
//  ViewController.m
//  ExceptionCatchDemo
//
//  Created by Kenway-Pro on 2018/12/15.
//  Copyright © 2018 Kenway. All rights reserved.
//

#import "ViewController.h"
#import "CNCrashHandler.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSArray
    NSArray *test = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
//    NSLog(@"%@",test[0]);
//    NSLog(@"%@",[test objectAtIndex:1]);
//    NSLog(@"%@",[test objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSRangeFromString(@"(3,5)")]]);
 
    //NSMutableArray
    NSMutableArray *test2 = [NSMutableArray arrayWithArray:test];
    [test2 insertObject:@"10" atIndex:10];
//    [test2 removeObjectAtIndex:6];
}


/*
 - (void)ch_insertObject:(id)anObject atIndex:(NSUInteger)index;
 - (void)ch_removeObjectAtIndex:(NSUInteger)index;
 - (void)ch_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
 - (void)ch_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
 - (void)ch_removeObject:(id)anObject inRange:(NSRange)range;
 - (void)ch_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray range:(NSRange)otherRange;
 - (void)ch_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray;
 - (void)ch_insertObjects:(NSArray<id> *)objects atIndexes:(NSIndexSet *)indexes;
 - (void)ch_removeObjectsAtIndexes:(NSIndexSet *)indexes;
 - (void)ch_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<id> *)objects;
 - (void)ch_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;
 */

@end
