//
//  IMButton.m
//  IsiMobi
//
//  Created by Christian Bianciotto on 07/03/14.
//  Copyright (c) 2014 Elipse srl. All rights reserved.
//

#import "BCButton.h"

#import "BCUtilities.h"

@implementation BCButton

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		[self.titleLabel setFont:[BCUtilities customFontFromFont:self.titleLabel.font type:self.type andFontFamily:self.fontFamily]];
	}
	return self;
}

@end
