//
//  MyModel.h
//  week3
//
//  Created by 최원영 on 2017. 3. 29..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject

@property NSArray *jsonArray;

- (instancetype)initWithJSONString:(NSString*)JSONString;
- (NSDictionary*)itemAtIndex:(int)index;

@end
