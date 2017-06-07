//
//  Memo.h
//  MemoFinalYoung
//
//  Created by 최원영 on 2017. 6. 7..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <Realm/Realm.h>

@interface Memo : RLMObject

@property NSString *time;
@property NSString *content;

@end
