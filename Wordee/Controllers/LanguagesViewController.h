//
//  LanguagesViewController.h
//  Wordee
//
//  Created by Artur Wiśniewski on 22/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class LanguagesViewController;

@protocol LanguagesViewControllerDelegate <NSObject>
- (void)didFinishCreatingWordsListWith:(NSString *)name Language:(NSString *)basic Language:(NSString *)learned;
@end


@interface LanguagesViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id <LanguagesViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *languagePickerBottom;
@property (weak, nonatomic) IBOutlet UIPickerView *languagePickerTop;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (nonatomic, retain) NSArray *languages; 

@end
