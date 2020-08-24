//
//  LanguagesViewController.h
//  Wordee
//
//  Created by Artur Wiśniewski on 22/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@class LanguagesViewController;

@protocol LanguagesViewControllerDelegate <NSObject>
- (void)didFinishCreatingWordsListWith:(NSString *)name Language:(NSString *)basic Language:(NSString *)learned;
@end


@interface LanguagesViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, weak) id <LanguagesViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *languagePickerBottom;
@property (weak, nonatomic) IBOutlet UIPickerView *languagePickerTop;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (nonatomic, retain) NSArray *languages; 

@end

NS_ASSUME_NONNULL_END
