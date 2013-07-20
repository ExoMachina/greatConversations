//
//  GCNewConversationVC.m
//  Great Convos
//
//  Created by Alexander List on 7/15/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import "GCNewConversationVC.h"
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import "Conversation.h"

#import "GCConversationCell.h"

@interface GCNewConversationVC ()
-(void)updateCharactersRemaining;
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

	self.whatNoteView.delegate = self;
	
	[self updateSubjectWhatFieldWithPartnerInfo];
	
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
    // to update NoteView
    [self.whatNoteView setNeedsDisplay];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nameFieldBeganEditing:(id)sender {
	[self.delegate newConversationVCWantsScrollToViewOrigin:CGPointMake(0, 57)];
}
- (IBAction)nameFieldChanged:(id)sender {
	[self updateSubjectWhatFieldWithPartnerInfo];
}
- (IBAction)twitterFieldBeganEditing:(id)sender {
	[self.delegate newConversationVCWantsScrollToViewOrigin:CGPointMake(0, 57)];
}
- (IBAction)twitterFieldChanged:(id)sender {
	NSString * handle = self.twitterTextField.text ;
	if ([handle length] >0){
		if ([[handle substringToIndex:1] isEqualToString:@"@"] == FALSE){
			NSString * modifiedHandel = [@"@" stringByAppendingString:handle];
			[self.twitterTextField setText:modifiedHandel];
		}
	}
	
	[self updateSubjectWhatFieldWithPartnerInfo];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
	[self.delegate newConversationVCWantsScrollToViewOrigin:CGPointMake(0, 149)];
}

-(void)textViewDidChange:(UITextView *)textView{
	self.isCustomizedSubject =  TRUE;
	[self updateCharactersRemaining];
}

-(void) updateSubjectWhatFieldWithPartnerInfo{
	if (self.isCustomizedSubject == TRUE)
		return;
	
	NSString * partnerName = @"someone";
	if ([self.twitterTextField.text length] >0){
		partnerName = self.twitterTextField.text;
	}
	else if ([self.nameTextField.text length] >0){
		partnerName = self.nameTextField.text;
	}
	
	NSString * subjectString = [NSString stringWithFormat:@"#greatconversation with %@ about ", partnerName];
	[self.whatNoteView setText:subjectString];
	
	[self updateCharactersRemaining];
}

-(void)updateCharactersRemaining{
	NSString * subject = self.whatNoteView.text;
	NSInteger length = [subject length];
	
	NSInteger lengthRemaining = 140 - length;
	
	[self.lengthRemainingLabel setText:[NSString stringWithFormat:@"%i",lengthRemaining]];	
}

- (IBAction)saveConvoPressed:(id)sender {
	
	Conversation * newConversation = [Conversation createEntity];
	[newConversation setPartnerName:self.nameTextField.text];
	[newConversation setPartnerTwitter:self.twitterTextField.text];
	[newConversation setSubject:self.whatNoteView.text];
	
	[[newConversation managedObjectContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
		
	}];
	
	void (^makeTwitterHappen)(void)  = ^{
		if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter] == YES){
			SLComposeViewController * twitterComposer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
			NSString * twitterInitalText = newConversation.subject;
			[twitterComposer setInitialText:twitterInitalText];
			[self presentViewController:twitterComposer animated:TRUE completion:NULL];
		}
	};

	[self doThatNewConversationCrazyAnimationWithConversation:newConversation completion:makeTwitterHappen];

}

-(void) doThatNewConversationCrazyAnimationWithConversation:(Conversation*)conversation completion:(void (^)(void))completion{
	GCConversationCell * newCell = [[GCConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	[newCell shouldUpdateCellWithObject:conversation];
	[newCell setOrigin:CGPointMake(5, 100)];
//	newCell.layer.borderColor = [UIColor colorWithWhite:0.55 alpha:0.15].CGColor;
//	newCell.layer.borderWidth = 1;
//	newCell.layer.cornerRadius = 0;
//	newCell.layer.shadowColor = UIColor.blackColor.CGColor;
//	newCell.layer.shadowOffset = CGSizeMake(0, 1);
//	newCell.layer.shadowOpacity = 0.2;
//	newCell.layer.shadowRadius = 2;
//	newCell.layer.shadowPath = [UIBezierPath bezierPathWithRect:newCell.bounds].CGPath;
	
	[self.view addSubview:newCell];
	
	newCell.alpha = .7;
	CATransform3D transform = CATransform3DMakeScale(2, 2, 1);
	transform = CATransform3DRotate(transform, -10.0/360.0 * 2.0* M_PI, 0, 0, 1);
	
	newCell.layer.transform = transform;
	
	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowAnimatedContent animations:^{
		newCell.alpha = 1;
		CATransform3D transform = CATransform3DMakeScale(1, 1, 1);
		transform = CATransform3DRotate(transform, -5.0/360.0 * 2.0* M_PI, 0, 0, 1);
		
		newCell.layer.transform = transform;
	} completion:^(BOOL finished) {
		completion();
	}];

	//completion
	/*^(BOOL finished) {
	 [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowAnimatedContent animations:^{
	 
	 CATransform3D transform = CATransform3DMakeScale(.3, .3, 1);
	 transform = CATransform3DRotate(transform, -350.0/360.0 * 2.0* M_PI, 0, 0, 1);
	 
	 newCell.layer.transform = transform;
	 
	 
	 newCell.origin = CGPointMake( roundf(self.view.width * 0.55f), self.view.height + 1);
	 } completion:NULL];
	 }*/

}

@end
