//
//  GoGraph.m
//  week4
//
//  Created by 최원영 on 2017. 4. 6..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "GoGraph.h"

@implementation GoGraph

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initArray];
        
    }
    return self;
}

- (void) clearGraph{
    
    [self initArray];
    
}

- (void) initArray {
    _graphLinePositionArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 11; i ++) {
                
        NSMutableArray *aLine = [[NSMutableArray alloc] init];
        [aLine addObject:@0];
        [aLine addObject:@0];
        
        [_graphLinePositionArray addObject:aLine];
        
    }
}

@end
