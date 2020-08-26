//
//  ListNameCell.m
//  Wordee
//
//  Created by Artur Wiśniewski on 20/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import "ListNameCell.h"

@implementation ListNameCell

//Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.leftImageView.layer.masksToBounds = YES;
//    self.leftImageView.layer.cornerRadius = 25;
//
//    self.leftImageView.layer.shadowColor = [UIColor grayColor].CGColor;
//    self.leftImageView.layer.shadowOffset = CGSizeMake(0, 3);
//    self.leftImageView.layer.shadowOpacity = 0.7;
//    self.leftImageView.layer.shadowRadius = 2.5;
//    self.leftImageView.clipsToBounds = NO;
//
//    self.rightImageView.layer.masksToBounds = YES;
//    self.rightImageView.layer.cornerRadius = 25;
//    self.rightImageView.layer.shadowColor = [UIColor grayColor].CGColor;
//    self.rightImageView.layer.shadowOffset = CGSizeMake(0, 3);
//    self.rightImageView.layer.shadowOpacity = 0.7;
//    self.rightImageView.layer.shadowRadius = 2.5;
//    self.rightImageView.clipsToBounds = NO;
    
    for (UIImageView *imgView in [[NSArray alloc] initWithObjects:self.leftImageView, self.rightImageView, nil]) {
        imgView.layer.masksToBounds = YES;
        imgView.layer.cornerRadius = 25;
        
        imgView.layer.shadowColor = [UIColor grayColor].CGColor;
        imgView.layer.shadowOffset = CGSizeMake(0, 3);
        imgView.layer.shadowOpacity = 0.7;
        imgView.layer.shadowRadius = 2.5;
        imgView.clipsToBounds = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
