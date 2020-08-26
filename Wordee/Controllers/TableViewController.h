//
//  ViewController.h
//  Wordee
//
//  Created by Artur Wiśniewski on 20/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VocabularyViewController.h"
#import "LanguagesViewController.h"
#import "ListNameCell.h"
#import "WordsList.h"

@interface TableViewController : UITableViewController <UISearchBarDelegate, LanguagesViewControllerDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) RLMResults<WordsList *>  *wordsLists;
@property (atomic, retain) RLMRealm *realm;

@end

