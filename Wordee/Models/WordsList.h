//
//  WordsList.h
//  Wordee
//
//  Created by Artur Wiśniewski on 22/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//
//
//#ifndef WordsList_h
//#define WordsList_h
//
//
//#endif /* WordsList_h */

#import <Realm/Realm.h>

@interface WordsList : RLMObject

@property NSString *name;
@property NSString *basicLanguage;
@property NSString *learnedLanguage;

@end


@implementation WordsList
+ (NSArray *)requiredProperties {
    return @[@"name", @"basicLanguage", @"learnedLanguage"];
}
@end
