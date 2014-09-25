//
//  BCSegue.m
//  BCTool
//
//  Created by Christian Bianciotto on 12/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//

#import "BCBaseSegue.h"

#import "BCGlobals.h"
#import "BCViewController.h"

@implementation BCBaseSegue

- (id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination {
	if((self=[super initWithIdentifier:identifier source:source destination:destination])){
		_transitionDuration = TRANSITION_DURATION;
	}
	
	return self;
}

- (void)perform {
	UIViewController *src = self.sourceViewController;
	UIViewController *dst = self.destinationViewController;
	
	if(self.class == BCBaseSegue.class){
		if(!self.reverse){
			if([src respondsToSelector:@selector(presentedSegue)]) ((BCViewController *) src).presentedSegue = self.class;
			
			if(self.isNavigation){
				[src.navigationController pushViewController:dst animated:YES];
			}else{
				[src presentViewController:dst animated:YES completion:nil]; // present VC
			}
		}else{
			if(self.isNavigation){
				[dst.navigationController popToViewController:dst animated:YES];
			}else{
				[dst dismissViewControllerAnimated:YES completion:nil];
			}
		}
	}else{
		if(!self.reverse){
			if(self.isNavigation && [src respondsToSelector:@selector(presentedSegue)]) ((BCViewController *) src).presentedSegue = self.class;
			else if(src.parentViewController && [src.parentViewController respondsToSelector:@selector(presentedSegue)]) ((BCViewController *) src.parentViewController).presentedSegue = self.class;
			else if([src respondsToSelector:@selector(presentedSegue)]) ((BCViewController *) src).presentedSegue = self.class;
			
			if(self.isNavigation){
				src.navigationController.delegate = self;

				[src.navigationController pushViewController:dst animated:YES];
			}else{
				dst.modalPresentationStyle = UIModalPresentationCustom;
				dst.transitioningDelegate = self;
				
				[self beginAppearanceTransition];
				[src presentViewController:dst animated:YES completion:^{
					[self endAppearanceTransition];
				}]; // present VC
			}
		}else{
			if(self.isNavigation){
				dst.navigationController.delegate = self;
				
				[dst.navigationController popToViewController:dst animated:YES];
			}else{
				UIViewController *temp = src;
				while (temp.presentingViewController != dst) {
					temp = temp.presentingViewController;
					temp.transitioningDelegate = self;
				}
				
				src.modalPresentationStyle = UIModalPresentationCustom;
				src.transitioningDelegate = self;
				
				[self beginAppearanceTransition];
				[dst dismissViewControllerAnimated:YES completion:^{
					[self endAppearanceTransition];
				}];
			}
		}
	}
}

- (void)beginAppearanceTransition {
	UIViewController *src = self.sourceViewController;
	UIViewController *dst = self.destinationViewController;

	UIViewController *temp = src;
	while (temp.parentViewController) {
		temp = temp.parentViewController;
	}
	
	[temp beginAppearanceTransition:NO animated:self.transitionDuration];
	[dst beginAppearanceTransition:YES animated:self.transitionDuration];
}

- (void)endAppearanceTransition {
	UIViewController *src = self.sourceViewController;
	UIViewController *dst = self.destinationViewController;
	
	UIViewController *temp = src;
	while (temp.parentViewController) {
		temp = temp.parentViewController;
	}
	
	[temp endAppearanceTransition];
	[dst endAppearanceTransition];
	
	if([dst respondsToSelector:@selector(presentedSegue)]) ((BCViewController *) dst).presentedSegue = nil;
}

- (void)dealloc {
	//UIViewController *src = self.sourceViewController;
	UIViewController *dst = self.destinationViewController;
	
	if(dst.navigationController.delegate == self) dst.navigationController.delegate = nil;
	if(dst.transitioningDelegate == self) dst.transitioningDelegate = nil;
}


#pragma mark UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
																  presentingController:(UIViewController *)presenting
																	  sourceController:(UIViewController *)source {
	return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
	return self;
}


#pragma mark UINavigationControllerDelegate

//- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//						  interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController {
//		return self;
//}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
								   animationControllerForOperation:(UINavigationControllerOperation)operation
												fromViewController:(UIViewController *)fromVC
												  toViewController:(UIViewController *)toVC {
	return self;
}


#pragma mark UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
	return self.transitionDuration;
}

- (void)animationEnded:(BOOL)transitionCompleted {
	
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

}


#pragma mark Other

- (void)setType:(BCBaseSegueType)type {
	UIViewController *src = self.sourceViewController;
	
	NSUInteger styleCount = 0;
	if(type & BCBaseSegueTypeModal) styleCount++;
	if(type & BCBaseSegueTypeNavigation) styleCount++;
	if(type & BCBaseSegueTypeInContainer) styleCount++;
	
	if(styleCount > 1){
		NSLog(@"Only one style can be set");
		return;
	}else if(type & BCBaseSegueTypeNavigation && !src.navigationController){
		NSLog(@"BCBaseSegueTypeNavigation must have navigation controller");
		return;
	}else if(type & BCBaseSegueTypeInContainer && !src.parentViewController){
		NSLog(@"BCBaseSegueTypeNavigation must have parent controller");
		return;
	}
	
	// Not implemented
	if(type & BCBaseSegueTypeInContainer){
		NSLog(@"BCBaseSegueTypeInContainer not implemented");
		return;
	}else if(type & BCBaseSegueTypeNotRemoveSrc){
		NSLog(@"BCBaseSegueTypeNotRemoveSrc not implemented");
		return;
	}
	
	_type = type;
}

- (BOOL)isAuto {
	return !(self.type & BCBaseSegueTypeModal) && !(self.type & BCBaseSegueTypeNavigation) && !(self.type & BCBaseSegueTypeInContainer);
}

- (BOOL)isModal {
	UIViewController *src = self.sourceViewController;
	
	if(self.isAuto){
		if(!src.navigationController) return YES;
	}else if(self.type & BCBaseSegueTypeModal) return YES;
	
	return NO;
}

- (BOOL)isNavigation {
	UIViewController *src = self.sourceViewController;
	
	if(self.isAuto){
		if(src.navigationController) return YES;
	}else if(self.type & BCBaseSegueTypeNavigation) return YES;
	
	return NO;
}

- (BOOL)isInContainer {
	if(self.type & BCBaseSegueTypeInContainer) return YES;
	
	return NO;
}

@end
