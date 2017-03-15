//
//  NXPen.m
//  week1
//
//  Created by 최원영 on 2017. 3. 15..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "NXPen.h"
@implementation NXPen

//초기화 메소드
-(id)initWithBrand:(NSString*)aBrand{
    self = [super init];
    if (self) {
        _brand = aBrand;
    }
    return self;
}

//Getter
-(NSString*)brand{
    return _brand;
}
-(NSString*)color{
    return _color;
}
-(int)usage{
    return _usage;
}

//Setter
-(void)setBrand:(NSString*)brand{
    _brand = brand;
}
-(void)setColor:(NSString*)color{
    _color = color;
}
-(void)setUsage:(int)usage{
    _usage = usage;
}

//Display 메소드
-(void)printDescription{
    NSLog(@"brand: %@", _brand);
    NSLog(@"color: %@", _color);
    NSLog(@"usage: %d", _usage);
}

@end
