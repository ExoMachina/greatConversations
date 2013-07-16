//
//  GCNewConversationVC.m
//  Great Convos
//
//  Created by Alexander List on 7/15/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import "GCNewConversationVC.h"
#import <QuartzCore/QuartzCore.h>

@interface GCNewConversationVC ()

@end

@implementation GCNewConversationVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"GCNewConversationVC-iPhone" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.whoBoxView.layer.borderColor = [UIColor colorWithWhite:0.55 alpha:0.15].CGColor;
	self.whoBoxView.layer.borderWidth = 1;
	self.whoBoxView.layer.cornerRadius = 3;

	self.whatBoxView.layer.borderColor = [UIColor colorWithWhite:0.55 alpha:0.15].CGColor;
	self.whatBoxView.layer.borderWidth = 1;
	self.whatBoxView.layer.cornerRadius = 3;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
