//
//  Word.h
//  Wordee
//
//  Created by Artur Wiśniewski on 25/08/2020.
//  Copyright © 2020 Artur Wiśniewski. All rights reserved.
//

#import <Realm/Realm.h>
//#import "WordsList.h"

@interface Word: RLMObject

@property NSString *basicLanguageText;
@property NSString *learnedLanguageText;
//@property RLMLinkingObjects *parentList;
@end


