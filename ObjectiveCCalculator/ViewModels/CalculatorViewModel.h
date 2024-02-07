//
//  CalculatorViewModel.h
//  ObjectiveCCalculator
//
//  Created by Suguru Tokuda on 2/5/24.
//

#ifndef CalculatorViewModel_h
#define CalculatorViewModel_h

#include "../Enums/CalculatorEnums.h"

@interface CalculatorViewModel : NSObject

// number variables
@property (nonatomic) NSNumber *sum; // holds the sum
@property (nonatomic) NSNumber *input1; // holds the first input
@property (nonatomic) NSNumber *input2; // holds the second input
@property (nonatomic) NSNumber *lastOperationNum; // holds the value that was used in the last operation.

// booleans
@property (nonatomic) bool appendPeriod;

// Enums
@property (nonatomic) CalculatorSymbolEnum symbolHighlighted;
@property (atomic) CalculatorSymbolEnum lastSymbol;
@property (nonatomic) NumberType numberToAppendTo;

- (void)clear;
- (void)setInitialValues;
- (bool)showC;
- (void)performCalculation:(CalculatorSymbolEnum) symbol;
- (void)invertNumber:(NumberType)numberType;
- (void)percentile:(NumberType)numberType;

@end

#endif /* CalculatorViewModel_h */
