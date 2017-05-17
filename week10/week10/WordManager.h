//
//  WordManager.h
//  week10
//
//  Created by 최원영 on 2017. 5. 17..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordManager : NSObject

-(NSUInteger)countOfSubstring:(NSString*)substring atContents:(NSString*)contents;

@end
