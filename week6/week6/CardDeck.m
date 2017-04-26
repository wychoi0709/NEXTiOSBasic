//
//  CardDeck.m
//  week6
//
//  Created by 최원영 on 2017. 4. 24..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "CardDeck.h"

@implementation CardDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        Card *aCard = [[Card alloc] init];

        NSInteger inputNumber = 1;
        for (int j = 0; j < 13; j++) {
            aCard.number = [NSNumber numberWithInteger: inputNumber];
            aCard.shape = @"H";
            inputNumber++;
            
            //createCard 라는 메소드를 카드에 넣어 둘 것(1, 11, 12, 13은 A, J, Q, K) 
            
            [_deck addObject:aCard];
        }
        
        inputNumber = 1;
        for (int j = 0; j < 13; j++) {
            aCard.number = [NSNumber numberWithInteger: inputNumber];
            aCard.shape = @"D";
            inputNumber++;
            
            [_deck addObject:aCard];
        }
        
        inputNumber = 1;
        for (int j = 0; j < 13; j++) {
            aCard.number = [NSNumber numberWithInteger: inputNumber];
            aCard.shape = @"C";
            inputNumber++;
            
            [_deck addObject:aCard];
        }
        
        inputNumber = 1;
        for (int j = 0; j < 13; j++) {
            aCard.number = [NSNumber numberWithInteger: inputNumber];
            aCard.shape = @"S";
            inputNumber++;
            
            [_deck addObject:aCard];
        }
        
    }
    return self;
}

- (void)randomize {
    
    NSMutableArray *threeRandomCards = [[NSMutableArray alloc] init];
    NSMutableArray *a = [[NSMutableArray alloc] init];
    
    //랜덤으로 카드를 3장 뽑는다.
    for(int i=0; i<52; i++) {
        [a addObject:[NSNumber numberWithInteger:i]];      //1~n까지의 수를 a배열에 넣는다.
    }
    
    for(int i=0; i<3; i++) {
        int randNum = random() % 52-i;        //1~n-i까지의 수중에 랜덤으로 1개의 수를 뽑는다.
        [a removeObjectAtIndex:randNum];        //ranNum 번째의 수를 a 배열에서 삭제한다.
        
        [threeRandomCards addObject:_deck[randNum]];
    }
    
    NSLog(@"threeRandomCards: %@", threeRandomCards);
    
    //노티를 쏜다.
    NSDictionary *cardsDictionary = [NSDictionary dictionaryWithObject:threeRandomCards forKey:@"threeRandomCards"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendThreeRandomCards" object:self userInfo:cardsDictionary];
    
}

@end
