//
//  BCViewController.h
//  BCTool
//
//  Created by Christian Bianciotto on 12/09/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BCViewControllerProtocol

// If YES, reverseAllSegue iteration was stopped and this view controller are
// used as view controller for unwinding
@property (assign, nonatomic) BOOL stopReverseAllSegue;
// Segue used for unwinding, can be set from the forward segue or manually
@property (strong, nonatomic) Class presentedSegue;

#ifdef DEBUG
// This is the stack of lifecycle call, is used in DEBUG to check correct call
// sequence
@property (strong, nonatomic) NSMutableArray *lifecycleCallStack;
#endif

// Segue

// This is the IBAction method referenced in the Storyboard Exit for the unwind
// segue. It needs to be created to add a link for the unwind segue.
- (IBAction)reverseSegue:(UIStoryboardSegue *)sender;
- (IBAction)reverseAllSegue:(UIStoryboardSegue *)sender;

- (void)reverseSegueAnimated:(BOOL)animated;
- (void)reverseAllSegueAnimated:(BOOL)animated;

// We need to implement this method using the uquivalent static method from
// BCViewController to provide correct view controller for unwinding
- (UIViewController *)viewControllerForUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender;
// We need to implement this method using the uquivalent static method from
// BCViewController to provide a custom segue for unwinding
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier;

// We need to implement this methods using the uquivalent static methods from
// BCViewController to provide lifecycle check
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)dealloc;
- (void)didReceiveMemoryWarning;

@end



@interface BCViewController : UIViewController <BCViewControllerProtocol>

@property (assign, nonatomic) BOOL stopReverseAllSegue;

@property (strong, nonatomic) Class presentedSegue;

#ifdef DEBUG
@property (strong, nonatomic) NSMutableArray *lifecycleCallStack;
#endif

@end


// This static methods must be called from uquivalent istance methods to
// implement BCViewControllerProtocol
@interface BCViewController (Static)

// Provide correct view controller for unwinding.
// Implements part of reverseAllSegue logic
+ (UIViewController *)viewController:(UIViewController<BCViewControllerProtocol> *)target viewControllerForUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender;
// Provide correct reverse segue for unwinding.
+ (UIStoryboardSegue *)viewController:(UIViewController<BCViewControllerProtocol> *)target segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier;

// Programmatically call unwind segue action
+ (void)viewController:(UIViewController *)target reverseSegueForUnwindSegueAction:(SEL)action animated:(BOOL)animated;

// On DEBUG, add the lifecycle call to stack and check correct call sequence
+ (void)viewControllerViewDidLoad:(UIViewController<BCViewControllerProtocol> *)target;
+ (void)viewController:(UIViewController<BCViewControllerProtocol> *)target viewWillAppear:(BOOL)animated;
+ (void)viewController:(UIViewController<BCViewControllerProtocol> *)target viewDidAppear:(BOOL)animated;
+ (void)viewController:(UIViewController<BCViewControllerProtocol> *)target viewWillDisappear:(BOOL)animated;
+ (void)viewController:(UIViewController<BCViewControllerProtocol> *)target viewDidDisappear:(BOOL)animated;
+ (void)viewControllerDealloc:(UIViewController<BCViewControllerProtocol> *)target;
+ (void)viewControllerDidReceiveMemoryWarning:(UIViewController<BCViewControllerProtocol> *)target;

@end
