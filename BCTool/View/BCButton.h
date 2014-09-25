//
//  IMButton.h
//  IsiMobi
//
//  Created by Christian Bianciotto on 07/03/14.
//  Copyright (c) 2014 Elipse srl. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TITLE_LABEL_OFFSET -2

@interface BCButton : UIButton

// The font type, if nil use the original type
@property (strong, nonatomic) NSString *type;

// The font-family, if nil use FontMap.plist
@property (strong, nonatomic) NSString *fontFamily;

@end
