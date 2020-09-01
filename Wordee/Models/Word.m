//
//  Word.m
//  Wordee
//
//  Created by Artur Wiśniewski on 28/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Word.h"

@implementation Word
+ (NSArray *)requiredProperties {
    return @[@"basicLanguageText", @"learnedLanguageText", @"parentList"];
}

//+ (NSDictionary *)linkingObjectsProperties {
//    return @{
//        @"parentList": [RLMPropertyDescriptor descriptorWithClass: WordsList.class propertyName:@"words"],
//    };
//}
@end
