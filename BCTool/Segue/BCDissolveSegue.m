//
//  BCDissolveSegue.m
//  BCTool
//
//  Created by Christian Bianciotto on 15/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//

#import "BCDissolveSegue.h"

@implementation BCDissolveSegue

#pragma mark UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
	UIViewController *src = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *front = self.sourceViewController;
	UIViewController *dst = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
 
	if(!self.reverse){
		UIView *containerView = [transitionContext containerView];
		if(src.navigationController) containerView.backgroundColor = [UIColor blackColor];
		[containerView addSubview:dst.view];
		
		dst.view.alpha = 0;
		
		[UIView animateWithDuration:self.transitionDuration
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^{
							 dst.view.alpha = 1;
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
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^{
							 front.view.alpha = 0;
						 }
						 completion:^(BOOL finished) {
							 [dstSuperview addSubview:dst.view];
							 [transitionContext completeTransition:finished];
						 }];
	}
}

@end
