//
//  NXPersonModel.m
//  week2
//
//  Created by 최원영 on 2017. 3. 22..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "NXPersonModel.h"

@implementation NXPersonModel

/**
 *  초기화 메소드
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        //사람 배열을 초기화한다.
        [self initPersonArray];
        
        //numberFormatter를 초기화한다.
        _f = [[NSNumberFormatter alloc] init];
        _f.numberStyle = NSNumberFormatterDecimalStyle;
    }
    return self;
}


/**
 *  특정 인덱스의 사람 이름을 리턴한다.
 */
- (NSString*)personNameAtIndex:(int)index{
    return [_persons[index] objectForKey:@"name"];
}

/**
 *  특정 인덱스의 사람 번호를 리턴한다.
 */
- (NSNumber*)personNumberAtIndex:(int)index{
    return [_f numberFromString:[_persons[index] objectForKey:@"personNumber"]];
}

/**
 *  특정 인덱스의 사람 성별을 리턴한다.
 */
- (BOOL)isMaleAtIndex:(int)index{
    BOOL isMale = true;
    if ( [@"F" isEqualToString:[_persons[index] objectForKey:@"gender"]] ) {
        isMale = false;
    }
    return isMale;
}

/**
 *  특정 인덱스의 사람 팀을 리턴한다.
 */
- (NSNumber*)personTeamAtIndex:(int)index{
    return [_f numberFromString:[_persons[index] objectForKey:@"personTeam"]];
}

- (NSDictionary*)getPersonObjectAtIndex:(int)index{
    return _persons[index];
}

/**
 *  사람 넘버로 사람 이름을 찾아서 리턴한다.
 */
- (NSString*) findPersonNameByNumber:(NSNumber*)number{
    NSString *numberString = [number stringValue];
    for (int i = 0; i < _persons.count; i++ ) {
        if ( [numberString isEqualToString:[_persons[i] objectForKey:@"personNumber"]] ) {
            return [_persons[i] objectForKey:@"name"];
        }
    }
    return @"애러";
}

/**
 *  사람 이름으로 넘버를 찾아서 리턴한다.
 */
- (NSNumber*) findPersonNumberByName:(NSString*)name{
    for (int i = 0; i < _persons.count; i++ ) {
        if ( [name isEqualToString:[_persons[i] objectForKey:@"name"]] ) {
            return [_f numberFromString:[_persons[i] objectForKey:@"personNumber"]];
        }
    }
    return @999999;
}

/**
 *  이름 가나다 순으로 정렬
 */
- (NSArray*) sortedByName{
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name"
                                        ascending:YES
                                        selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *descriptors = [NSArray arrayWithObjects:nameDescriptor, nil];
    return [_persons sortedArrayUsingDescriptors:descriptors];
}

/**
 *  숫자 순으로 정렬
 */
- (NSArray*) sortedByNumber{
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"personNumber"
                                        ascending:YES
                                        selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *descriptors = [NSArray arrayWithObjects:nameDescriptor, nil];
    return [_persons sortedArrayUsingDescriptors:descriptors];
}

/**
 *  팀 이름 순으로 정렬
 */
- (NSArray*) sortedByTeam{
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"personTeam"
                                        ascending:YES
                                        selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *descriptors = [NSArray arrayWithObjects:nameDescriptor, nil];
    return [_persons sortedArrayUsingDescriptors:descriptors];
}

/**
 *  팀 이름으로 필터링
 */
- (NSArray*) filterByTeam:(NSNumber*)team{
    NSMutableArray *tempMutablePerson = [[NSMutableArray alloc] init];
    NSString *teamString = [team stringValue];
    
    for( int i = 0; i < _persons.count; i++ ) {
        if ( [teamString isEqualToString:[_persons[i] objectForKey:@"personTeam"]] ) {
            [tempMutablePerson addObject:_persons[i]];
        }
        
    }
    return tempMutablePerson;
}

/**
 *  성별로 필터링
 */
- (NSArray*) filterByGender:(BOOL)isMale{
    NSMutableArray *tempMutablePerson = [[NSMutableArray alloc] init];
    NSString *genderString;
    if ( isMale ) {
        genderString = @"M";
    } else {
        genderString = @"F";
    }
    
    for( int i = 0; i < _persons.count; i++ ) {
        if ( [genderString isEqualToString:[_persons[i] objectForKey:@"gender"]] ) {
            [tempMutablePerson addObject:_persons[i]];
        }
        
    }
    return tempMutablePerson;
}

/**
 *  중복된 성씨 목록만 필터링
 */
- (NSArray*) filterDistinctByLastName{
    NSMutableArray *tempMutableLastName = [[NSMutableArray alloc] init];

    for (int i = 0; i < _persons.count; i++ ) {
        for (int j = i+1; j < _persons.count; j++) {
            NSString *firstLastName = [[_persons[i] objectForKey:@"name"] substringToIndex:1];
            NSString *secondLastName = [[_persons[j] objectForKey:@"name"] substringToIndex:1];
            if( [firstLastName isEqualToString:secondLastName] ) {
                [tempMutableLastName addObject:firstLastName];
            }
        }
    }
    
    return tempMutableLastName;
}

/**
 *  (내가 만든 정리용 코드) 텍스트 파일에서 잘 추출한다.
 */
- (void) initPersonArray {
    //텍스트를 쪼개서 잘 담는다.
    NSError *error;
    NSString *personString = [NSString stringWithContentsOfFile:@"/Users/young/Desktop/person.txt" encoding:NSUTF8StringEncoding error:&error];
    
    if (!error) {
        
        NSArray *tempPersons = [personString componentsSeparatedByString:@"\r"];
        NSMutableArray *completedAPerson = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < tempPersons.count; i++) {
            NSArray *tempAPerson = [tempPersons[i] componentsSeparatedByString:@","];
            
            NSMutableDictionary *attributeOfAPerson = [[NSMutableDictionary alloc] init];
            [attributeOfAPerson setObject:tempAPerson[0] forKey:@"name"];
            [attributeOfAPerson setObject:tempAPerson[1] forKey:@"personNumber"];
            [attributeOfAPerson setObject:tempAPerson[2] forKey:@"gender"];
            [attributeOfAPerson setObject:tempAPerson[3] forKey:@"personTeam"];
            
            [completedAPerson addObject:attributeOfAPerson];
        }
        _persons = completedAPerson;
        
    } else {
        
        NSLog(@"error 났어요. %@", error);
        
    }
}
@end
