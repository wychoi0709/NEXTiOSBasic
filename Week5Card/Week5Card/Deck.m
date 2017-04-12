//
//  Deck.m
//  Week5Card
//
//  Created by 최원영 on 2017. 4. 12..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@implementation Deck

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _deck = [[NSMutableArray alloc] init];
        [self initailizeDeck];
        
    }
    return self;
}


/**
 *  덱을 초기화한다.
 */
- (void) initailizeDeck{
    
    [_deck removeAllObjects];
    
    for ( int i = 0; i < 52; i++ ) {
        
        Card *aCard = [[Card alloc] init];
        
        //다이아
        if( i%4 == 0 ){ aCard.simbol = @"d"; }
        //하트
        else if ( i%4 == 1 ){ aCard.simbol = @"h"; }
        //스페이드
        else if ( i%4 == 2 ){ aCard.simbol = @"s"; }
        //클로버
        else if ( i%4 == 3 ){ aCard.simbol = @"c"; }
        
        
        if ( i%14+1 == 11 ) {
            
            aCard.number = @"J";
            
        } else if (i%14+1 == 12) {
            
            aCard.number = @"Q";
            
        } else if (i%14+1 == 13) {
            
            aCard.number = @"K";
            
        } else if (i%14+1 == 1) {
            
            aCard.number = @"A";
            
        } else {
            
            aCard.number = [[NSNumber numberWithInt: i%9 + 2] stringValue];
            
        }
        
        
        [_deck addObject:aCard];
        
        [aCard release];
        
    }
    
}

@end
