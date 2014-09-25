//
//  BCTableViewController.h
//  BCTool
//
//  Created by Christian Bianciotto on 16/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//

#import "BCViewController.h"

@interface BCTableViewController : UITableViewController <BCViewControllerProtocol>

@property (assign, nonatomic) BOOL stopReverseAllSegue;

@property (strong, nonatomic) Class presentedSegue;

#ifdef DEBUG
@property (strong, nonatomic) NSMutableArray *lifecycleCallStack;
#endif

@end
