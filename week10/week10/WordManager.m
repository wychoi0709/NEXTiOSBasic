//
//  WordManager.m
//  week10
//
//  Created by 최원영 on 2017. 5. 17..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "WordManager.h"

@implementation WordManager

/**
 *  특정 콘텐츠에서 특정 substring이 얼마나 나오는지 찾는 메소드
 */
-(NSUInteger)countOfSubstring:(NSString*)substring atContents:(NSString*)contents{

//    NSInteger count = 0;
//    
//    while ( (int)contents.length > 0 ) {
//        
//        NSRange range = [contents rangeOfString:substring];
//        
//        if (range.location == NSNotFound) {
//            NSLog(@"not found or finish");
//            break;
//        } else {
//            
//            NSLog(@"at index %lu, length %lu", (unsigned long)range.location, (unsigned long)range.length);
//            count++;
//            
//            contents = [contents substringFromIndex:(range.location + range.length)];
//         
//        }
//        
//    }
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"didFinishOfCount" object:nil];
//
//    return count;

    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:substring
                                  options:NSRegularExpressionIgnoreMetacharacters
                                  error:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didFinishOfCount" object:nil];
    return [regex numberOfMatchesInString:contents options:0 range:NSMakeRange(0, [contents length])];
    
}



@end
