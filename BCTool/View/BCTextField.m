//
//  IMTextField.m
//  IsiMobi
//
//  Created by Christian Bianciotto on 07/03/14.
//  Copyright (c) 2014 Elipse srl. All rights reserved.
//

#import "BCTextField.h"

#import "BCUtilities.h"

@implementation BCTextField

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		[self setFont:[BCUtilities customFontFromFont:self.font type:self.type andFontFamily:self.fontFamily]];
	}
	return self;
}

@end
