//
//  WCWeakArray.m
//  WeakCollections
//
//  Created by Scott Perry on 06/03/13.
//  Copyright (c) 2013 Scott Perry. All rights reserved.
//

#import "WCWeakArray.h"

#import "WCWeakValue.h"


@interface WCWeakArray ()

@property (nonatomic, strong, readonly) NSMutableArray *internal;

@end


@implementation WCWeakArray

- (instancetype)init;
{
    self = [super init];
    if (!self) { return nil; }
    
    _internal = [NSMutableArray new];
    
    return self;
}

- (id)referenceAtIndex:(NSUInteger)index;
{
    return [[self.internal objectAtIndex:index] value];
}

- (void)addReference:(id)reference;
{
    [self.internal addObject:[WCWeakValue weakValueWithValue:reference]];
}

- (void)removeReferenceAtIndex:(NSUInteger)index;
{
    [self.internal removeObjectAtIndex:index];
}

- (void)insertReference:(id)reference atIndex:(NSUInteger)index;
{
    [self.internal insertObject:[WCWeakValue weakValueWithValue:reference] atIndex:index];
}

- (void)replaceReferenceAtIndex:(NSUInteger)index withReference:(id)reference;
{
    [self.internal replaceObjectAtIndex:index withObject:[WCWeakValue weakValueWithValue:reference]];
}

- (void)compact;
{
    if (![self.internal count]) {
        return;
    }
    
    NSMutableIndexSet *emptyIndexes = [NSMutableIndexSet new];
    
    WCWeakValue *container = [self.internal objectAtIndex:0];
    for (NSUInteger i = 0; i < [self.internal count]; i++) {
        container = [self.internal objectAtIndex:i];
        if (!container.value) {
            [emptyIndexes addIndex:i];
        }
    }
    
    [self.internal removeObjectsAtIndexes:emptyIndexes];
}

- (NSUInteger)count;
{
    return [self.internal count];
}

- (void)setCount:(NSUInteger)count;
{
    while ([self.internal count] < count) {
        [self.internal addObject:[WCWeakValue new]];
    }
    
    while ([self.internal count] > count) {
        [self.internal removeLastObject];
    }
}

@end


@implementation WCWeakArray (WCWeakArrayConveniences)

+ (id)weakArray;
{
    return [WCWeakArray new];
}

- (NSArray *)allObjects;
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (WCWeakValue *container in self.internal) {
        id value = container.value;
        if (value) {
            [result addObject:value];
        }
    }
    
    return result;
}

@end
