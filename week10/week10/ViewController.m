//
//  ViewController.m
//  week10
//
//  Created by 최원영 on 2017. 5. 15..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "ViewController.h"
#import "WordManager.h"
#import "NetworkManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonTop;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UITextField *substringText;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation ViewController{
    
    WordManager *wordManager;
    NSString *bookfile;
    
    NSArray *wordListResult;
    NSMutableArray *countNumberArray;
    
    NSInteger searchCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    wordManager = [[WordManager alloc] init];
    
    bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                   pathForResource:@"bookfile" ofType:@"txt"]  encoding:NSUTF8StringEncoding error:nil];
    countNumberArray = [[NSMutableArray alloc] init];
    searchCount = 0;
    [self enrollNotification];
    
    [[[NetworkManager alloc] init] getWordList];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTouched:(UIButton *)sender {
    
    _progressBar.progress = 0;
    

    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        [self workingProgress];
    });
}

- (IBAction)countBtnTouched:(UIButton *)sender {
    
    _countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[wordManager countOfSubstring:_substringText.text atContents:bookfile]];
    
}

- (void) enrollNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterGetWordList:) name:@"postWordList" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterGetCountSignal:) name:@"didFinishOfCount" object:nil];
}

- (void)afterGetWordList:(NSNotification*)noti {
    wordListResult = [[noti userInfo] objectForKey:@"userInfo"];
    
    for (int i = 0; i < wordListResult.count; i++) {
        NSString *nameOfQueue = [@"wordListQueue" stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
        
        dispatch_queue_t queue = dispatch_queue_create([nameOfQueue UTF8String], nil);
        dispatch_async(queue, ^{
            
            NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc] init];
            
            [resultDictionary setObject:wordListResult[i] forKey:@"word"];
            [resultDictionary setObject:[NSNumber numberWithInteger:[wordManager countOfSubstring:wordListResult[i] atContents:bookfile]] forKey:@"count"];
            
            [countNumberArray addObject:resultDictionary];
        });
        
    }
}

- (void)afterGetCountSignal:(NSNotification*)noti {
    searchCount++;
    
    if( searchCount == wordListResult.count ){
        [self alertResult];
    }
    
}

- (void) alertResult{
    for (int i = 0; i < countNumberArray.count; i++) {
        //가장 큰 것과 가장 작은 것을 찾아서 alert로 띄운다.
        NSLog(@"string: %@", [countNumberArray[i] objectForKey:@"word"]);
        
    }
    
    [UIAlertController alertControllerWithTitle:@"aa" message:@"fff" preferredStyle:UIAlertControllerStyleAlert];
}

-(void)workingProgress {
    
    int length = (int)bookfile.length;
    int spaceCount = 0;
    float progress = 0;
    unichar aChar;
    
    for (int nLoop=0; nLoop<length; nLoop++) {
        
        aChar = [bookfile characterAtIndex:nLoop];
        if (aChar==' ') spaceCount++;
        progress = (float)nLoop / (float)length;
        _progressBar.progress = progress;
        
    }
    
    [[[UIAlertView alloc] initWithTitle:@"완료"
                                message:[NSString stringWithFormat:@"찾았다 %d개",spaceCount]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil] show];
    
}

@end
