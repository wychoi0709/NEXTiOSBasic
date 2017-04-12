//
//  SolitaireCardDeck.h
//  Week5Card
//
//  Created by 최원영 on 2017. 4. 12..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface SolitaireCardDeck : NSObject

@property (retain) NSMutableArray* solitaireCardDeck;
@property (retain) Deck* cardDeck;

- (void) displayCards;
- (void) shuffleCards;

@end
