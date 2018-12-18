//
//  CKHLogHandler.m
//  ExceptionCatchDemo
//
//  Created by Kenway-Pro on 2018/12/15.
//  Copyright © 2018 Kenway. All rights reserved.
//

#import "CNCrashHandler.h"
#import <objc/runtime.h>

@implementation NSArray (CrashHandler)

- (id)ch_objectAtIndexedSubscript:(NSUInteger)index{
    if (index < self.count) {
        return [self ch_objectAtIndexedSubscript:index];
    }else{
        NSArray *callStack = [NSThread callStackSymbols];
        NSDictionary *exceptionInfo = @{@"name":[NSString stringWithFormat:@"***%@",NSRangeException],
                                        @"reason":[NSString stringWithFormat:@"***-[__NSArrayI objectAtIndexedSubscript:] index %ld beyond bounds [0 .. %ld]",index,self.count - 1],
                                        @"first_throw_call_stack":callStack
                                        };
        NSLog(@"%@",exceptionInfo);
        return nil;
    }
}

- (id)ch_objectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        return [self ch_objectAtIndex:index];
    }else{
        NSArray *callStack = [NSThread callStackSymbols];
        NSDictionary *exceptionInfo = @{@"name":[NSString stringWithFormat:@"*** %@",NSRangeException],
                                        @"reason":[NSString stringWithFormat:@"*** -[__NSArrayI objectAtIndex:] index %ld beyond bounds [0 .. %ld]",index,self.count - 1],
                                        @"first_throw_call_stack":callStack
                                        };
        NSLog(@"%@",exceptionInfo);
        return nil;
    }
}
- (NSArray *)ch_objectAtIndexs:(NSIndexSet *)indexSet{
    if (indexSet.lastIndex < self.count - 1) {
        return [self ch_objectAtIndexs:indexSet];
    }else if([indexSet containsIndex:self.count - 1]){
        NSIndexSet *idxSet = [NSIndexSet indexSetWithIndexesInRange:NSRangeFromString([NSString stringWithFormat:@"(%ld,%ld)",indexSet.firstIndex,self.count - indexSet.firstIndex])];
        NSArray *array = [self ch_objectAtIndexs:idxSet];
        //异常部分日志输出
        NSIndexSet *beyondSet = [NSIndexSet indexSetWithIndexesInRange:NSRangeFromString([NSString stringWithFormat:@"(%ld,%ld)",self.count,indexSet.lastIndex - self.count])];
        NSArray *callStack = [NSThread callStackSymbols];
        NSDictionary *exceptionInfo = @{@"name":[NSString stringWithFormat:@"*** %@",NSRangeException],
                                        @"reason":[NSString stringWithFormat:@"*** -[NSArray objectsAtIndexes:] index (%ld,%ld) in index set beyond bounds [0 .. %ld]",beyondSet.firstIndex,beyondSet.lastIndex,self.count - 1],
                                        @"first_throw_call_stack":callStack
                                        };
        NSLog(@"%@",exceptionInfo);
        return array;
    }else{
        NSIndexSet *beyondSet = [NSIndexSet indexSetWithIndexesInRange:NSRangeFromString([NSString stringWithFormat:@"(%ld,%ld)",self.count,indexSet.lastIndex])];
        NSArray *callStack = [NSThread callStackSymbols];
        NSDictionary *exceptionInfo = @{@"name":[NSString stringWithFormat:@"*** %@",NSRangeException],
                                        @"reason":[NSString stringWithFormat:@"*** -[NSArray objectsAtIndexes:] index (%ld,%ld) in index set beyond bounds [0 .. %ld]",beyondSet.firstIndex,beyondSet.lastIndex,self.count - 1],
                                        @"first_throw_call_stack":callStack
                                        };
        NSLog(@"%@",exceptionInfo);
        return nil;
    }
}
@end

@implementation NSMutableArray (CrashHandler)

- (void)ch_insertObject:(id)anObject atIndex:(NSUInteger)index{
    NSLog(@"#####:%ld",index);
    [self ch_insertObject:anObject atIndex:index];
    /*
    if (index < self.count) {
        [self ch_insertObject:anObject atIndex:index];
    }else{
        NSLog(@"insert 数组越界");
    }
     */
}
- (void)ch_removeObjectAtIndex:(NSUInteger)index{
    
}
- (void)ch_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    
}
- (void)ch_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2{
    
}
- (void)ch_removeObject:(id)anObject inRange:(NSRange)range{
    
}
- (void)ch_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray range:(NSRange)otherRange{
    
}
- (void)ch_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray{
    
}
- (void)ch_insertObjects:(NSArray<id> *)objects atIndexes:(NSIndexSet *)indexes{
    
}
- (void)ch_removeObjectsAtIndexes:(NSIndexSet *)indexes{
    
}
- (void)ch_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<id> *)objects{
    
}
- (void)ch_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx{
    
}
@end


@implementation CNCrashHandler

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self handleCrash];
    });
}

+ (void)handleCrash{
//    [self arrayRangeSafe];
    [self mutableArrayRangeSafe];
}
@end

@implementation CNCrashHandler (Array)
+ (void)arrayRangeSafe{
    //NSArray
    Method indexSubscript = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:));
    Method indexSubscriptRangeSafe = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(ch_objectAtIndexedSubscript:));
    
    Method objectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method objectAtIndexSafe = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(ch_objectAtIndex:));
    
    Method objectAtIndexSet = class_getInstanceMethod(objc_getClass("NSArray"), @selector(objectsAtIndexes:));
    Method objectAtIndexSetRangeSafe = class_getInstanceMethod(objc_getClass("NSArray"), @selector(ch_objectAtIndexs:));
    
    method_exchangeImplementations(indexSubscript, indexSubscriptRangeSafe);
    method_exchangeImplementations(objectAtIndex, objectAtIndexSafe);
    method_exchangeImplementations(objectAtIndexSet, objectAtIndexSetRangeSafe);
}
@end

@implementation CNCrashHandler (MutableArray)
+ (void)mutableArrayRangeSafe{
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
    
    Method insertObject = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(insertObject:atIndex:));
    Method insertObjectRangeSafe = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(ch_insertObject:atIndex:));
    
    Method removeObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(removeObjectAtIndex:));
    Method removeObjectAtIndexRangeSafe = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(ch_removeObjectAtIndex:));
    
    method_exchangeImplementations(insertObject, insertObjectRangeSafe);
//    method_exchangeImplementations(removeObjectAtIndex, removeObjectAtIndexRangeSafe);
}

@end
