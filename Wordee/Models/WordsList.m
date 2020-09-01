//
//  WordsList.m
//  Wordee
//
//  Created by Artur Wiśniewski on 28/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import "WordsList.h"

@implementation WordsList
+ (NSArray *)requiredProperties {
    return @[@"name", @"basicLanguage", @"learnedLanguage", @"words"];
}
@end
