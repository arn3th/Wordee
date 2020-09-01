//
//  ViewController.m
//  Wordee
//
//  Created by Artur Wiśniewski on 20/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
    
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(!self.realm){
        self.realm = [RLMRealm defaultRealm];
    }
    NSLog(@"%@", self.realm.configuration.fileURL);
    [self loadWordsLists];
    
    
    UINavigationBarAppearance *app = [[UINavigationBarAppearance alloc] init];
    [app setBackgroundColor: [UIColor colorWithRed:0.023529 green:0.18431 blue:0.352941 alpha:1]];
    [app setLargeTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor colorWithRed:0.8902 green:0.7020 blue:0.0784 alpha:1]}];
    [self.navigationController.navigationBar setScrollEdgeAppearance: app];
    
    
    [self.tableView registerNib: [UINib nibWithNibName: @"ListNameCell" bundle: nil] forCellReuseIdentifier:@"ReusableCell"];
    
    [self.searchBar setDelegate: self];
    [self.searchBar.searchTextField.leftView setTintColor: [UIColor systemYellowColor]];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0;
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
}


/* TableViewDataSource Methods */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wordsLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReusableCell" forIndexPath:indexPath];
    
    WordsList *currentList = self.wordsLists[indexPath.row];
    
    cell.nameLabel.text = currentList.name;
    cell.downLabel.text = @"0/0";
    cell.leftImageView.image = [UIImage imageNamed: currentList.basicLanguage];
    cell.rightImageView.image = [UIImage imageNamed: currentList.learnedLanguage];
    
    return cell;
}
/* TableViewDelegate Methods */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier: @"goToVocabulary" sender: self];
    
}

/* SearchBar Methods */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.wordsLists = [self.wordsLists objectsWithPredicate: [NSPredicate predicateWithFormat: @"name CONTAINS[cd] %@", searchBar.text]];
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText length] == 0) {
        [self performSelector:@selector(hideKeyboardWithSearchBar:) withObject:searchBar afterDelay:0];
        [self loadWordsLists];
    }
}

- (void)hideKeyboardWithSearchBar:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

/* Create, Read & Delete methods */
- (void)save:(WordsList *)wordsList
{
    [self.realm transactionWithBlock:^{
        [self.realm addObject:wordsList];
    }];
    
    [self.tableView reloadData];
}

- (void)loadWordsLists
{
    self.wordsLists = [WordsList allObjects];
    [self.tableView reloadData];
}

-(void)deleteItemWithIndex:(NSInteger)row{
    [self.realm transactionWithBlock:^{
        [self.realm deleteObject:self.wordsLists[row]];
    }];
}

//-(void) addWordsList{
//        WordsList *wordsList = [[WordsList alloc] init];
//        [wordsList setName: @"Test2 test2"];
//        [wordsList setBasicLanguage: @"english"];
//        [wordsList setLearnedLanguage:@"german"];
//    [self save:wordsList];
//}


/* LanguagesVC methods */
- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier: @"goToLanguages" sender: self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier  isEqual: @"goToLanguages"]) {
        LanguagesViewController *destonationVC = segue.destinationViewController;
        destonationVC.delegate = self;
    } else if([segue.identifier  isEqual: @"goToVocabulary"]) {
        VocabularyViewController *destinationVC = segue.destinationViewController;
//        destinationVC.vocabularyListName = self.wordsLists[self.tableView.indexPathForSelectedRow.row].name;
        NSLog(@"%@", self.wordsLists[self.tableView.indexPathForSelectedRow.row].name);
        [destinationVC setParentList: self.wordsLists[self.tableView.indexPathForSelectedRow.row]];
        NSLog(@"%@", destinationVC.parentList.name);
    }
        
}
- (void)didFinishCreatingWordsListWith:(nonnull NSString *)name Language:(nonnull NSString *)basic Language:(nonnull NSString *)learned {
    WordsList *newList = [[WordsList alloc] init];
    [newList setName:name];
    [newList setBasicLanguage:basic];
    [newList setLearnedLanguage:learned];
//    [newList setWords:];
    [self save:newList];
}

/* Long press selector method */
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: point];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if(self.wordsLists.count > 0) {
            UIAlertController* deleteAlert = [UIAlertController alertControllerWithTitle: [NSString stringWithFormat:@"Are you sure to delete '%@'?", self.wordsLists[indexPath.row].name] message:nil preferredStyle:UIAlertControllerStyleActionSheet];

            UIAlertAction* unfollowAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
                [self deleteItemWithIndex: indexPath.row];
                [self loadWordsLists];
            }];
            
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle: @"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];

            [deleteAlert addAction:unfollowAction];
            [deleteAlert addAction:cancelAction];
            [self presentViewController:deleteAlert animated:YES completion:nil];
        }
    }
}
@end
