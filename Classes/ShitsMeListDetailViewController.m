//
//  ShitsMeListShitsMeListDetailViewController.m
//  TheCarlton
//
//  Created by Zuhair Naqvi on 28/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "ShitsMeListDetailViewController.h"


@implementation ShitsMeListDetailViewController

@synthesize itemDesc, itemDescText;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	itemDescText.text = itemDesc;
	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[itemDesc release];
	[itemDescText release];
    [super dealloc];
}


@end