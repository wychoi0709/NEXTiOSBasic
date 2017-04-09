//
//  GoBoardModel.m
//  week4
//
//  Created by 최원영 on 2017. 4. 9..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "GoBoardModel.h"

@implementation GoBoardModel{
    
    NSNotificationCenter *defaultCenter;
    
}

- (instancetype)initWithTotalWidth:(NSInteger)givenTotalWidth
{
    self = [super init];
    if (self) {
        
        totalWidth = givenTotalWidth;
        _isWhite = false;
        [self initSettingOfCoordination];
        defaultCenter = [NSNotificationCenter defaultCenter];
        
        [self pushNotification];
    }
    return self;
}

- (void) initSettingOfCoordination {
    
    _coordinatePositionArray = [[NSMutableArray alloc] init];
    _individualWidth = totalWidth / 11;
    
    NSMutableArray *aRowCoordinate = [[NSMutableArray alloc] init];
    
    NSInteger firstX = (totalWidth/11) - (_individualWidth/2);
    NSInteger x = (totalWidth/11) - (_individualWidth/2);
    NSInteger y = (totalWidth/11);
    
    for( int i = 0; i < 11; i ++ ) {
        
        for ( int j = 0; j < 11; j ++ ) {
            NSMutableArray *aCoordinate = [[NSMutableArray alloc] init];
            [aCoordinate addObject:[NSNumber numberWithInteger:x]];
            [aCoordinate addObject:[NSNumber numberWithInteger:y]];
            [aCoordinate addObject:[NSNumber numberWithBool:YES]];
            [aCoordinate addObject:@"-"];
            
            x = x + _individualWidth;
            
            [aRowCoordinate addObject:aCoordinate];
        }
        
        [_coordinatePositionArray addObject:aRowCoordinate];
        aRowCoordinate = [[NSMutableArray alloc] init];
        y = y + _individualWidth;
        x = firstX;
        
    }
    
    NSMutableArray *aCoordinate = [[NSMutableArray alloc] init];
    [aCoordinate addObject:[NSNumber numberWithInteger:x]];
    [aCoordinate addObject:[NSNumber numberWithInteger:y]];
    [aCoordinate addObject:[NSNumber numberWithBool:YES]];
    [aCoordinate addObject:@"-"];
    
    [aRowCoordinate addObject:aCoordinate];
    
    NSLog(@"coordinatePositionArray: %@", _coordinatePositionArray);
    
}


- (void) clearCoordinate{
    
    for ( int i = 0; i < 11; i ++ ) {
        for ( int j = 0; j < 11; j++ ) {
            [_coordinatePositionArray[i][j] replaceObjectAtIndex:2 withObject:[NSNumber numberWithBool:YES]];
        }
    }
    
    _isWhite = NO;
    
    [self pushNotification];
}

- (void)pushNotification{

    //노티에 자신을 넣어서 보낸다.
    NSDictionary *boardModel = [NSDictionary dictionaryWithObject:self forKey:@"newGoBoardModel"];
    
    [defaultCenter postNotificationName:@"renewBoardView" object:nil userInfo:boardModel];
    
}

@end
