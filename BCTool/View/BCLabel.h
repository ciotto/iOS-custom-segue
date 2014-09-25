//
//  IMLabel.h
//  IsiMobi
//
//  Created by Christian Bianciotto on 07/03/14.
//  Copyright (c) 2014 Elipse srl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCLabel : UILabel

// The font type, if nil use the original type
@property (strong, nonatomic) NSString *type;

// The font-family, if nil use FontMap.plist
@property (strong, nonatomic) NSString *fontFamily;

@end
