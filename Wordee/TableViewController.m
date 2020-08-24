//
//  ViewController.m
//  Wordee
//
//  Created by Artur Wiśniewski on 20/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import "TableViewController.h"
#import "ListNameCell.h"
#import "WordsList.h"
#import <Realm/Realm.h>

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
}


/* TableView Methods */
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

/* SearchBar Methods */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText length] == 0) {
        [self performSelector:@selector(hideKeyboardWithSearchBar:) withObject:searchBar afterDelay:0];
    }
}

- (void)hideKeyboardWithSearchBar:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

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

-(void) addWordsList{
        WordsList *wordsList = [[WordsList alloc] init];
        [wordsList setName: @"Test2 test2"];
        [wordsList setBasicLanguage: @"english"];
        [wordsList setLearnedLanguage:@"german"];
    [self save:wordsList];
}


- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier: @"goToLanguages" sender: self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier  isEqual: @"goToLanguages"]) {
        LanguagesViewController *destonationVC = segue.destinationViewController;
        destonationVC.delegate = self;
        
    }
}
- (void)didFinishCreatingWordsListWith:(nonnull NSString *)name Language:(nonnull NSString *)basic Language:(nonnull NSString *)learned {
    NSLog(@"Received: %@ %@ %@", name, basic, learned);
    WordsList *newList = [[WordsList alloc] init];
    [newList setName:name];
    [newList setBasicLanguage:basic];
    [newList setLearnedLanguage:learned];
    [self save:newList];
}

@end
