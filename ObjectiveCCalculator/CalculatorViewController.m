//
//  ViewController.m
//  ObjectiveCCalculator
//
//  Created by Suguru Tokuda on 2/1/24.
//

#import "CalculatorViewController.h"
#import "CalculatorEnums.h"
#import "ViewModels/CalculatorViewModel.h"
#import "Extensions/NSString+Extensions.h"
#import "Extensions/NSNumber+Extensions.h"
#import "Extensions/UIImage+Resize.h"
#import "Extensions/UIButton+Highlight.h"

@interface CalculatorViewController ()

@property (strong, nonatomic) CalculatorViewModel *vm;

// UI properties
@property (strong, nonatomic) UIColor *defaultBtnBackgroundColor;
@property (strong, nonatomic) UIColor *defaultBtnTintColor;
@property (strong, nonatomic) UIColor *selectedBtnBackgroundColor;
@property (strong, nonatomic) UIColor *selectedBtnTintColor;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIStackView *outerStackView;
@property (nonatomic) NumberType displayedNumberType;

// References for the buttons to change
@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) UIButton *divideBtn;
@property (nonatomic, strong) UIButton *multiplyBtn;
@property (nonatomic, strong) UIButton *subtractBtn;
@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initValues];
    [self setupUI];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _outerStackView = nil;
}

- (void)initValues {
    _displayedNumberType = Sum;
}

- (void)setupUI {
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    _defaultBtnBackgroundColor = UIColor.systemBlueColor;
    _defaultBtnTintColor = UIColor.whiteColor;
    _selectedBtnBackgroundColor = UIColor.whiteColor;
    _selectedBtnTintColor = UIColor.systemBlueColor;
    
    _vm = [[CalculatorViewModel alloc] init];
    [_vm setInitialValues];
    
    _numberLabel = [self getNumberLabel:_vm.sum.intValue];
    _outerStackView = [self getOuerStackView];
    [_outerStackView addArrangedSubview:_numberLabel];
    [self addKeyButtons: _outerStackView];
    
    [self.view addSubview:_outerStackView];
    [self applyConstraints];
}

- (void)applyConstraints {
    NSArray *stackViewConstraints = [NSArray arrayWithObjects:
                                     [_outerStackView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-50],
                                     [_outerStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:5],
                                     [_outerStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-5]
                                     , nil];

    [NSLayoutConstraint activateConstraints:stackViewConstraints];
}

- (void)addKeyButtons: (UIStackView *) outerStackView {
    UIStackView *firstRow = [self getStackView:UILayoutConstraintAxisHorizontal spacing:1];
    UIStackView *secondRow = [self getStackView:UILayoutConstraintAxisHorizontal spacing:1];
    UIStackView *thirdRow = [self getStackView:UILayoutConstraintAxisHorizontal spacing:1];
    UIStackView *fourthRow = [self getStackView:UILayoutConstraintAxisHorizontal spacing:1];
    UIStackView *fifthRow = [self getStackView:UILayoutConstraintAxisHorizontal spacing:0];
    
    _clearBtn = [self getDefaultButtonWithText:@"AC" withTag:Clear];
    UIButton *plusMinusBtn = [self getDefaultButtonWithSystemImage:@"plus.forwardslash.minus" withTag:PlusMinus];
    UIButton *percentBtn = [self getDefaultButtonWithSystemImage:@"percent" withTag:Percent];
    
    _divideBtn = [self getDefaultButtonWithSystemImage:@"divide" withTag:Divide];
    _multiplyBtn = [self getDefaultButtonWithSystemImage:@"multiply" withTag:Multiply];
    _subtractBtn = [self getDefaultButtonWithSystemImage:@"minus" withTag:Subtract];
    _addBtn = [self getDefaultButtonWithSystemImage:@"plus" withTag:Add];
    
    [firstRow addArrangedSubview:_clearBtn];
    [firstRow addArrangedSubview:plusMinusBtn];
    [firstRow addArrangedSubview:percentBtn];
    [firstRow addArrangedSubview:_divideBtn];
    
    for (int i = 7; i <= 9; i++) {
        UIButton *btn = [self getDefaultButtonWithText:[NSString stringWithFormat:@"%d", i] withTag:i];
        btn.tag = i;
        [secondRow addArrangedSubview:btn];
    }
    
    [secondRow addArrangedSubview:_multiplyBtn];
    
    for (int i = 4; i <= 6; i++) {
        UIButton *btn = [self getDefaultButtonWithText:[NSString stringWithFormat:@"%d", i] withTag:i];
        [thirdRow addArrangedSubview:btn];
    }
    
    [thirdRow addArrangedSubview:_subtractBtn];
    
    for (int i = 1; i <= 3; i++) {
        UIButton *btn = [self getDefaultButtonWithText:[NSString stringWithFormat:@"%d", i] withTag:i];
        [fourthRow addArrangedSubview:btn];
    }
    
    [fourthRow addArrangedSubview:_addBtn];
    
    UIButton *zeroBtn = [self getDefaultButtonWithText:@"0" withTag:Zero];
    UIButton *emptyBtn = [self getDefaultBtnWithBackgroundColor:_defaultBtnBackgroundColor tintColor:_defaultBtnTintColor];
    emptyBtn.enabled = NO;
    UIButton *dotBtn = [self getDefaultButtonWithText:@"." withTag:Period];
    UIButton *equalBtn = [self getDefaultButtonWithSystemImage:@"equal" withTag:Equals];
    
    [fifthRow addArrangedSubview:zeroBtn];
    [fifthRow addArrangedSubview:emptyBtn];
    [fifthRow addArrangedSubview:dotBtn];
    [fifthRow addArrangedSubview:equalBtn];
    [fifthRow setCustomSpacing:1 afterView:emptyBtn];
    [fifthRow setCustomSpacing:1 afterView:dotBtn];
    
    [outerStackView addArrangedSubview:firstRow];
    [outerStackView addArrangedSubview:secondRow];
    [outerStackView addArrangedSubview:thirdRow];
    [outerStackView addArrangedSubview:fourthRow];
    [outerStackView addArrangedSubview:fifthRow];
}

