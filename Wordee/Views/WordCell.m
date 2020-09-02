//
//  WordCell.m
//  Wordee
//
//  Created by Artur Wiśniewski on 26/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import "WordCell.h"

@implementation WordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.externalView.layer.masksToBounds = YES;
    self.externalView.layer.cornerRadius = 10;
//
    self.externalView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.externalView.layer.shadowOffset = CGSizeMake(0, 3);
    self.externalView.layer.shadowOpacity = 0.7;
    self.externalView.layer.shadowRadius = 2.5;
    self.externalView.clipsToBounds = NO;
    self.externalView.backgroundColor = [UIColor systemBackgroundColor];
    
//    self.layer.shadowColor = [UIColor grayColor].CGColor;
//    self.layer.shadowOffset = CGSizeMake(0, 3);
//    self.layer.shadowOpacity = 0.7;
//    self.layer.shadowRadius = 2.5;
//    self.clipsToBounds = NO;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
