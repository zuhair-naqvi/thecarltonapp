//
//  Overlay.m
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 28/11/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "Overlay.h"


@implementation Overlay


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //clear the background color of the overlay
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
		
        //load an image to show in the overlay
        UIImage *logo = [UIImage imageNamed:@"logogreen.png"];
        UIImageView *logoView = [[UIImageView alloc]
									 initWithImage:logo];
        logoView.frame = CGRectMake(95, 340, 137, 66);
        [self addSubview:logoView];
        [logoView release];
		
        //add a simple button to the overview
        //with no functionality at the moment
//        UIButton *button = [UIButton
//                            buttonWithType:UIButtonTypeRoundedRect];
//        [button setTitle:@"Scan Now" forState:UIControlStateNormal];
//        button.frame = CGRectMake(0, 430, 320, 40);
//        [self addSubview:button];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
