//
//  VocabularyViewController.h
//  Wordee
//
//  Created by Artur Wiśniewski on 25/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordCell.h"
#import "WordsList.h"
#import <Realm/Realm.h>
#import "AddViewController.h"

@interface VocabularyViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, AddViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *addNewButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) WordsList* parentVocabularyList;
@property (atomic, retain) RLMRealm *realm;


@end
