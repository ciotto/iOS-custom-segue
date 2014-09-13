//
//  BCUtilities.h
//  BCTool
//
//  Created by Christian Bianciotto on 16/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BCUtilities : NSObject

// Fonts

// Return a custom font using FontMap.plist with same size and type of input
// font.
// FontMap.plist copntain a dictionary with input font-family as key and custom
// font-family as value.
+ (UIFont *)customFontFromFont:(UIFont *)font;

// Return a custom font, if fontFamily is nil use FontMap.plist, if type is nil
// use the type of input font.
// FontMap.plist copntain a dictionary with input font-family as key and custom
// font-family as value.
+ (UIFont *)customFontFromFont:(UIFont *)font type:(NSString *)type andFontFamily:(NSString *)fontFamily;

@end
