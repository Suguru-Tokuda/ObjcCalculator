//
//  double_Extensions.m
//  ObjectiveCCalculator
//
//  Created by Suguru Tokuda on 2/6/24.
//

#import <Foundation/Foundation.h>
#import "NSNumber+Extensions.h"

@implementation NSNumber (Extensions)

- (bool)isInteger {
    double doubleVal = self.doubleValue;
    return floor(doubleVal) == doubleVal;
}

@end
