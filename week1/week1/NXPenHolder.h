//
//  NXPenHolder.h
//  week1
//
//  Created by 최원영 on 2017. 3. 15..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPen.h"

@interface NXPenHolder : NSObject {
    
    //내부 인스턴스 변수
    NSMutableArray *_pens;
    int _usage;
    int _capacity;
    
}

//초기화 메소드
- (id)initWithCapacity:(int)capacity;

//NXPenHolder 관련 메소드
-(void)add:(NXPen*)pen;
-(void)remove:(int)penIndex;
-(int)usage;

//설명 메소드
-(void)printDescription;

@end
