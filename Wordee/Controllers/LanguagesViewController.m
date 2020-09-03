//
//  LanguagesViewController.m
//  Wordee
//
//  Created by Artur Wiśniewski on 22/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import "LanguagesViewController.h"

@interface LanguagesViewController ()

@end

@implementation LanguagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.highlightedTopImage = 0;
    self.highlightedBottomImage = 0;

    
    
    for (NSArray *imagesArray in [[NSArray alloc] initWithObjects:self.topViewImages, self.bottomViewImages, nil]) {
        for (UIImageView *imageView in imagesArray) {
            imageView.layer.cornerRadius = 10;
            imageView.clipsToBounds = YES;
        }
    }
    
    self.nextButton.layer.cornerRadius = 10;
    self.nextButton.clipsToBounds = YES;
    
    self.languages = [NSArray arrayWithObjects:@"english", @"french", @"german", @"italian", @"polish", @"portuguese" , @"russian" , @"spanish", nil];
}


- (IBAction)doneButtonPressed:(id)sender {
    NSString *topLang = self.languages[self.highlightedTopImage];
    NSString *bottomLang = self.languages[self.highlightedBottomImage];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Vocabulary List Name" message: nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray *textFields = alertController.textFields;
        UITextField *nameField = textFields[0];
        NSString *newListName = nameField.text;
        
        if(newListName.length < 1) newListName = @"Unnamed";
        
        [self.delegate didFinishCreatingWordsListWith: newListName Language:topLang Language:bottomLang];
        [self dismissViewControllerAnimated:YES completion:nil];

    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (IBAction)topViewButtonPressed:(UIButton *)sender {
    
    UIImageView *oldImageView = self.topViewImages[self.highlightedTopImage];
    [oldImageView.layer setBorderWidth:0.0];
    
    NSUInteger i = [self.languages indexOfObject: sender.currentTitle];
    UIImageView *imageView = self.topViewImages[i];
    [imageView.layer setBorderWidth: 5.0];
    [imageView.layer setBorderColor: [UIColor colorWithRed:0.023529 green:0.18431 blue:0.352941 alpha:1].CGColor];
    
    self.highlightedTopImage = (int)i;
}

- (IBAction)bottomViewButtonPressed:(UIButton *)sender {
    UIImageView *oldImageView = self.bottomViewImages[self.highlightedBottomImage];
    [oldImageView.layer setBorderWidth:0.0];
    
    NSUInteger i = [self.languages indexOfObject: sender.currentTitle];
    UIImageView *imageView = self.bottomViewImages[i];
    [imageView.layer setBorderWidth: 5.0];
    [imageView.layer setBorderColor: [UIColor colorWithRed:0.023529 green:0.18431 blue:0.352941 alpha:1].CGColor];
    
    self.highlightedBottomImage = (int)i;
}



@end
