//
//  GCRootViewController.m
//  Great Convos
//
//  Created by Alexander List on 7/15/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import "GCRootViewController.h"

@interface GCRootViewController (){
	float originalPastConversationsDistanceFromBottom;
}
@end

const float pastConversationsDisplayedPosition = 20;

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
	if (deviceIsIPhone5){
		totalHeight = MAX(totalHeight, 550);
	}
	[self.mainContentScrollView setContentSize:CGSizeMake(320, totalHeight)];
	[self.mainContentScrollView addSubview:self.addConversationVC.view];	
	
	
//	self.pastQuestionsVC = [[GCPastQuestionsVC alloc] init];
//	[self.pastConversationsPeekView addSubview:self.pastQuestionsVC.view];
	self.pastConversationsPeekView.layer.shadowColor = UIColor.blackColor.CGColor;
	self.pastConversationsPeekView.layer.shadowOffset = CGSizeMake(0, -1);
	self.pastConversationsPeekView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.pastConversationsPeekView.bounds].CGPath;;

	
	UIPanGestureRecognizer * pastConversationsPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pastConversationsPanGestureRecognizerDidPan:)];
	[self.pastConversationsPeekView addGestureRecognizer:pastConversationsPanGestureRecognizer];
	UITapGestureRecognizer * pastConversationsTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pastConversationsTapRecognizerDidTap:)];
	[self.pastConversationsPeekView addGestureRecognizer:pastConversationsTapRecognizer];
	
	
	//let's KVC for peak view, so we can set shadow radius based on origin
	[self.pastConversationsPeekView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];
	
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
	if (originalPastConversationsDistanceFromBottom == 0){
		originalPastConversationsDistanceFromBottom = self.view.height - self.pastConversationsPeekView.origin.y;
	}

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


-(void) pastConversationsPanGestureRecognizerDidPan:(UIPanGestureRecognizer*)panRecognizer{
	
	
	static CGFloat _firstXPastConversations;
	static CGFloat _firstYPastConversations;
	
	CGPoint translatedPoint = [(UIPanGestureRecognizer*)panRecognizer translationInView:self.view];
	
    if([(UIPanGestureRecognizer*)panRecognizer state] == UIGestureRecognizerStateBegan) {
		
        _firstXPastConversations = [[panRecognizer view] origin].x;
        _firstYPastConversations = [[panRecognizer view] origin].y;
		
    }
	
	translatedPoint = CGPointMake(_firstXPastConversations, _firstYPastConversations+translatedPoint.y);
	if(translatedPoint.y < pastConversationsDisplayedPosition) {
		translatedPoint.y = pastConversationsDisplayedPosition;
	}
	
	
    [[panRecognizer view] setOrigin:translatedPoint];
	
    if([(UIPanGestureRecognizer*)panRecognizer state] == UIGestureRecognizerStateEnded) {
        CGFloat velocityY = (0.2*[(UIPanGestureRecognizer*)panRecognizer velocityInView:self.view].y);
		
        CGFloat finalX = _firstXPastConversations;
        CGFloat finalY = translatedPoint.y + velocityY;
        if(finalY < _firstYPastConversations) {
			finalY = pastConversationsDisplayedPosition;
        }
        else if(finalY > _firstYPastConversations) {
			finalY = [self peekViewRestingYLocation];
        }
		
        CGFloat animationDuration = (ABS(velocityY)*.0002)+.2;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidFinish)];
        [[panRecognizer view] setOrigin:CGPointMake(finalX, finalY)];
        [UIView commitAnimations];
    }
	
	[self updatePastConversationsViewForScrollState];
}

-(void) updatePastConversationsViewForScrollState{
	if ([self pastConversationsIsDisplayed]){
		
	}else{
		self.pastConversationsPeekView.layer.shadowOpacity = 0;
	}
}

-(float) peekViewRestingYLocation{
	float finalY = self.view.height - originalPastConversationsDistanceFromBottom;
	
	if (UIDeviceOrientationIsLandscape( [UIApplication sharedApplication].statusBarOrientation)){
		finalY = 320 - originalPastConversationsDistanceFromBottom - 20;
	}
	return finalY;
}

-(void) setpastConversationsPeekViewDisplayed:(BOOL)display{
	CGFloat finalY = 0;
	CGFloat finalX = self.pastConversationsPeekView.origin.x;
	if(display) {
		finalY = pastConversationsDisplayedPosition;
	}
	else {
		finalY = [self peekViewRestingYLocation];
	}
	
	CGFloat animationDuration = .2+.2;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:animationDuration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidFinish)];
	[self.pastConversationsPeekView setOrigin:CGPointMake(finalX, finalY)];
	[UIView commitAnimations];
	[self updatePastConversationsViewForScrollState];
}

-(BOOL) pastConversationsIsDisplayed{
	return (self.pastConversationsPeekView.origin.y != [self peekViewRestingYLocation]);
}

-(void) pastConversationsTapRecognizerDidTap:(UITapGestureRecognizer*)tapGesture{
	if ([tapGesture locationInView:self.pastConversationsPeekView].y > 50)
		return;
	
	if (tapGesture.state == UIGestureRecognizerStateRecognized){
		if ([self pastConversationsIsDisplayed]){
			[self setpastConversationsPeekViewDisplayed:FALSE];
		}else{
			[self setpastConversationsPeekViewDisplayed:TRUE];
		}
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"frame"]) {
		float shadowRadius = ceilf((originalPastConversationsDistanceFromBottom - self.pastConversationsPeekView.origin.y)/22 );
		[self.pastConversationsPeekView.layer setShadowRadius:shadowRadius];
		self.pastConversationsPeekView.layer.shadowOpacity = MAX(shadowRadius/60.0f,0.2f);
		
    }
}

-(void) dealloc{
	[self removeObserver:self forKeyPath:@"frame"];
}



@end
