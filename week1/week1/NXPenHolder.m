//
//  NXPenHolder.m
//  week1
//
//  Created by 최원영 on 2017. 3. 15..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "NXPenHolder.h"

@implementation NXPenHolder

//초기화 메소드
- (id)initWithCapacity:(int)capacity{
    self = [super init];
    if (self) {
        
        //_pens는 NSMutableArray가 아닐까?
        _pens = [NSMutableArray arrayWithCapacity:capacity];
        _capacity = capacity;
        
    }
    return self;
}

//NXPenHolder 관련 메소드
-(void)add:(NXPen*)pen{
    if( _capacity > _usage) {
        [_pens addObject:pen];
        ++_usage;
    } else {
        NSLog(@"");
        NSLog(@"펜 홀더 풀방이지롱");
        NSLog(@"");
    }
}
-(void)remove:(int)penIndex{
    if( _usage > penIndex ){
        [_pens removeObjectAtIndex:penIndex];
        --_usage;
    } else {
        NSLog(@"");
        NSLog(@"그런 펜 없다.");
        NSLog(@"");
    }
}
-(int)usage{
    return _capacity - (int)[_pens count];
}

//설명 메소드
-(void)printDescription{
    NSLog(@"");
    NSLog(@"_pens 배열: %@", _pens);
    NSLog(@"_usage   : %d", _usage);
    NSLog(@"");
}


@end
