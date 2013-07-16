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

@interface GCRootViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet MGScrollView * mainContentScrollView;

@property (nonatomic, strong) GCNewConversationVC * addConversationVC;

@end
