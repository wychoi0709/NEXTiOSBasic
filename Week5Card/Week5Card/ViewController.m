//
//  ViewController.m
//  Week5Card
//
//  Created by 최원영 on 2017. 4. 12..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "ViewController.h"
#import "SolitaireCardDeck.h"
#import "Card.h"
#import "Deck.h"

@interface ViewController ()

@property(retain) SolitaireCardDeck *solitaireCardDeck;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _solitaireCardDeck = [[SolitaireCardDeck alloc] init];
    
    
    [_solitaireCardDeck displayCards];
    NSLog(@"카드 출력!!");
    
    [self printView];
    
}

- (IBAction)refreshBtnTouched:(UIButton *)sender {
    [self.view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [_solitaireCardDeck shuffleCards];
    [self printView];
}

- (void)printView {
    for ( int i = 0; i < _solitaireCardDeck.solitaireCardDeck.count; i++ ) {
        for ( int j = 0; j < ((NSMutableArray*)_solitaireCardDeck.solitaireCardDeck[i]).count; j ++ ) {
            
            
            NSString *simbol = ((Card*)_solitaireCardDeck.solitaireCardDeck[i][j]).simbol;
            NSString *number = ((Card*)_solitaireCardDeck.solitaireCardDeck[i][j]).number;
            NSString *aCard = [simbol stringByAppendingString:number];
            
            UIImage *image = [UIImage imageNamed:aCard];
            UIImageView *cardImage = [[UIImageView alloc] initWithImage:image];
            
            if( i == 0 ){
                
                [cardImage setFrame:CGRectMake(26, 100, 130, 150)];
                [self.view addSubview:cardImage];
                
            } else if ( i == 1 ){
                
                [cardImage setFrame:CGRectMake(166, 100 + 40*j, 130, 150)];
                [self.view addSubview:cardImage];
                
            } else if ( i == 2 ){
                
                [cardImage setFrame:CGRectMake(306, 100 + 40*j, 130, 150)];
                [self.view addSubview:cardImage];
                
            } else if ( i == 3 ){
                
                [cardImage setFrame:CGRectMake(446, 100 + 40*j, 130, 150)];
                [self.view addSubview:cardImage];
                
            } else if ( i == 4 ){
                
                [cardImage setFrame:CGRectMake(586, 100 + 40*j, 130, 150)];
                [self.view addSubview:cardImage];
                
            } else if ( i == 5 ){
                
                [cardImage setFrame:CGRectMake(726, 100 + 40*j, 130, 150)];
                [self.view addSubview:cardImage];
                
            } else if ( i == 6 ){
                
                [cardImage setFrame:CGRectMake(866, 100 + 40*j, 130, 150)];
                [self.view addSubview:cardImage];
                
            }
            
            [simbol release];
            [number release];
        }
    }
    
    for (int i = 0; i < _solitaireCardDeck.cardDeck.deck.count; i++) {
        
        NSString* simbol = ((Card*)_solitaireCardDeck.cardDeck.deck[i]).simbol;
        NSString* number = ((Card*)_solitaireCardDeck.cardDeck.deck[i]).number;
        NSString *aCard = [simbol stringByAppendingString:number];
        
        UIImage *image = [UIImage imageNamed:aCard];
        UIImageView *cardImage = [[UIImageView alloc] initWithImage:image];
        
        [cardImage setFrame:CGRectMake(26 + 24*i, 500 , 130, 150)];
        [self.view addSubview:cardImage];
        
        [simbol release];
        [number release];
        
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(refreshBtnTouched:)
     forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"refresh" forState:UIControlStateNormal];
    button.frame = CGRectMake(800.0, 600.0, 160.0, 140.0);
    [self.view addSubview:button];
    
}

- (void)dealloc {
    [super dealloc];
    [_solitaireCardDeck release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
