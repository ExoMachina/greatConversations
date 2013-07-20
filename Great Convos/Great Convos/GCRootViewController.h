//
//  GCRootViewController.h
//  Great Convos
//
//  Created by Alexander List on 7/15/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGScrollView.h"
#import "GCNewConversationVC.h"
#import "GCPastQuestionsVC.h"

@interface GCRootViewController : UIViewController <UIScrollViewDelegate, GCNewConversationVCDelegate>

@property (nonatomic, strong) IBOutlet MGScrollView * mainContentScrollView;
@property (strong, nonatomic) IBOutlet UIView *pastConversationsPeekView;
@property (strong, nonatomic) GCPastQuestionsVC * pastQuestionsVC;


@property (nonatomic, strong) GCNewConversationVC * addConversationVC;


@end
