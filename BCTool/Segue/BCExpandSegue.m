//
//  BCExpandSegue.m
//  BCTool
//
//  Created by Christian Bianciotto on 13/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//
//  This segue is derived by http://blog.dadabeatnik.com/2013/10/13/custom-segues/

#import "BCExpandSegue.h"

@implementation BCExpandSegue

#pragma mark UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
	UIViewController *src = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *front = self.sourceViewController;
	UIViewController *dst = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
 
	if(!self.reverse){
		UIView *containerView = [transitionContext containerView];
		if(src.navigationController) containerView.backgroundColor = [UIColor blackColor];
		[containerView addSubview:dst.view];
		
		dst.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
		
		CGPoint originalCenter = dst.view.center;
		dst.view.center = self.originatingPoint;
		
		[UIView animateWithDuration:self.transitionDuration
							  delay:0
			 usingSpringWithDamping:0.6
			  initialSpringVelocity:8
							options:UIViewAnimationOptionCurveEaseIn
						 animations:^{
							 dst.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
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
			UIView *containerView = [transitionContext containerView];
			[containerView addSubview:front.view];
			
			src.view.alpha = 0;
		}
		
		[UIView animateWithDuration:self.transitionDuration
							  delay:0.0
			 usingSpringWithDamping:0.6
			  initialSpringVelocity:8
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^{
							 front.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
							 front.view.center = self.originatingPoint;
						 }
						 completion:^(BOOL finished) {
							 [dstSuperview addSubview:dst.view];
							 [transitionContext completeTransition:finished];
						 }];
	}
}

@end
