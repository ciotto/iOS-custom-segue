//
//  BCNavigationController.h
//  BCTool
//
//  Created by Christian Bianciotto on 22/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//

#import "BCViewController.h"

@interface BCNavigationController : UINavigationController <BCViewControllerProtocol, UINavigationBarDelegate>

@property (assign, nonatomic) BOOL stopReverseAllSegue;

@property (strong, nonatomic) Class presentedSegue;

#ifdef DEBUG
@property (strong, nonatomic) NSMutableArray *lifecycleCallStack;
#endif

@end
