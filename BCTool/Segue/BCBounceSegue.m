//
//  BCBounceSegue.m
//  BCTool
//
//  Created by Christian Bianciotto on 15/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//
//  This segue is derived by http://www.appdesignvault.com/custom-transition-ios-7/

#import "BCBounceSegue.h"

#import "BCGlobals.h"

@implementation BCBounceSegue

- (id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination {
	if((self=[super initWithIdentifier:identifier source:source destination:destination])){
		self.transitionDuration = TRANSITION_DURATION * 2.0;
	}
	
	return self;
}

#pragma mark UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
	UIViewController *src = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *front = self.sourceViewController;
	UIViewController *dst = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	if(!self.reverse){
		UIView *containerView = [transitionContext containerView];
		if(src.navigationController) containerView.backgroundColor = [UIColor blackColor];
		[containerView addSubview:dst.view];
		
		CGPoint center = containerView.center;
		center.y = -dst.view.frame.size.height / 2;
		dst.view.center = center;
		
		[UIView animateWithDuration:self.transitionDuration
							  delay:0
			 usingSpringWithDamping:0.6
			  initialSpringVelocity:8
							options:UIViewAnimationOptionCurveEaseIn
						 animations:^{
							 dst.view.center = containerView.center;
						 }
						 completion:^(BOOL finished) {
							 [transitionContext completeTransition:YES];
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
		
		CGPoint center = containerView.center;
		center.y = -containerView.frame.size.height / 2;
		
		[UIView animateKeyframesWithDuration:self.transitionDuration
									   delay:0
									 options:UIViewKeyframeAnimationOptionCalculationModeLinear
								  animations:^{
									  [UIView addKeyframeWithRelativeStartTime:0
															  relativeDuration:self.transitionDuration / 2
																	animations:^{
																		CGPoint center = front.view.center;
																		center.y += 50;
																		front.view.center = center;
																	}];
									  
									  [UIView addKeyframeWithRelativeStartTime:self.transitionDuration / 2
															  relativeDuration:self.transitionDuration / 2
																	animations:^{
																		front.view.center = center;
																	}];
								  }
								  completion:^(BOOL finished) {
									  [dstSuperview addSubview:dst.view];
									  [transitionContext completeTransition:YES];
								  }];}
}

@end
