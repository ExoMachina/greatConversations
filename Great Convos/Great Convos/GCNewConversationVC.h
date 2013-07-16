//
//  GCNewConversationVC.h
//  Great Convos
//
//  Created by Alexander List on 7/15/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteView.h"

@protocol GCNewConversationVCDelegate <NSObject>
-(void) newConversationVCWantsScrollToViewOrigin:(CGPoint)origin;
@end

@interface GCNewConversationVC : UIViewController<UITextViewDelegate>

@property (nonatomic, strong) IBOutlet UIView * whoBoxView;
@property (nonatomic, strong) IBOutlet UIView * whatBoxView;
@property (strong, nonatomic) IBOutlet UILabel *lengthRemainingLabel;

@property (strong, nonatomic) IBOutlet NoteView *whatNoteView;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *twitterTextField;

@property (nonatomic, assign) bool isCustomizedSubject;

@property (nonatomic, weak) id<GCNewConversationVCDelegate> delegate;


@end
