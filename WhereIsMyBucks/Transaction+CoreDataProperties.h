//
//  Transaction+CoreDataProperties.h
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 12/9/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Transaction.h"
#import "CashFlow.h"
NS_ASSUME_NONNULL_BEGIN

@interface Transaction (CoreDataProperties)

@property (nonatomic) int32_t id;
@property (nullable, nonatomic, retain) NSDecimalNumber *tranAmount;
@property (nonatomic) NSTimeInterval tranDate;
@property (nullable, nonatomic, retain) NSOrderedSet<CashFlow *> *toCashFlow;

@end

@interface Transaction (CoreDataGeneratedAccessors)

- (void)insertObject:(CashFlow *)value inToCashFlowAtIndex:(NSUInteger)idx;
- (void)removeObjectFromToCashFlowAtIndex:(NSUInteger)idx;
- (void)insertToCashFlow:(NSArray<CashFlow *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeToCashFlowAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInToCashFlowAtIndex:(NSUInteger)idx withObject:(CashFlow *)value;
- (void)replaceToCashFlowAtIndexes:(NSIndexSet *)indexes withToCashFlow:(NSArray<CashFlow *> *)values;
- (void)addToCashFlowObject:(CashFlow *)value;
- (void)removeToCashFlowObject:(CashFlow *)value;
- (void)addToCashFlow:(NSOrderedSet<CashFlow *> *)values;
- (void)removeToCashFlow:(NSOrderedSet<CashFlow *> *)values;

@end

NS_ASSUME_NONNULL_END
