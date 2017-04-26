//
//  CardDeck.h
//  week6
//
//  Created by 최원영 on 2017. 4. 24..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface CardDeck : NSObject

@property NSMutableArray *deck;

- (void)randomize;

@end
