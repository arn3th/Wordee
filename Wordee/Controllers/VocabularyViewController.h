//
//  VocabularyViewController.h
//  Wordee
//
//  Created by Artur Wiśniewski on 25/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordsList.h"
#import "WordCell.h"
#import <Realm/Realm.h>

@interface VocabularyViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) NSString *vocabularyListName;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *addNewButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) WordsList* parentList;


@end
