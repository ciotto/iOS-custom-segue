
//
//  BCViewController.m
//  BCTool
//
//  Created by Christian Bianciotto on 12/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//

#import "BCViewController.h"

#import "BCBaseSegue.h"

@interface BCViewController ()

@end

@implementation BCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[BCViewController viewControllerViewDidLoad:self];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[BCViewController viewController:self viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[BCViewController viewController:self viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[BCViewController viewController:self viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
	[BCViewController viewController:self viewDidDisappear:animated];
}

- (void)dealloc {
	[BCViewController viewControllerDealloc:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
	[BCViewController viewControllerDidReceiveMemoryWarning:self];
}

#pragma mark Segue


- (IBAction)reverseSegue:(UIStoryboardSegue *)sender {
}

- (IBAction)reverseAllSegue:(UIStoryboardSegue *)sender {
}

- (void)reverseSegueAnimated:(BOOL)animated {
	[BCViewController viewController:self reverseSegueForUnwindSegueAction:@selector(reverseSegue:) animated:animated];
}

- (void)reverseAllSegueAnimated:(BOOL)animated {
	[BCViewController viewController:self reverseSegueForUnwindSegueAction:@selector(reverseAllSegue:) animated:animated];
}

// We need to implement this method using the uquivalent static method from
// BCViewController to provide correct view controller for unwinding
- (UIViewController *)viewControllerForUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender {
	return [BCViewController viewController:self viewControllerForUnwindSegueAction:action fromViewController:fromViewController withSender:sender];
}

// We need to implement this method using the uquivalent static method from
// BCViewController to provide a custom segue for unwinding
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
	return [BCViewController viewController:self segueForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];
}


#pragma mark Static

+ (UIViewController *)viewController:(UIViewController<BCViewControllerProtocol> *)target viewControllerForUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender {
	// If pop from navigation controller
	if(target == (UIViewController<BCViewControllerProtocol> *)fromViewController.navigationController){
		NSArray *viewControllers = fromViewController.navigationController.viewControllers;
		
		// If reverseAll == YES, find new fromViewController
		if(action == @selector(reverseAllSegue:)){
			UIViewController *temp = nil;
			
			NSInteger index = viewControllers.count-2;
			while (index >= 0) {
				temp = [viewControllers objectAtIndex:index];
				if([temp respondsToSelector:@selector(stopReverseAllSegue)] && ((BCViewController *) temp).stopReverseAllSegue) break;
				index--;
			}
			
			return temp;
		}
		
		return [viewControllers objectAtIndex:viewControllers.count-2];
	// If dismiss view controller
	}else{
		// If reverseAll == YES, find new fromViewController
		if(action == @selector(reverseAllSegue:)){
			UIViewController *temp = fromViewController;
			
			temp.transitioningDelegate = nil;
			
			while (temp.presentingViewController!=nil) {
				temp = temp.presentingViewController;
				
				if([temp respondsToSelector:@selector(stopReverseAllSegue)] && ((BCViewController *) temp).stopReverseAllSegue) break;
			}
			
			return temp;
		}
	}
	
	return target;
}

+ (UIStoryboardSegue *)viewController:(UIViewController *)target segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
	id segue;
	
	// If forward segue class was saved in presentedSegue or if presentedSegue
	// was manually setted, instantiate and return this class
	if([toViewController respondsToSelector:@selector(presentedSegue)] && ((BCViewController *) toViewController).presentedSegue){
		segue = [[((BCViewController *) toViewController).presentedSegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
	// Instantiate custom reverse segue otherwise
	}else{
		segue = [[BCBaseSegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
	}
	
	// Set as reverse segue
	if([segue respondsToSelector:@selector(setReverse:)]) [((BCBaseSegue *) segue) setReverse:YES];
	
	return segue;
}

+ (void)viewController:(UIViewController *)target reverseSegueForUnwindSegueAction:(SEL)action animated:(BOOL)animated {
	UIViewController *unwindViewController = nil;
	
	if(target.navigationController) unwindViewController = target.navigationController;
	else unwindViewController = target.presentingViewController;
	
	if(unwindViewController){
		UIViewController *toViewController = [unwindViewController viewControllerForUnwindSegueAction:action fromViewController:target withSender:nil];
		
		UIStoryboardSegue *segue = [toViewController segueForUnwindingToViewController:toViewController fromViewController:target identifier:nil];
		
		if(!animated && [segue respondsToSelector:@selector(setTransitionDuration:)]) [((BCBaseSegue *) segue) setTransitionDuration:0];
		
		[segue perform];
	}
}

+ (void)viewControllerViewDidLoad:(UIViewController<BCViewControllerProtocol> *)target {
#ifdef DEBUG
	if(target.lifecycleCallStack) NSLog(@"%@ lifecycle error: viewDidLoad must be the first lifecycle call", target.title);
	target.lifecycleCallStack = [NSMutableArray array];
	
	[target.lifecycleCallStack addObject:@"viewDidLoad"];
#endif
}

+ (void)viewController:(UIViewController<BCViewControllerProtocol> *)target viewWillAppear:(BOOL)animated {
#ifdef DEBUG
	if(![[target.lifecycleCallStack lastObject] isEqualToString:@"viewDidLoad"] && ![[target.lifecycleCallStack lastObject] isEqualToString:@"viewDidDisappear:"]) NSLog(@"%@ lifecycle error: viewWillAppear: must be called after viewDidLoad or viewDidDisappear:\n%@", target.title, target.lifecycleCallStack);
	
	[target.lifecycleCallStack addObject:@"viewWillAppear:"];
#endif
}

+ (void)viewController:(UIViewController<BCViewControllerProtocol> *)target viewDidAppear:(BOOL)animated {
#ifdef DEBUG
	if(![[target.lifecycleCallStack lastObject] isEqualToString:@"viewWillAppear:"]) NSLog(@"%@ lifecycle error: viewDidAppear: must be called after viewWillAppear:\n%@", target.title, target.lifecycleCallStack);
	
	[target.lifecycleCallStack addObject:@"viewDidAppear:"];
#endif
}

+ (void)viewController:(UIViewController<BCViewControllerProtocol> *)target viewWillDisappear:(BOOL)animated {
#ifdef DEBUG
	if(![[target.lifecycleCallStack lastObject] isEqualToString:@"viewDidAppear:"] && ![[target.lifecycleCallStack lastObject] isEqualToString:@"viewDidDisappear:"]) NSLog(@"%@ lifecycle error: viewWillDisappear: must be called after viewDidAppear: or viewDidDisappear:\n%@", target.title, target.lifecycleCallStack);
	
	[target.lifecycleCallStack addObject:@"viewWillDisappear:"];
#endif
}

+ (void)viewController:(UIViewController<BCViewControllerProtocol> *)target viewDidDisappear:(BOOL)animated {
#ifdef DEBUG
	if(![[target.lifecycleCallStack lastObject] isEqualToString:@"viewWillDisappear:"]) NSLog(@"%@ lifecycle error: viewDidDisappear: must be called after viewWillDisappear:\n%@", target.title, target.lifecycleCallStack);
	
	[target.lifecycleCallStack addObject:@"viewDidDisappear:"];
#endif
}

+ (void)viewControllerDealloc:(UIViewController<BCViewControllerProtocol> *)target {
#ifdef DEBUG
	if(![[target.lifecycleCallStack lastObject] isEqualToString:@"viewDidDisappear:"]) NSLog(@"%@ lifecycle error: dealloc must be called after viewDidDisappear:\n%@", target.title, target.lifecycleCallStack);
	
	[target.lifecycleCallStack addObject:@"dealloc"];
#endif
}

+ (void)viewControllerDidReceiveMemoryWarning:(UIViewController<BCViewControllerProtocol> *)target {
	
}

@end
