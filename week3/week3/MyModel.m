//
//  MyModel.m
//  week3
//
//  Created by 최원영 on 2017. 3. 29..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "MyModel.h"


@implementation MyModel

/**
 *  넘어온 String JSON을 Array로 바꿔준다.
 */
- (instancetype)initWithJSONString:(NSString*)JSONString{
    self = [super init];
    if (self) {
        
        NSData *jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
        _jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        NSLog(@"변환된 JsonArray: %@", _jsonArray);

    }
    return self;
}

/**
 *  랜덤 숫자에 따라 Dic을 넘겨준다.
 */
- (NSDictionary*)itemAtIndex:(int)index{
    
    NSDictionary* resultDic = _jsonArray[index];
    NSLog(@"결과: %@", resultDic);
    return resultDic;
    
}
@end
