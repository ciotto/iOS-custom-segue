//
//  BCFallSegue.m
//  BCTool
//
//  Created by Christian Bianciotto on 15/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//
//  This segue is derived by http://www.thinkandbuild.it/ios7-custom-transitions/

#import "BCFallSegue.h"

#import "BCGlobals.h"

@implementation BCFallSegue

- (id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination {
	if((self=[super initWithIdentifier:identifier source:source destination:destination])){
		self.transitionDuration = TRANSITION_DURATION * 3.0;
	}
	
	return self;
}

#pragma mark UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
	UIViewController *src = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *front = self.sourceViewController;
	UIViewController *dst = self.destinationViewController;
 
	if(!self.reverse){
		UIView *containerView = [transitionContext containerView];
		if(src.navigationController) containerView.backgroundColor = [UIColor blackColor];
		[containerView addSubview:dst.view];
		
		dst.view.transform = CGAffineTransformMakeRotation(-M_PI/2);;
		
		dst.view.layer.anchorPoint = CGPointMake(1, 0);
		dst.view.layer.position = CGPointMake(src.view.frame.size.width, 0);
		CGPoint originalCenter = dst.view.center;
		
		[UIView animateWithDuration:self.transitionDuration
							  delay:0.0
			 usingSpringWithDamping:0.6
			  initialSpringVelocity:8
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^{
							 //src.view.frame = CGRectMake(-src.view.frame.size.width, 0, src.view.frame.size.width, src.view.frame.size.height);
							 dst.view.transform = CGAffineTransformMakeRotation(0);
							 dst.view.center = originalCenter;
						 }
						 completion:^(BOOL finished) {
							 [transitionContext completeTransition:finished];
						 }];
	}else{
		UIView *containerView = [transitionContext containerView];
		if(src.navigationController) containerView.backgroundColor = [UIColor blackColor];
		UIView *dstSuperview = dst.view.superview;
		[containerView insertSubview:dst.view atIndex:0];
		
		if(front != src){
			[containerView addSubview:front.view];
			
			src.view.alpha = 0;
		}
		front.view.layer.anchorPoint = CGPointMake(1, 0);
		front.view.layer.position = CGPointMake(dst.view.frame.size.width, 0);

		[UIView animateWithDuration:self.transitionDuration
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^{
							 //dst.view.frame = CGRectMake(0, 0, dst.view.frame.size.width, dst.view.frame.size.height);
							 front.view.transform = CGAffineTransformMakeRotation(-M_PI/2);;
							 
							 front.view.layer.anchorPoint = CGPointMake(1, 0);
							 front.view.layer.position = CGPointMake(dst.view.frame.size.width, 0);
						 }
						 completion:^(BOOL finished) {
							 [dstSuperview addSubview:dst.view];
							 [transitionContext completeTransition:finished];
						 }];
	}
}

@end
