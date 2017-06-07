//
//  MemoManager.m
//  MemoFinalYoung
//
//  Created by 최원영 on 2017. 6. 7..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "MemoManager.h"
#import "Memo.h"
#import <Realm.h>

@implementation MemoManager{
    RLMRealm *realm;
}

+(MemoManager *) getMemoManagerObject {
    
    static MemoManager * sharedSingletonStateInstance;
    
    @synchronized (self){       // @synchronized를 통해 객체를 획득하는 부분의 상호배제
        if (!sharedSingletonStateInstance){
            sharedSingletonStateInstance = [[MemoManager alloc] initPrivate];
        }
    }
    
    return sharedSingletonStateInstance;
}

-(instancetype) init {
    @throw [NSException exceptionWithName:@"MemoManager is Singleton" reason:@"" userInfo:nil];
}

-(instancetype) initPrivate {
    self = [super init];
    if (self){
    
        realm = [RLMRealm defaultRealm];
        [self getAllMemo];
        
    }
    return self;
}

//CRUD 구현
- (void)addMemo:(Memo*)aMemo{
    [realm beginWriteTransaction];
    [realm addObject:aMemo];
    [realm commitWriteTransaction];
    
    [self sendMemoUsingNoti];
}

- (void)getAllMemo{
    RLMResults<Memo*> *allMemo = [Memo allObjects];
    RLMResults<Memo*> *sortedByTime = [allMemo sortedResultsUsingKeyPath:@"time" ascending:YES];
    _memos = (RLMArray*)sortedByTime;
    
    [self sendMemoUsingNoti];
}

- (void)updateMemo:(Memo*)aMemo withTime:(NSString*)time withContent:(NSString*)content{
    
    [realm beginWriteTransaction];
    aMemo.time = time;
    aMemo.content = content;
    [realm commitWriteTransaction];
    
    [self getAllMemo];
}

- (void)deleteMemo:(Memo*)aMemo{
    NSLog(@"하나 삭제 진행");
    
    [realm beginWriteTransaction];
    [realm deleteObject:aMemo];
    [realm commitWriteTransaction];
    
    [self sendMemoUsingNoti];
}

- (void)deleteAllMemo{
    NSLog(@"모두 삭제 진행");
    
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];

    [self sendMemoUsingNoti];
}

- (void)sendMemoUsingNoti{
    
    NSDictionary *resultDic = [NSDictionary dictionaryWithObject:_memos forKey:@"memoResult"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendMemoResult" object:nil userInfo:resultDic];
    
}


@end
