//
//  AddViewController.m
//  Wordee
//
//  Created by Artur Wiśniewski on 03/09/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import "AddViewController.h"


@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addButton.layer.cornerRadius = 10;
    self.addButton.clipsToBounds = YES;
    
    self.topLanguageName.text = self.parentVocabularyList.basicLanguage.uppercaseString;
    self.bottomLanguageName.text = self.parentVocabularyList.learnedLanguage.uppercaseString;
    
    self.topTextField.placeholder = [NSString stringWithFormat:@"%@ word", self.parentVocabularyList.basicLanguage.lowercaseString];
    self.bottomTextField.placeholder = [NSString stringWithFormat:@"%@ word", self.parentVocabularyList.learnedLanguage.lowercaseString];
}

- (IBAction)addButtonPressed:(UIButton *)sender {
    Word *newWord = [[Word alloc] init];
    newWord.basicLanguageText = self.topTextField.text;
    newWord.learnedLanguageText = self.bottomTextField.text;
    newWord.isLearned = NO;
    
    [self.delegate didAddNewWord:newWord];
    
    self.topTextField.text = @"";
    self.bottomTextField.text = @"";
}
@end
