//
//  main.m
//  week2
//
//  Created by 최원영 on 2017. 3. 22..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPersonModel.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"======================");
        NSLog(@"PersonModel을 돌려봅니다.");
        NSLog(@"======================");
        NSLog(@" ");
        NXPersonModel *nXPersonModel = [[NXPersonModel alloc] init];
        
        for ( int i = 0; i < nXPersonModel.persons.count; i++ ) {
            NSLog(@"%d번째 Person 정보 시작", i);
            NSLog(@"이름: %@", [nXPersonModel personNameAtIndex:i]);
            NSLog(@"넘버: %@", [nXPersonModel personNumberAtIndex:i]);
            NSLog(@"남자니? : %@", ([nXPersonModel isMaleAtIndex:i] ? @"YES" : @"NO"));
            NSLog(@"팀: %@", [nXPersonModel personTeamAtIndex:i]);
            NSLog(@"Object: %@", [nXPersonModel getPersonObjectAtIndex:i]);
            NSLog(@" ");
        }
        
        NSLog(@"이광수의 번호: %@", [nXPersonModel findPersonNumberByName:@"이광수"]);
        NSLog(@"121072번의 이름: %@", [nXPersonModel findPersonNameByNumber:@121072]);
        NSLog(@" ");
        
        NSLog(@"======================");
        NSLog(@"이름 순으로 정렬해봅니다.");
        NSLog(@"======================");
        NSArray *sortedArrayByName = [nXPersonModel sortedByName];
        for ( int i = 0; i < sortedArrayByName.count; i++ ) {
            NSLog(@"정렬된 이름: %@", [sortedArrayByName[i] objectForKey:@"name"]);
        }
        NSLog(@" ");
        
        NSLog(@"======================");
        NSLog(@"번호 순으로 정렬해봅니다.");
        NSLog(@"======================");
        NSArray *sortedArrayByNumber = [nXPersonModel sortedByNumber];
        for ( int i = 0; i < sortedArrayByNumber.count; i++ ) {
            NSLog(@"정렬된 번호: %@", [sortedArrayByNumber[i] objectForKey:@"personNumber"]);
        }
        NSLog(@" ");
        
        NSLog(@"======================");
        NSLog(@"팀 순으로 정렬해봅니다.");
        NSLog(@"======================");
        NSArray *sortedArrayByTeam = [nXPersonModel sortedByTeam];
        for ( int i = 0; i < sortedArrayByTeam.count; i++ ) {
            NSLog(@"정렬된 번호: %@", [sortedArrayByTeam[i] objectForKey:@"personTeam"]);
        }
        NSLog(@" ");
        
        NSLog(@"======================");
        NSLog(@"팀으로 필터링해봅니다.");
        NSLog(@"======================");
        NSArray *filteredArrayByTeam = [nXPersonModel filterByTeam:@1];
        NSLog(@"필터링 결과: %@", filteredArrayByTeam);
        NSLog(@" ");
        
        NSLog(@"======================");
        NSLog(@"성별로 필터링해봅니다.");
        NSLog(@"======================");
        NSArray *filteredArrayByGender = [nXPersonModel filterByGender:false];
        NSLog(@"필터링 결과: %@", filteredArrayByGender);
        NSLog(@" ");
        
        NSLog(@"======================");
        NSLog(@"중복된 성으로 필터링해봅니다.");
        NSLog(@"======================");
        NSArray *filteredArrayByLastName = [nXPersonModel filterDistinctByLastName];
        for ( int i = 0; i < filteredArrayByLastName.count; i++ ) {
            NSLog(@"중복된 성: %@", filteredArrayByLastName[i]);
        }
        NSLog(@" ");
    }
    return 0;
}
