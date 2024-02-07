//
//  CalculatorSymbol.m
//  ObjectiveCCalculator
//
//  Created by Suguru Tokuda on 2/2/24.
//

#import "CalculatorEnums.h"

@implementation CalculatorEnums

+ (CalculatorSymbolEnum)getCalculatorSymbolBasicEnum: (NSString *) str {
    NSString *uppercaseStr = [str uppercaseString];
    if ([uppercaseStr isEqual:@"AC"])
        return Clear;
    else if ([uppercaseStr isEqualToString:@"+/-"])
        return PlusMinus;
    else if ([uppercaseStr isEqualToString:@"%"])
        return Percent;
    else if ([uppercaseStr isEqualToString:@"/"])
        return Divide;
    else if ([uppercaseStr isEqualToString:@"x"])
        return Multiply;
    else if ([uppercaseStr isEqualToString:@"-"])
        return Subtract;
    else if ([uppercaseStr isEqualToString:@"+"])
        return Add;
    else if ([uppercaseStr isEqualToString:@"="])
        return Equals;
    else if ([uppercaseStr isEqualToString:@"."])
        return Period;
    else
        return None;
}

+ (bool)isCalculationCase: (CalculatorSymbolEnum) symbol {
    switch (symbol) {
        case Add:
            return true;
        case Subtract:
            return true;
        case Multiply:
            return true;
        case Divide:
            return true;
        default:
            return false;
    }
}

@end
