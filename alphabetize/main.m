//
//  main.m
//  Creates an alphabetized copy of a file
//
//  Created by imann24 on 6/18/16.
//  Copyright © 2016 Isaiah Mann. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString* filePrefix = @"alphabetized";
void swap (NSMutableArray * source, int index1, int index2) {

    NSString * temp = source[index1];
    source[index1] = source[index2];
    source[index2] = temp;
}

void insertionSort (NSMutableArray * source) {
    for (int i = 1; i < [source count]; i++) {
        int j = i;
        while (j > 0 && [source[j-1] compare:source[j]] == NSOrderedDescending) {
            swap(source, j-1, j);
            j--;
        }
    }
}

void removeEmptyElements (NSMutableArray * source) {
    for (int i = 0; i < [source count]; i++) {
        if ([source[i] length] == 0) {
            [source removeObjectAtIndex:i];
        }
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc >= 2) {
            // Adapated from http://stackoverflow.com/questions/18544856/accessing-arguments-with-argv-and-how-to-convert
            NSString *path = [NSString stringWithUTF8String:argv[1]];
            
            NSFileManager *filemgr;
            NSString *currentpath;
            
            filemgr = [NSFileManager defaultManager];

            currentpath = [filemgr currentDirectoryPath];
            NSString *fileName = [path lastPathComponent];
            // Adapated from http://stackoverflow.com/questions/4208552/open-file-and-read-from-file-objective-c
            NSString *fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            NSMutableArray *fileByLine = [[fileContents componentsSeparatedByString:@"\n"] mutableCopy];
            removeEmptyElements(fileByLine);
            insertionSort(fileByLine);
            
            // Adapted from: http://stackoverflow.com/questions/26112572/how-to-create-a-txt-file-programmatically-on-ios
            NSError *error;
            NSString *newFileName = [filePrefix stringByAppendingString:fileName];
            NSString *stringToWrite = [fileByLine componentsJoinedByString:@"\n"];
            NSString *filePath = [currentpath stringByAppendingPathComponent:newFileName];
            [stringToWrite writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        } else {
            NSLog(@"Please enter a file name");
        }
    }
    return 0;
}