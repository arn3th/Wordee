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


@interface LanguagesViewController : UIViewController

@property (weak, nonatomic) id <LanguagesViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) NSArray *languages;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *topViewImages;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *bottomViewImages;

@property int highlightedTopImage;
@property int highlightedBottomImage;

@end
