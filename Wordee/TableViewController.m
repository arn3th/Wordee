//
//  ViewController.m
//  Wordee
//
//  Created by Artur Wiśniewski on 20/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import "TableViewController.h"
#import "ListNameCell.h"


@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listsNames = @[
        @"Your Move",
        @"Their Move",
        @"Won Games",
        @"Lost Games",
        @"Options"
    ];
    
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
    return self.listsNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReusableCell" forIndexPath:indexPath];
    
    cell.nameLabel.text = self.listsNames[indexPath.row];
    cell.downLabel.text = @"0/0";

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

@end
