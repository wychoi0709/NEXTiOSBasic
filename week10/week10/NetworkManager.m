//
//  NetworkManager.m
//  week10
//
//  Created by 최원영 on 2017. 5. 17..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager{
    NSURLSessionConfiguration *sessionConfigration;
    NSURLSession *sessionObject;
    NSArray *wordListResult;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        sessionConfigration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionObject = [NSURLSession sessionWithConfiguration:sessionConfigration];
        wordListResult = [[NSArray alloc] init];
    }
    return self;
}

- (void)getWordList{
    
    [[sessionObject dataTaskWithURL:[NSURL URLWithString:@"http://125.209.194.123/wordlist.php"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError *error){
        
        char *bytePtr = (char *)[data bytes];
        NSData * jsonData = [NSData dataWithBytes:bytePtr length:strlen(bytePtr)];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        jsonString = [jsonString substringWithRange:NSMakeRange(0, ([jsonString rangeOfString:@"]"].location + 1))];
        
        
        //jsonData를 NSArray로 바꾼다.
        NSError *jsonParsingError = nil;
        wordListResult =[NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                                        options:0 error:&jsonParsingError];
        
        
        NSDictionary *result = [NSDictionary dictionaryWithObject:wordListResult forKey:@"userInfo"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"postWordList" object:nil userInfo:result];
        
    }] resume];
    
}

@end
