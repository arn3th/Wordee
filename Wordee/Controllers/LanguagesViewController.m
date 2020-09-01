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
    self.languagePickerTop.delegate = self;
    self.languagePickerBottom.delegate = self;
    self.addButton.layer.cornerRadius = 10;
    self.addButton.clipsToBounds = YES;
    self.languages = [NSArray arrayWithObjects:@"english", @"french", @"german", @"italian", @"polish", @"portuguese" , @"russian" , @"spanish", @"ukrainian", nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)doneButtonPressed:(id)sender {
    NSString *topLang = self.languages[[self.languagePickerTop selectedRowInComponent:0]];
    NSString *bottomLang = self.languages[[self.languagePickerBottom selectedRowInComponent:0]];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Vocabulary List Name" message: nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"name";
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

// UIPickerViewDataSource methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 9;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 60;
}


//UIPickerViewDelegate methods
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pickerView.bounds.size.width, 86)];
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pickerView.bounds.size.width, 86)];
    
    [myImageView setImage:[UIImage imageNamed: [NSString stringWithFormat:@"%@_svg.pdf", self.languages[row]]]];
    [myImageView.layer setMasksToBounds:YES];
    [myImageView.layer setCornerRadius: 25.0];
//    [myImageView setImage:[UIImage imageNamed:@"english_svg.pdf"]];
    [myImageView setContentMode: UIViewContentModeRedraw];
//    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, pickerView.bounds.size.width - 90, 60)];
//    myLabel.text = [self.languages[row] capitalizedString];
//    myLabel.textColor = [UIColor whiteColor];
    
    
    [myView addSubview:myImageView];
//    [myView addSubview:myLabel];
    return myView;
}


@end
