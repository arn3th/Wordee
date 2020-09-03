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

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - TableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wordsLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReusableCell" forIndexPath:indexPath];
    
    WordsList *currentList = self.wordsLists[indexPath.row];
    
    cell.nameLabel.text = currentList.name;
    cell.downLabel.text = [self getProgressFor:currentList];
    cell.leftImageView.image = [UIImage imageNamed: currentList.basicLanguage];
    cell.rightImageView.image = [UIImage imageNamed: currentList.learnedLanguage];
    
    return cell;
}
#pragma mark - TableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self performSegueWithIdentifier: @"goToVocabulary" sender: self];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - SearchBar Methods
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

#pragma mark - Create, Read & Delete Methods
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

-(NSString*)getProgressFor:(WordsList*)list{
    NSInteger size = list.words.count;
    int i = 0;
    for (Word* word in list.words) {
        if(word.isLearned) i++;
    }
    return [NSString stringWithFormat:@"%d/%ld", i, (long)size];
}

#pragma mark - LanguagesVC Methods
- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier: @"goToLanguages" sender: self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier  isEqual: @"goToLanguages"]) {
        LanguagesViewController *destonationVC = segue.destinationViewController;
        destonationVC.delegate = self;
    } else if([segue.identifier  isEqual: @"goToVocabulary"]) {
        VocabularyViewController *destinationVC = segue.destinationViewController;
        [destinationVC setParentVocabularyList: self.wordsLists[self.tableView.indexPathForSelectedRow.row]];
    }
        
}
- (void)didFinishCreatingWordsListWith:(nonnull NSString *)name Language:(nonnull NSString *)basic Language:(nonnull NSString *)learned {
    WordsList *newList = [[WordsList alloc] init];
    [newList setName:name];
    [newList setBasicLanguage:basic];
    [newList setLearnedLanguage:learned];
    [self save:newList];
}

#pragma mark - Long Press Selector Method
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


