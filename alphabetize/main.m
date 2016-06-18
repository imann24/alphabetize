//
//  main.m
//  alphabetize
//
//  Created by imann24 on 6/18/16.
//  Copyright © 2016 Isaiah Mann. All rights reserved.
//

#import <Foundation/Foundation.h>

void swap (NSMutableArray * source, int index1, int index2) {
    NSString * temp = source[0];
    source[0] = source[1];
    source[1] = temp;
}

void insertionSort (NSMutableArray * source) {
    
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc >= 2) {
            // Adapated from http://stackoverflow.com/questions/18544856/accessing-arguments-with-argv-and-how-to-convert
            NSString *path = [NSString stringWithUTF8String:argv[1]];
            NSLog([NSString stringWithFormat:@"%@\n", path]);
            
            NSFileManager *filemgr;
            NSString *currentpath;
            
            filemgr = [NSFileManager defaultManager];

            currentpath = [filemgr currentDirectoryPath];
            
            // Adapated from http://stackoverflow.com/questions/4208552/open-file-and-read-from-file-objective-c
            NSString * fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            NSMutableArray * fileLineByLine = [[fileContents componentsSeparatedByString:@"\n"] mutableCopy];
            NSLog(fileLineByLine[0]);
            swap(fileLineByLine, 0, 1);
            NSLog(fileLineByLine[0]);
        } else {
            NSLog(@"Please enter a file name");
        }
    }
    return 0;
}