//
//  BCNavigationController.m
//  BCTool
//
//  Created by Christian Bianciotto on 22/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//

#import "BCNavigationController.h"

@interface BCNavigationController ()

@end

@implementation BCNavigationController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[BCViewController viewControllerViewDidLoad:self];
	
//	self.navigationBar.delegate = self;
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


#pragma mark UINavigationBarDelegate

//- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
//	if([self.topViewController respondsToSelector:@selector(reverseSegueAnimated:)]){
//		[((BCViewController *) self.topViewController) reverseSegueAnimated:YES];
//	
//		return YES;
//	}
//	
//	return YES;
//}

@end
