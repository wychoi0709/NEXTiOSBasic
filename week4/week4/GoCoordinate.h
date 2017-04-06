//
//  GoCoordinate.h
//  week4
//
//  Created by 최원영 on 2017. 4. 6..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoCoordinate : NSObject{
    
    NSInteger totalWidth;
    
}

@property NSMutableArray *coordinatePositionArray;
@property NSInteger individualWidth;
@property Boolean isWhite;


- (instancetype)initWithTotalWidth:(NSInteger)totalWidth;
- (void) clearCoordinate;

@end
