//
//  MemoManager.h
//  MemoFinalYoung
//
//  Created by 최원영 on 2017. 6. 7..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Memo.h"

@interface MemoManager : NSObject


@property RLMArray<Memo *> *memos;

+(MemoManager *) getMemoManagerObject;
- (void)addMemo:(Memo*)aMemo;
- (void)getAllMemo;
- (void)updateMemo:(Memo*)aMemo withTime:(NSString*)time withContent:(NSString*)content;
- (void)deleteMemo:(Memo*)aMemo;
- (void)deleteAllMemo;

@end
