//
//  Generic.h
//  ObjCInterop
//
//  Created by Florent Vilmart on 18-05-23.
//  Copyright © 2018 flovilmart. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyGeneric<__covariant T> : NSObject

@property (nullable, nonatomic, retain) NSArray<T> * genericArray;

- (NSArray *)untypedArray;
- (NSArray<NSString *> *)stringArray;
- (NSArray<__kindof NSString *> *)kindofStringArray;

@end

NS_ASSUME_NONNULL_END
