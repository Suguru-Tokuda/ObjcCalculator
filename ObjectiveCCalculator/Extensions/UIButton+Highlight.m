//
//  UIButton+Highlight.m
//  ObjectiveCCalculator
//
//  Created by Suguru Tokuda on 2/7/24.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIButton.h"

@implementation UIButton (Highlight)

- (UIButton *)highlightWithBackgroundColor:(UIColor *) backgroundColor tintColor: (UIColor *) textColor {
    UIButton *retVal = self;
    
    retVal.backgroundColor = backgroundColor;
    retVal.tintColor = textColor;
    
    return retVal;
}

@end
