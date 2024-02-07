//
//  NSString.m
//  ObjectiveCCalculator
//
//  Created by Suguru Tokuda on 2/6/24.
//

#import <Foundation/Foundation.h>
#import "NSString+Extensions.h"

@implementation NSString (Extensions)

- (NSString *)trimTrailingZeros {
    NSRange range = [self rangeOfString:@"."];
    
    if (range.length > 0) {
        NSString *newStr = self;
        int count = 0;
        
        // count the number of trailingZeros
        for (NSUInteger i = self.length - 1; i >= 0; i--) {
            char ch = [self characterAtIndex:i];
            
            if (ch == '0' && ch != '.')
                count += 1;
            else if (ch == '.' || (ch >= '1' && ch <= '9'))
                break;
        }
        
        newStr = [newStr substringToIndex:newStr.length  - count];
        
        return newStr;
    } else {
        return self;
    }
}

@end
