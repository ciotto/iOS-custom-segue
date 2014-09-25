//
//  BCNavigationSegue.m
//  BCTool
//
//  Created by Christian Bianciotto on 15/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//

#import "BCNavigationSegue.h"

@implementation BCNavigationSegue

#pragma mark UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
	UIViewController *src = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *front = self.sourceViewController;
	UIViewController *dst = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
 
	if(!self.reverse){
		UIView *containerView = [transitionContext containerView];
		if(src.navigationController) containerView.backgroundColor = [UIColor blackColor];
		[containerView addSubview:dst.view];
		
		dst.view.frame = CGRectMake(src.view.frame.size.width, 0, src.view.frame.size.width, src.view.frame.size.height);
		
		[UIView animateWithDuration:self.transitionDuration
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^{
							 src.view.frame = CGRectMake(-src.view.frame.size.width, 0, src.view.frame.size.width, src.view.frame.size.height);
							 dst.view.frame = CGRectMake(0, 0, src.view.frame.size.width, src.view.frame.size.height);
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
		dst.view.frame = CGRectMake(-src.view.frame.size.width, 0, src.view.frame.size.width, src.view.frame.size.height);
		
		[UIView animateWithDuration:self.transitionDuration
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^{
							 dst.view.frame = CGRectMake(0, 0, dst.view.frame.size.width, dst.view.frame.size.height);
							 front.view.frame = CGRectMake(+dst.view.frame.size.width, 0, dst.view.frame.size.width, src.view.frame.size.height);
						 }
						 completion:^(BOOL finished) {
							 [dstSuperview addSubview:dst.view];
							 [transitionContext completeTransition:finished];
						 }];
	}
}

@end
