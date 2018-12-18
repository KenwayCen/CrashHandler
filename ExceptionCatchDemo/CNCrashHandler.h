//
//  CKHLogHandler.h
//  ExceptionCatchDemo
//
//  Created by Kenway-Pro on 2018/12/15.
//  Copyright © 2018 Kenway. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (CrashHandler)
- (id)ch_objectAtIndexedSubscript:(NSUInteger)index;
- (id)ch_objectAtIndex:(NSUInteger)index;
- (NSArray *)ch_objectAtIndexs:(NSIndexSet *)indexSet;
@end
@interface NSMutableArray (CrashHandler)
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
@end


@interface CNCrashHandler : NSObject
@end
@interface CNCrashHandler (Array)
+ (void)arrayRangeSafe;
@end
@interface CNCrashHandler (MutableArray)
+ (void)mutableArrayRangeSafe;
@end
NS_ASSUME_NONNULL_END
