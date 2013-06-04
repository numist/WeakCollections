//
//  WCWeakDictionary.m
//  WeakCollections
//
//  Created by Scott Perry on 06/03/13.
//  Copyright © 2013 Scott Perry.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "WCWeakDictionary.h"

#import "WCWeakValue.h"


@interface WCWeakDictionary ()

@property (nonatomic, strong, readonly) NSMutableDictionary *internal;

@end


@implementation WCWeakDictionary

- (instancetype)init;
{
    self = [super init];
    if (!self) { return nil; }
    
    _internal = [NSMutableDictionary new];
    
    return self;
}

- (id)referenceForKey:(id)key;
{
    return [[self.internal objectForKey:key] value];
}

- (void)setReference:(id)reference forKey:(id<NSCopying>)key;
{
    [self.internal setObject:[WCWeakValue weakValueWithValue:reference] forKey:key];
}

- (void)removeReferenceForKey:(id)key;
{
    [self.internal removeObjectForKey:key];
}

- (void)compact;
{
    if (![self.internal count]) {
        return;
    }
    
    NSMutableArray *keyArray = [NSMutableArray new];
    
    for (id key in self.internal) {
        if (![self referenceForKey:key]) {
            [keyArray addObject:key];
        }
    }
    
    [self.internal removeObjectsForKeys:keyArray];
}

- (NSUInteger)count;
{
    return [self.internal count];
}

@end

@implementation WCWeakDictionary (WCWeakDictionaryConveniences)

+ (id)weakDictionary;
{
    return [WCWeakDictionary new];
}

- (NSArray *)allKeys;
{
    return [self.internal allKeys];
}

- (NSArray *)allValues;
{
    NSMutableArray *valueArray = [NSMutableArray new];
    
    for (id key in self.internal) {
        id obj = [self referenceForKey:key];
        if (obj) {
            [valueArray addObject:obj];
        }
    }
    
    return valueArray;
}

@end
