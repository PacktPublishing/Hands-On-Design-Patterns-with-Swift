//
//  FVMeasure.h
//  ObjCInterop
//
//  Created by Florent Vilmart on 18-05-16.
//  Copyright © 2018 flovilmart. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FVMeasureUnit) {
    FVLiters NS_SWIFT_NAME(l),
    FVMilliliters NS_SWIFT_NAME(ml),
    FVCups
} NS_SWIFT_NAME(MeasureUnit);

NS_SWIFT_NAME(Measure)
@interface FVMeasure : NSObject

@property (nonatomic, readonly) double amount;
@property (nonatomic, readonly) FVMeasureUnit unit;

+ (instancetype) measureWithAmount:(double) amount unit:(FVMeasureUnit) unit;
+ (instancetype) withCups:(NSUInteger) value NS_SWIFT_NAME(init(cups:));

- (double)valueInUnit:(FVMeasureUnit) unit NS_SWIFT_NAME(in(unit:));
@end
