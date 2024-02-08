//
//  CalculatorViewModel.m
//  ObjectiveCCalculator
//
//  Created by Suguru Tokuda on 2/5/24.
//

#import <Foundation/Foundation.h>
#import "CalculatorViewModel.h"
#import "../Enums/CalculatorEnums.h"

@implementation CalculatorViewModel

- (void)setInitialValues {
    _lastSymbol = None;
    _symbolHighlighted = None;
    _sum = NULL;
    _input1 = NULL;
    _input2 = NULL;
    _lastOperationNum = NULL;
    _numberToAppendTo = Input1;
    _appendPeriod = false;
}

- (void)clear {
    _sum = NULL;
    _input1 = NULL;
}

- (bool)showC {
    bool isCalculationCase = [CalculatorEnums isCalculationCase:_symbolHighlighted];
    
    if (_input1 || (_input2 && isCalculationCase) || _sum)
        return true;
    
    return false;
}

- (void)performCalculation: (CalculatorSymbolEnum) symbol {
    double firstValue = _input1 == NULL ? _sum.doubleValue : _input1.doubleValue;
    double input2Value = 0;

    // use the new input2 value
    if (_input2 && _lastOperationNum && (_input2.doubleValue != _lastOperationNum.doubleValue || _input2.doubleValue == _lastOperationNum.doubleValue)) {
        input2Value = _input2.doubleValue;
    } else if (_input2 && !_lastOperationNum) {
        input2Value = _input2.doubleValue;
    } else if (!_input2 && _lastOperationNum) {
        input2Value = _lastOperationNum.doubleValue;
    } else if (!_input2 && !_lastOperationNum) {
        input2Value = firstValue;
    }

    switch (symbol) {
        case Add:
            _sum = [NSNumber numberWithDouble:firstValue + input2Value];
            break;
        case Subtract:
            _sum = [NSNumber numberWithDouble:firstValue - input2Value];
            break;
        case Multiply:
            _sum = [NSNumber numberWithDouble:firstValue * input2Value];
            break;
        case Divide:
            _sum = [NSNumber numberWithDouble:firstValue / input2Value];
            break;
        default:
            break;
    }
    
    _input1 = NULL;
    _lastOperationNum = [NSNumber numberWithDouble:input2Value];
}

- (void)invertNumber:(NumberType)numberType {
    switch (numberType) {
        case Sum:
            _sum = [NSNumber numberWithDouble:_sum.doubleValue * -1];
            break;
        case Input1:
            _input1 = [NSNumber numberWithDouble:_input1.doubleValue * -1];
            break;
        case Input2:
            _input2 = [NSNumber numberWithDouble:_input2.doubleValue * -1];
            break;
    }
}

- (void)percentile:(NumberType)numberType {
    switch (numberType) {
        case Sum:
            _sum = [NSNumber numberWithDouble:_sum.doubleValue / 100];
            break;
        case Input1:
            _input1 = [NSNumber numberWithDouble:_input1.doubleValue / 100 ];
            break;
        case Input2:
            _input2 = [NSNumber numberWithDouble:_input2.doubleValue / 100];
            break;
    }
}

@end
