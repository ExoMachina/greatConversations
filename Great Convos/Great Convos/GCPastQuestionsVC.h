//
//  GCPastQuestionsVC.h
//  Great Convos
//
//  Created by Alexander List on 7/19/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NITableViewModel.h"
#import "Conversation.h"

@interface GCPastQuestionsVC : UIViewController <NITableViewModelDelegate, UITableViewDelegate,NSFetchedResultsControllerDelegate >
@property (nonatomic, strong) NSArray *			displayedObjects;
@property (nonatomic, strong) NITableViewModel*	tvModel;
@property (nonatomic, strong) IBOutlet UITableView * tableView;

@end