- (UIStackView *)getOuerStackView {
    UIStackView *stackView = [[UIStackView alloc] init];
    [stackView setSpacing:1];
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    stackView.distribution = UIStackViewDistributionEqualCentering;
    stackView.axis = UILayoutConstraintAxisVertical;
    return stackView;
}

- (UILabel *)getNumberLabel: (int) initialValue {
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = false;
    label.font = [UIFont systemFontOfSize:48 weight:UIFontWeightRegular];
    label.text = [[NSString alloc] initWithFormat:@"%d", initialValue];
    label.textAlignment = NSTextAlignmentRight;
    return label;
}

- (UIStackView *)getStackView: (UILayoutConstraintAxis)axis spacing:(CGFloat) spacing {
    UIStackView *stackView = [[UIStackView alloc] init];
    
    stackView.axis = axis;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    [stackView setSpacing:spacing];
    
    return stackView;
}

- (UIButton *)getDefaultBtnWithBackgroundColor:(UIColor *)backgroundColor tintColor:(UIColor *) tintColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButtonConfiguration *btnConfig = btn.configuration;
    
    // config
    btnConfig.contentInsets = NSDirectionalEdgeInsetsMake(5, 5, 5, 5);
    
    btn.translatesAutoresizingMaskIntoConstraints = false;
    btn.titleLabel.font = [UIFont systemFontOfSize:32 weight:UIFontWeightMedium];
    [btn addTarget:self action:@selector(handleBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = backgroundColor;
    btn.tintColor = tintColor;
    btn.configuration = btnConfig;
    
    [NSLayoutConstraint activateConstraints:@[[btn.heightAnchor constraintEqualToConstant:100]]];
    return btn;
}

- (UIButton *)getDefaultButtonWithText: (NSString *) text withTag: (CalculatorSymbolEnum) tag {
    UIButton *btn = [self getDefaultBtnWithBackgroundColor:_defaultBtnBackgroundColor tintColor:_defaultBtnTintColor];

    [btn setTitle:text forState:UIControlStateNormal];
    btn.tag = tag;
    
    return btn;
}

- (UIButton *)getDefaultButtonWithSystemImage: (NSString *) systemImageName withTag: (CalculatorSymbolEnum) tag {
    UIButton *btn = [self getDefaultBtnWithBackgroundColor:_defaultBtnBackgroundColor tintColor:_defaultBtnTintColor];
    UIImage *img = [UIImage systemImageNamed:systemImageName];
    UIButtonConfiguration *btnConfig = btn.configuration;
    
    [btn setImage:img forState:UIControlStateNormal];
    btn.tintColor = [UIColor whiteColor];
    btn.tag = tag;
    btn.configuration = btnConfig;
    
    return btn;
}

- (void)handleBtnTapped: (UIButton *) sender {
    NSInteger tag = sender.tag;
    
    if (tag >= 0 && tag < 10) {
        [self handleNmberInput:[sender.titleLabel.text intValue] appendTo:_vm.numberToAppendTo withPeriod:[self hasPeriodAtTheEnd]];
    } else {
        [self handleSymbolInput:tag];
    }
    
    [self updateClearBtn];
}

- (bool)hasPeriodAtTheEnd {
    NSString *numberLabelText = _numberLabel.text;
    NSRange periodRange = [numberLabelText rangeOfString:@"."];
    bool isPeriodAtTheEnd = periodRange.location == numberLabelText.length - 1;
    
    return isPeriodAtTheEnd;
}

- (void)handleNmberInput: (int) number appendTo: (NumberType) numberToAppend withPeriod: (bool) appendPeriod {
    double currentNum = 0;
    NSNumber *input;
    
    switch (numberToAppend) {
        case Input1: {
            input = _vm.input1;
            if (input == NULL)
                input = [NSNumber numberWithInt:0];
            break;
        }
        case Input2: {
            if (_vm.input2 == NULL)
                _vm.input2 = [NSNumber numberWithInt: 0];
            input = _vm.input2;
            [self resetCalculatorButtonColors];
            _vm.symbolHighlighted = None;
            break;
        }
        default:
            break;
    }
    
    if (input) {
        bool isInteger = true;

        if (input) {
            currentNum = input.doubleValue;
            isInteger = [input isInteger];
        }
        
        NSString *inputNumStr = @"";
        
        if (isInteger) {
            inputNumStr = [NSString stringWithFormat:appendPeriod ? @"%d.%d" : @"%d%d", (int)currentNum, number];
        } else {
            inputNumStr = [NSString stringWithFormat:@"%f", currentNum];
            inputNumStr = [NSString stringWithFormat:@"%@%d", [inputNumStr trimTrailingZeros], number];
        }
        
        switch (numberToAppend) {
            case Input1:
                _vm.input1 = [NSNumber numberWithDouble:inputNumStr.doubleValue];
                break;
            case Input2:
                _vm.input2 = [NSNumber numberWithDouble:inputNumStr.doubleValue];
                [self resetCalculatorButtonColors];
                break;
            default:
                break;
        }
        
        [self updateNumberLabel:numberToAppend withPeriod:_vm.appendPeriod];
    }
}

- (void)handleSymbolInput: (CalculatorSymbolEnum) symbol {
    switch (symbol) {
        case Clear:
            [self handleClearBtnTapped];
            break;
        case PlusMinus:
            [self handlePlusMinusBtnTapped];
            break;
        case Percent:
            [self handlePercentBtuTapped];
            break;
        case Equals:
            if (_vm.lastSymbol != None) {
                [_vm performCalculation:_vm.lastSymbol];
                [self updateNumberLabel:Sum withPeriod:_vm.appendPeriod];
                _vm.input1 = NULL;
                _vm.numberToAppendTo = Input1;
                _vm.symbolHighlighted = None;
            }
            break;
        case Period:
            _vm.appendPeriod = true;
            [self updateNumberLabel:Input1 withPeriod:_vm.appendPeriod];
            break;
        default:
            if ([CalculatorEnums isCalculationCase:_vm.lastSymbol] && _vm.lastSymbol != symbol && _vm.input2) {
                [_vm performCalculation:_vm.lastSymbol];
                [self updateNumberLabel:Sum withPeriod:_vm.appendPeriod];
                _vm.symbolHighlighted = symbol;
                _vm.numberToAppendTo = Input2;
                _vm.input2 = NULL;
                [self updateCalculatorSymbolBtnTextColor: _vm.symbolHighlighted symbol:symbol];
            } else {
                _vm.symbolHighlighted = symbol;
                _vm.numberToAppendTo = Input2;
                [self updateCalculatorSymbolBtnTextColor: _vm.symbolHighlighted symbol:symbol];
            }
            
            _vm.lastSymbol = symbol;
            break;
    }
    
    if (symbol != Period)
        _vm.appendPeriod = false;
}

- (void)handleClearBtnTapped {
    NSString *btnText = _clearBtn.titleLabel.text;
        
    if ([[btnText uppercaseString] isEqualToString:@"AC"]) {
        [self clearAll];
    } else {
        [self clear];
    }
}

- (void)handlePlusMinusBtnTapped {
    [_vm invertNumber:_displayedNumberType];
    [self updateNumberLabel:_displayedNumberType withPeriod:_vm.appendPeriod];
}

- (void)handlePercentBtuTapped {
    [_vm percentile:_displayedNumberType];
    [self updateNumberLabel:_displayedNumberType withPeriod:_vm.appendPeriod];
}

- (void)clear {
    [_vm clear];
    [self updateNumberLabel:Sum withPeriod:_vm.appendPeriod];
    [self updateClearBtn];
}

- (void)clearAll {
    [_vm setInitialValues];
    [self updateNumberLabel:Sum withPeriod:_vm.appendPeriod];
    [self resetCalculatorButtonColors];
}

- (void)updateNumberLabel: (NumberType) numberToDisplay withPeriod: (bool)appendPeriod {
    double numberToUse = 0;
    
    switch (numberToDisplay) {
        case Sum:
            numberToUse = _vm.sum.doubleValue;
            break;
        case Input1:
            numberToUse = _vm.input1.doubleValue;
            break;
        case Input2:
            numberToUse = _vm.input2.doubleValue;
            break;
    }
    
    bool isInteger = floor(numberToUse) == numberToUse;
    NSString *labelText;
    
    if (!appendPeriod) {
        labelText = [NSString stringWithFormat:isInteger ? @"%.f" : @"%f", numberToUse];
    } else {
        if (isInteger) {
            labelText = [NSString stringWithFormat:@"%d.", (int)numberToUse];
        } else {
            labelText = [NSString stringWithFormat:@"%f", numberToUse];
        }
    }
    
    labelText = [labelText trimTrailingZeros];
    _displayedNumberType = numberToDisplay;
    _numberLabel.text = labelText;
}

- (int)getNumberOfNonZeroNumbersAfterPeriod: (double) number {
    int retVal = 0;
    
    NSString *str = [NSString stringWithFormat:@"%f", number];
    bool periodChecked = false;
    
    for (NSUInteger i = 0; i < str.length; i++) {
        char ch = [str characterAtIndex:i];
        
        if (ch == '.') {
            periodChecked = true;
        }
    }
    
    for (NSUInteger i = str.length - 1; i >= 0; i--) {
        char ch = [str characterAtIndex:i];
        
        if (ch != '0' && ch != '.')
            retVal += 1;
        else if (ch == '.')
            break;
    }
    
    return retVal;
}

- (void)resetCalculatorButtonColors {
    _divideBtn = [_divideBtn highlightWithBackgroundColor:_defaultBtnBackgroundColor tintColor:_defaultBtnTintColor];
    _multiplyBtn = [_multiplyBtn highlightWithBackgroundColor:_defaultBtnBackgroundColor tintColor:_defaultBtnTintColor];
    _subtractBtn = [_subtractBtn highlightWithBackgroundColor:_defaultBtnBackgroundColor tintColor:_defaultBtnTintColor];
    _addBtn = [_addBtn highlightWithBackgroundColor:_defaultBtnBackgroundColor tintColor:_defaultBtnTintColor];
}

- (void)updateCalculatorSymbolBtnTextColor: (CalculatorSymbolEnum) symbolHighted symbol:(CalculatorSymbolEnum) symbol {
    [self resetCalculatorButtonColors];
    UIButton *btnToUpdate = NULL;
    
    if (symbolHighted == symbol) {
        switch (symbol) {
            case Add:
                btnToUpdate = _addBtn;
                break;
            case Subtract:
                btnToUpdate = _subtractBtn;
                break;
            case Multiply:
                btnToUpdate = _multiplyBtn;
                break;
            case Divide:
                btnToUpdate = _divideBtn;
                break;
            default:
                return;
        }
    }
    
    if (btnToUpdate) {
        btnToUpdate = [btnToUpdate highlightWithBackgroundColor:_selectedBtnBackgroundColor tintColor:_selectedBtnTintColor];
    }
}

- (void)updateClearBtn {
    [UIView performWithoutAnimation:^{
        [_clearBtn setTitle:[_vm showC] ? @"C" : @"AC" forState:UIControlStateNormal];
    }];
}

@end
