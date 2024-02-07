//
//  UIImage+Resize.m
//  ObjectiveCCalculator
//
//  Created by Suguru Tokuda on 2/6/24.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIImage.h"
#import "UIKit/UIGraphics.h"
#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage *)resizedImageWithBounds:(CGSize)bounds {
    UIGraphicsBeginImageContext(bounds);
    [self drawInRect:CGRectMake(0, 0, bounds.width, bounds.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
