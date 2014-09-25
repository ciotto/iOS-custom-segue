//
//  BC3DModalSegue.m
//  BCTool
//
//  Created by Christian Bianciotto on 15/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//

#import "BC3dSegue.h"

#import "BCGlobals.h"

@implementation BC3dSegue

- (id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination {
	if((self=[super initWithIdentifier:identifier source:source destination:destination])){
		self.transitionDuration = TRANSITION_DURATION * 5.0;
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
		
		UIView *blackView = [[UIView alloc] initWithFrame:containerView.bounds];
		blackView.backgroundColor = [UIColor blackColor];
		blackView.alpha = 0;
		[containerView addSubview:blackView];
		
		[containerView addSubview:dst.view];

		CGPoint dstCenter = containerView.center;
		dstCenter.y = dst.view.frame.size.height / 2 * 3;
		dst.view.center = dstCenter;
		
		CGPoint srcCenter = containerView.center;
		srcCenter.y -= 10;
		
		[UIView animateWithDuration:self.transitionDuration / 4.0
							  delay:0
							options:UIViewAnimationOptionCurveEaseIn
						 animations:^{
							 src.view.transform = CGAffineTransformMakeScale(0.92, 0.92);
							 src.view.center = srcCenter;
							 blackView.alpha = 0.5;
						 }
						 completion:nil];
		
		[UIView animateWithDuration:self.transitionDuration / 5.0 * 4.0
							  delay:self.transitionDuration / 5.0
			 usingSpringWithDamping:0.5
			  initialSpringVelocity:6
							options:UIViewAnimationOptionCurveEaseIn
						 animations:^{
							 dst.view.center = containerView.center;
						 }
						 completion:^(BOOL finished) {
							 src.view.transform = CGAffineTransformMakeScale(1, 1);
							 src.view.center = containerView.center;
							 [blackView removeFromSuperview];
							 [transitionContext completeTransition:YES];
						 }];
	}else{
		UIView *containerView = [transitionContext containerView];
		if(src.navigationController) containerView.backgroundColor = [UIColor blackColor];
		UIView *dstSuperview = dst.view.superview;
		[containerView insertSubview:dst.view atIndex:0];
		
		UIView *blackView = [[UIView alloc] initWithFrame:containerView.bounds];
		blackView.backgroundColor = [UIColor blackColor];
		blackView.alpha = 0.5;
		[containerView insertSubview:blackView atIndex:1];
		
		if(front != src){
			[containerView addSubview:front.view];
			
			src.view.alpha = 0;
		}
		
		CGPoint srcCenter = containerView.center;
		srcCenter.y = front.view.frame.size.height / 2 * 3;
		
		CGPoint dstCenter = containerView.center;
		dstCenter.y -= 10;
		dst.view.transform = CGAffineTransformMakeScale(0.92, 0.92);
		dst.view.center = dstCenter;
		
		[UIView animateWithDuration:self.transitionDuration / 4.0
							  delay:self.transitionDuration / 2.0
							options:UIViewAnimationOptionCurveEaseIn
						 animations:^{
							 dst.view.transform = CGAffineTransformMakeScale(1, 1);
							 dst.view.center = containerView.center;
							 blackView.alpha = 0;
						 }
						 completion:nil];
		
		[UIView animateKeyframesWithDuration:self.transitionDuration / 5.0 * 4.0
									   delay:0
									 options:UIViewKeyframeAnimationOptionCalculationModeLinear
								  animations:^{
									  [UIView addKeyframeWithRelativeStartTime:0
															  relativeDuration:self.transitionDuration / 5.0 * 2.0
																	animations:^{
																		CGPoint center = front.view.center;
																		center.y -= 50;
																		front.view.center = center;
																	}];
									  
									  [UIView addKeyframeWithRelativeStartTime:self.transitionDuration / 5 * 1
															  relativeDuration:self.transitionDuration / 5.0 * 2.0
																	animations:^{
																		front.view.center = srcCenter;
																	}];
								  }
								  completion:^(BOOL finished) {
									  [dstSuperview addSubview:dst.view];
									  [blackView removeFromSuperview];
									  [transitionContext completeTransition:YES];
								  }];
	}
}

@end
