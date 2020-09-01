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
#import "Word.h"

RLM_ARRAY_TYPE(Word)

@interface WordsList : RLMObject

@property NSString *name;
@property NSString *basicLanguage;
@property NSString *learnedLanguage;
@property RLMArray<Word *><Word> *words;

@end


