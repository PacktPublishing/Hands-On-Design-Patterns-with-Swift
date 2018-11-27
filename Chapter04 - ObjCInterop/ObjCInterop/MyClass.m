//
//  MyClass.m
//  ObjCInterop
//
//  Created by Florent Vilmart on 18-05-10.
//  Copyright © 2018 flovilmart. All rights reserved.
//

#import "MyClass.h"
#import "ObjCInterop-Swift.h"

@implementation MyClass


- (NSString *)sayHello {
    [@"Hello World" flv_leftPadToLength:10];
    return nil; //@"Hello World";
}

- (MyClass *)child {
    return nil;
}

@end

void doSomething() {
    NSArray * array = @[@"Hello", @1, @{@"key": @2}, [NSObject new], [NSNull null]];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // Do something with the object
    }];
    NSMutableString *mutableString = [@"Mutable" mutableCopy];

    NSArray<__kindof NSString *> * stringArray = @[@"Hello", mutableString];

    NSMutableString * mut = stringArray[1];
    // hash: 'aa01cc23193abb4a5890aea5ea87e23c94d95c8c12562bf1eba07ccd854c0126',AClass * class = [AClass new];
}
