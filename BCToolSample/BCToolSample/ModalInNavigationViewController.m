//
//  ModalInNavigationViewController.m
//  BCToolSample
//
//  Created by Christian Bianciotto on 02/10/14.
//  Copyright (c) 2014 bitCircle. All rights reserved.
//

#import "ModalInNavigationViewController.h"

#import "BCBaseSegue.h"

@interface ModalInNavigationViewController ()

@end

@implementation ModalInNavigationViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if([segue respondsToSelector:@selector(setType:)]){
		((BCBaseSegue *) segue).type = BCBaseSegueTypeModal;
	}
}

@end
