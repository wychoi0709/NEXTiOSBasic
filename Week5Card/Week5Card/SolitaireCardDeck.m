//
//  SolitaireCardDeck.m
//  Week5Card
//
//  Created by 최원영 on 2017. 4. 12..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "SolitaireCardDeck.h"
#import "Card.h"

@implementation SolitaireCardDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cardDeck = [[Deck alloc] init];
        _solitaireCardDeck = [[NSMutableArray alloc] init];
        [self shuffleCards];
    }
    return self;
}

/**
 *  카드 덱을 셔플한다.
 */
- (void) shuffleCards{
    
    [_cardDeck initailizeDeck];
    [_solitaireCardDeck removeAllObjects];
    
    for ( int i = 0; i < 7; i++ ) {

        int value = arc4random_uniform((int)(_cardDeck.deck.count));
        NSMutableArray *aRow = [[NSMutableArray alloc] init];
        
        if( i == 0 ){
            [aRow addObject: _cardDeck.deck[value]];
            [_cardDeck.deck removeObject:_cardDeck.deck[value]];
        } else if ( i == 1 ) {
            for (int j = 0; j<2; j++) {
                value = arc4random_uniform((int)(_cardDeck.deck.count));
                
                [aRow addObject: _cardDeck.deck[value]];
                [_cardDeck.deck removeObject:_cardDeck.deck[value]];

            }
        } else if ( i == 2 ) {
            for (int j = 0; j<3; j++) {
                value = arc4random_uniform((int)(_cardDeck.deck.count));
                
                [aRow addObject: _cardDeck.deck[value]];
                [_cardDeck.deck removeObject:_cardDeck.deck[value]];
                
            }
        } else if ( i == 3 ) {
            for (int j = 0; j<4; j++) {
                value = arc4random_uniform((int)(_cardDeck.deck.count));
                
                [aRow addObject: _cardDeck.deck[value]];
                [_cardDeck.deck removeObject:_cardDeck.deck[value]];
                
            }
        } else if ( i == 4 ) {
            for (int j = 0; j<5; j++) {
                value = arc4random_uniform((int)(_cardDeck.deck.count));
                
                [aRow addObject: _cardDeck.deck[value]];
                [_cardDeck.deck removeObject:_cardDeck.deck[value]];
                
            }
        } else if ( i == 5 ) {
            for (int j = 0; j<6; j++) {
                value = arc4random_uniform((int)(_cardDeck.deck.count));
                
                [aRow addObject: _cardDeck.deck[value]];
                [_cardDeck.deck removeObject:_cardDeck.deck[value]];
                
            }
        } else {
            for (int j = 0; j<7; j++) {
                value = arc4random_uniform((int)(_cardDeck.deck.count));
                
                [aRow addObject: _cardDeck.deck[value]];
                [_cardDeck.deck removeObject:_cardDeck.deck[value]];
                
            }
        }
        
        [_solitaireCardDeck addObject:aRow];
        [aRow release];
        
    }
}

/**
 *  카드를 로그로 출력한다.
 */
- (void) displayCards {
    
    NSLog(@"카드 출력!!");
    for ( int i = 0; i < _solitaireCardDeck.count; i++ ) {
        for ( int j = 0; j < ((NSMutableArray*)_solitaireCardDeck[i]).count; j ++ ) {
            NSLog(@"%d 번째 줄", i);
            NSLog(@"%d 번째 카드", j);
            NSLog(@"%@", ((Card*)_solitaireCardDeck[i][j]).simbol);
            NSLog(@"%@", ((Card*)_solitaireCardDeck[i][j]).number);
        }
    }
    
}

@end
