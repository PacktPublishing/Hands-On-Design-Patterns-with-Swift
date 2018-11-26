//
//  Generic.m
//  ObjCInterop
//
//  Created by Florent Vilmart on 18-05-23.
//  Copyright © 2018 flovilmart. All rights reserved.
//

#import "MyGeneric.h"

@implementation MyGeneric

- (NSArray *)untypedArray {
    return @[];
}

- (NSArray *)stringArray {
    return @[];
}

- (NSArray *)kindofStringArray {
    return @[];
}

@end


void doIt() {
    MyGeneric * untypedGeneric = [MyGeneric new];
    [untypedGeneric genericArray]; // NSArray*

    MyGeneric<NSNumber *> * casted = (MyGeneric<NSNumber *> *) untypedGeneric;
    [casted genericArray];

    MyGeneric<NSNumber *> * numberGeneric = [MyGeneric new];
    [numberGeneric genericArray]; // NSArray<NSNumber *> *
}
