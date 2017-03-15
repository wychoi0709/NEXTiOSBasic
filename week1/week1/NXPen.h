//
//  NXPen.h
//  week1
//
//  Created by 최원영 on 2017. 3. 15..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXPen : NSObject {
    
    //인스턴스 변수들(외부로 공개 X)
    NSString* _brand; //monami, sharp
    NSString* _color; //red, blue, black
    int _usage; //100%, 50%, 10%
    
}
//초기화 메소드
-(id)initWithBrand:(NSString*)aBrand;

//Getter
-(NSString*)brand;
-(NSString*)color;
-(int)usage;

//Setter
-(void)setBrand:(NSString*)brand;
-(void)setColor:(NSString*)color;
-(void)setUsage:(int)usage;

//Display 메소드
-(void)printDescription;

@end
