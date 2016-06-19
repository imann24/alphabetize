//
//  main.m
//  alphabetize
//
//  Created by imann24 on 6/18/16.
//  Copyright © 2016 Isaiah Mann. All rights reserved.
//

#import <Foundation/Foundation.h>

void swap (NSMutableArray * source, int index1, int index2) {

    NSString * temp = source[index1];
    source[index1] = source[index2];
    source[index2] = temp;
    NSLog(@"Swapping index %d and index %d", index1, index2);
}

void insertionSort (NSMutableArray * source) {
    /*
     for i ← 1 to length(A)-1
     j ← i
     while j > 0 and A[j-1] > A[j]
     swap A[j] and A[j-1]
     j ← j - 1
     end while
     end for
     */
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
            NSLog([NSString stringWithFormat:@"%@\n", path]);
            
            NSFileManager *filemgr;
            NSString *currentpath;
            
            filemgr = [NSFileManager defaultManager];

            currentpath = [filemgr currentDirectoryPath];
            
            // Adapated from http://stackoverflow.com/questions/4208552/open-file-and-read-from-file-objective-c
            NSString * fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            NSMutableArray * fileByLine = [[fileContents componentsSeparatedByString:@"\n"] mutableCopy];
            removeEmptyElements(fileByLine);
            insertionSort(fileByLine);
        } else {
            NSLog(@"Please enter a file name");
        }
    }
    return 0;
}