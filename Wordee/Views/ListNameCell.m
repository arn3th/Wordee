//
//  ListNameCell.m
//  Wordee
//
//  Created by Artur Wiśniewski on 20/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import "ListNameCell.h"

@implementation ListNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.leftImageView.layer.masksToBounds = YES;
    self.leftImageView.layer.cornerRadius = 25;
    
    self.rightImageView.layer.masksToBounds = YES;
    self.rightImageView.layer.cornerRadius = 25;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
