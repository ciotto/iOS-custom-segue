//
//  BCUtilities.m
//  BCTool
//
//  Created by Christian Bianciotto on 16/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//

#import "BCUtilities.h"

@implementation BCUtilities

#pragma mark Fonts

+ (UIFont *)customFontFromFont:(UIFont *)font {
	return [self customFontFromFont:font type:nil andFontFamily:nil];
}

+ (UIFont *)customFontFromFont:(UIFont *)font type:(NSString *)type andFontFamily:(NSString *)fontFamily {
	if(!font) return nil;
	
	NSDictionary *fontMap = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FontMap" ofType:@"plist"]];
	
	if(!fontMap && !fontFamily) return font;
	
	if(!type){
		if([font.fontName hasSuffix:@"-Bold"]) type=@"-Bold";
		else if([font.fontName hasSuffix:@"-BoldItalic"]) type=@"-BoldItalic";
		else if([font.fontName hasSuffix:@"-ExtraBold"]) type=@"-ExtraBold";
		else if([font.fontName hasSuffix:@"-ExtraBoldItalic"]) type=@"-ExtraBoldItalic";
		else if([font.fontName hasSuffix:@"-Light"]) type=@"-Light";
		else if([font.fontName hasSuffix:@"-LightItalic"]) type=@"-LightItalic";
		else if([font.fontName hasSuffix:@"-ExtraLight"]) type=@"-ExtraLight";
		else if([font.fontName hasSuffix:@"-ExtraLightItalic"]) type=@"-ExtraLightItalic";
		else if([font.fontName hasSuffix:@"-Medium"]) type=@"-Medium";
		else if([font.fontName hasSuffix:@"-MediumItalic"]) type=@"-MediumItalic";
		else if([font.fontName hasSuffix:@"-SemiBold"]) type=@"-SemiBold";
		else if([font.fontName hasSuffix:@"-SemiBoldItalic"]) type=@"-SemiBoldItalic";
		else if([font.fontName hasSuffix:@"-Thin"]) type=@"-Thin";
		else if([font.fontName hasSuffix:@"-ThinItalic"]) type=@"-ThinItalic";
		else if([font.fontName hasSuffix:@"-Italic"]) type=@"-Italic";
		else type=@"-Regular";
	}else if(![type hasPrefix:@"-"]){
		type = [@"-" stringByAppendingString:type];
	}
	
	if(!fontFamily) fontFamily = [fontMap objectForKey:font.familyName];
	
	if(!fontFamily) return font;
	
	UIFont *newFont = [UIFont fontWithName:[fontFamily stringByAppendingString:type] size:[font pointSize]];
	
	return newFont;
}

@end
