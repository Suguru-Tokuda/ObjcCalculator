//
//  CalculatorSymbol.h
//  ObjectiveCCalculator
//
//  Created by Suguru Tokuda on 2/2/24.
//
#import <Foundation/Foundation.h>

#ifndef CalculatorSymbol_h
#define CalculatorSymbol_h

@interface CalculatorEnums : NSObject

typedef NS_ENUM(char, CalculatorSymbolEnum) {
    Zero,
    One,
    Two,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Clear,
    PlusMinus,
    Percent,
    Divide,
    Multiply,
    Subtract,
    Add,
    Equals,
    Period,
    None
};

typedef NS_ENUM(NSInteger, NumberType) {
    Sum = 1,
    Input1 = 2,
    Input2 = 3
};

+ (CalculatorSymbolEnum)getCalculatorSymbolBasicEnum: (NSString *) str;
+ (bool)isCalculationCase: (CalculatorSymbolEnum) symbol;

@end

#endif /* CalculatorSymbol_h */
