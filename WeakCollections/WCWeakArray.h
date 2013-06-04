//
//  WCWeakArray.h
//  WeakCollections
//
//  Created by Scott Perry on 06/03/13.
//  Copyright (c) 2013 Scott Perry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCWeakArray : NSObject

- (id)referenceAtIndex:(NSUInteger)index;
- (void)addReference:(id)reference;
- (void)removeReferenceAtIndex:(NSUInteger)index;
- (void)insertReference:(id)reference atIndex:(NSUInteger)index;
- (void)replaceReferenceAtIndex:(NSUInteger)index withReference:(id)reference;
- (void)compact;
- (NSUInteger)count;
- (void)setCount:(NSUInteger)count;

@end

@interface WCWeakArray (WCWeakArrayConveniences)

+ (id)weakArray;

- (NSArray *)allObjects;

@end
