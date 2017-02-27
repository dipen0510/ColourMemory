//
//  SharedClass.m
//  PampersRewards
//
//  Created by Dipen Sekhsaria on 03/11/15.
//  Copyright © 2015 ProcterAndGamble. All rights reserved.
//

#import "SharedClass.h"

@implementation SharedClass

static SharedClass *singletonObject = nil;


+ (id)sharedInstance {
    //static MyManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonObject = [[self alloc] init];
    });
    return singletonObject;
}



- (id)init
{
    if (! singletonObject) {
        
        singletonObject = [super init];
        // Uncomment the following line to see how many times is the init method of the class is called
        // //NSLog(@"%s", __PRETTY_FUNCTION__);
    }
    return singletonObject;
}

#pragma mark - Score Handlers

- (void) insertNewHighScoreEntryWithName:(NSString *) name andScore:(NSString *) score {
    
    NSString* highStr = [self loadHighScoreData];
    NSMutableArray *jsonObject = [[NSMutableArray alloc] init];
    
    NSMutableDictionary* newDict = [[NSMutableDictionary alloc] init];
    [newDict setObject:name forKey:@"name"];
    [newDict setObject:score forKey:@"score"];
    
    if (highStr) {
        jsonObject = [[NSMutableArray alloc] initWithArray:[NSJSONSerialization JSONObjectWithData:[highStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL]];
    }
    
    [jsonObject addObject:newDict];
    [self sortHighScores:jsonObject];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:nil];
    [self saveHighScoreData:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
    
}

- (NSMutableArray *) getAllHighScoreEntries {
    
    NSString* highStr = [self loadHighScoreData];
    NSMutableArray *jsonObject = [[NSMutableArray alloc] init];
    
    if (highStr) {
        jsonObject = [[NSMutableArray alloc] initWithArray:[NSJSONSerialization JSONObjectWithData:[highStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL]];
    }
    
    return jsonObject;
    
}

- (void) sortHighScores:(NSMutableArray *)scoreArr {
    
    [scoreArr sortUsingComparator:^NSComparisonResult(NSMutableDictionary *dict1, NSMutableDictionary *dict2) {
        return [[dict2 valueForKey:@"score"] compare:[dict1 valueForKey:@"score"] options:(NSNumericSearch)];
    }];
    
}


#pragma mark - Local Storage Handling

- (void)saveHighScoreData: (NSString*)data
{
    if (data != nil)
    {
        [self removeHighScoreData];
        
        NSString *documentsDirectory = [self getDocumentDirectoryPath];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"highscores.txt"] ];
        
        [data writeToFile:path atomically:YES
                 encoding:NSUTF8StringEncoding error:nil];
    }
}

- (NSString*)loadHighScoreData
{
    NSString *documentsDirectory = [self getDocumentDirectoryPath];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithFormat:@"highscores.txt"] ];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    return content;
}

- (void)removeHighScoreData
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [self getDocumentDirectoryPath];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithFormat:@"highscores.txt"] ];
    
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:path error:&error];
    if (success) {
        NSLog(@"Successfully Removed %@",[error localizedDescription]);
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}


- (NSString *) getDocumentDirectoryPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
    
}

#pragma mark - Data Manipulator

- (NSMutableDictionary *) getDictionaryFromJSONString:(NSString *)jsonString {
    
    NSError* e;
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
    
    return dict;
    
}

@end
