//
//  AddViewController.h
//  Wordee
//
//  Created by Artur Wiśniewski on 03/09/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "WordsList.h"
#import "Word.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AddViewControllerDelegate <NSObject>
- (void)didAddNewWord:(Word *)word;
@end


@interface AddViewController : UIViewController
@property (weak, nonatomic) id <AddViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *topLanguageName;
@property (weak, nonatomic) IBOutlet UILabel *bottomLanguageName;
@property (weak, nonatomic) IBOutlet UITextField *topTextField;
@property (weak, nonatomic) IBOutlet UITextField *bottomTextField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (strong, nonatomic) WordsList* parentVocabularyList;
@property (atomic, retain) RLMRealm *realm;

@end

NS_ASSUME_NONNULL_END
