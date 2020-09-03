//
//  VocabularyViewController.m
//  Wordee
//
//  Created by Artur Wiśniewski on 25/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import "VocabularyViewController.h"

@interface VocabularyViewController ()
@end

@implementation VocabularyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle: self.parentVocabularyList.name];
    
    if(!self.realm){
        self.realm = [RLMRealm defaultRealm];
    }
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView registerNib: [UINib nibWithNibName: @"WordCell" bundle: nil] forCellReuseIdentifier:@"ReusableWordCell"];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0;
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
    
    for (UIButton *button in [[NSArray alloc] initWithObjects:self.addNewButton, self.startButton, nil]) {
        button.layer.cornerRadius = 10;
        button.clipsToBounds = YES;
    }
    
}

#pragma mark - TableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.parentVocabularyList.words.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WordCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ReusableWordCell" forIndexPath:indexPath];
    Word *word = self.parentVocabularyList.words[indexPath.row];
    
    cell.leftLabel.text = word.learnedLanguageText;
    cell.rightLabel.text = word.basicLanguageText;
    cell.checkmark.hidden = !word.isLearned;
    
    return cell;
}

#pragma mark - TableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self changeCheckmarkIn:indexPath.row];
    [self.tableView reloadData];
}

#pragma mark - Update & Delete Methods
-(void)changeCheckmarkIn:(NSInteger)row{
    [self.realm transactionWithBlock:^{
        [self.parentVocabularyList.words[row] setIsLearned: !self.parentVocabularyList.words[row].isLearned];
    }];
}

-(void)deleteItemWithIndex:(NSInteger)row{
    [self.realm transactionWithBlock:^{
        [self.realm deleteObject:self.parentVocabularyList.words[row]];
    }];
    
    [self.tableView reloadData];
}


#pragma mark - Long press selector Method
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: point];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if(self.parentVocabularyList.words.count > 0) {
            UIAlertController* deleteAlert = [UIAlertController alertControllerWithTitle: [NSString stringWithFormat:@"Are you sure to delete '%@' word?", self.parentVocabularyList.words[indexPath.row].basicLanguageText] message:nil preferredStyle:UIAlertControllerStyleActionSheet];

            UIAlertAction* unfollowAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
                [self deleteItemWithIndex: indexPath.row];
            }];
            
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle: @"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];

            [deleteAlert addAction:unfollowAction];
            [deleteAlert addAction:cancelAction];
            [self presentViewController:deleteAlert animated:YES completion:nil];
        }
    }
}

- (IBAction)addNewButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier: @"goToAddNew" sender: self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier  isEqual: @"goToAddNew"]) {
        AddViewController *destonationVC = segue.destinationViewController;
        destonationVC.delegate = self;
        destonationVC.parentVocabularyList = self.parentVocabularyList;
    }
}

- (void)didAddNewWord:(Word *)word {
     [self.realm transactionWithBlock:^{
        [self.parentVocabularyList.words addObject:word];
    }];
    
    [self.tableView reloadData];
}

@end
