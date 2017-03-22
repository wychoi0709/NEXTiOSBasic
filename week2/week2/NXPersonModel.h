//
//  NXPersonModel.h
//  week2
//
//  Created by 최원영 on 2017. 3. 22..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXPersonModel : NSObject

@property NSArray *persons;
@property NSNumberFormatter *f;

- (NSString*)personNameAtIndex:(int)index;
- (NSNumber*)personNumberAtIndex:(int)index;
- (BOOL)isMaleAtIndex:(int)index;
- (NSNumber*)personTeamAtIndex:(int)index;
- (NSDictionary*)getPersonObjectAtIndex:(int)index;
- (NSString*) findPersonNameByNumber:(NSNumber*)number;
- (NSNumber*) findPersonNumberByName:(NSString*)name;

- (NSArray*) sortedByName;
- (NSArray*) sortedByNumber;
- (NSArray*) sortedByTeam;

- (NSArray*) filterByTeam:(NSNumber*)team;
- (NSArray*) filterByGender:(BOOL)isMale;

- (NSArray*) filterDistinctByLastName;

@end
