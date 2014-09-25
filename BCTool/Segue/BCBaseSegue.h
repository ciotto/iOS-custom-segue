//
//  BCSegue.h
//  BCTool
//
//  Created by Christian Bianciotto on 12/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, BCBaseSegueType) {
	// If style is not set use navigation for navigation controller, modal
	// otherwise
	BCBaseSegueTypeModal = 1 << 0,
	BCBaseSegueTypeNavigation = 1 << 1,
	BCBaseSegueTypeInContainer = 1 << 2,
	
	BCBaseSegueTypeNotRemoveSrc = 1 << 3
};

@interface BCBaseSegue : UIStoryboardSegue <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate>

// If YES the animation was reversed
@property (assign, nonatomic) BOOL reverse;

// The transition duration
@property (assign, nonatomic) CGFloat transitionDuration;

// The segue options
@property (assign, nonatomic) BCBaseSegueType type;

// The segue options
@property (readonly, nonatomic) BOOL isAuto;
// The segue options
@property (readonly, nonatomic) BOOL isModal;
// The segue options
@property (readonly, nonatomic) BOOL isNavigation;
// The segue options
@property (readonly, nonatomic) BOOL isInContainer;

@end
