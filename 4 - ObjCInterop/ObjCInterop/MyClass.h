//
//  MyClass.h
//  ObjCInterop
//
//  Created by Florent Vilmart on 18-05-10.
//  Copyright © 2018 flovilmart. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyClass : NSObject

- (NSString *)sayHello;
- (MyClass *)child;
- (NSString *)append:(NSString *)aString with:(NSString *)anotherString;
- (void) run:(NSString * _Nullable) string;

- (NSArray *)untypedArray;
- (NSArray<NSString *> *)stringArray;
- (NSArray<__kindof NSString *> *)kindofStringArray;

@end

NS_ASSUME_NONNULL_END
