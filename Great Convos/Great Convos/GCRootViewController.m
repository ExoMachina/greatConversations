//
//  GCRootViewController.m
//  Great Convos
//
//  Created by Alexander List on 7/15/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import "GCRootViewController.h"

@interface GCRootViewController ()

@end

@implementation GCRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"GCRootViewController-iPhone" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"patternsquare_green.png"]]];
	
	
	[self.mainContentScrollView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
	[self.mainContentScrollView setDelegate:self];

	self.addConversationVC = [[GCNewConversationVC alloc] initWithNibName:nil bundle:nil];
	[self.addConversationVC setDelegate:self];
	self.addConversationVC.view.layer.shadowColor = UIColor.blackColor.CGColor;
	self.addConversationVC.view.layer.shadowOffset = CGSizeMake(0, 1);
	self.addConversationVC.view.layer.shadowOpacity = 0.2;
	self.addConversationVC.view.layer.shadowRadius = 2;
	self.addConversationVC.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.addConversationVC.view.bounds].CGPath;;
	
	CGFloat totalHeight =  self.addConversationVC.view.height;
	[self.mainContentScrollView setContentSize:CGSizeMake(320, totalHeight)];
	[self.mainContentScrollView addSubview:self.addConversationVC.view];

	
}
-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	[[[UIResponder new] currentFirstResponder] resignFirstResponder];
}

-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}


-(void) newConversationVCWantsScrollToViewOrigin:(CGPoint)origin{
	[self.mainContentScrollView setContentOffset:origin animated:TRUE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
