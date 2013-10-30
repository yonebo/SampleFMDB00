//
//  Artist.h
//  SampleFMDB00
//
//  Created by MacPro01 on 2013/10/30.
//  Copyright (c) 2013年 eyoneya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artist : NSObject
{
    NSString *id;
    NSString *name;
    NSString *genre;
    NSString *origin;
    NSString *yearsactive;
}

@property(nonatomic, retain)NSString *id;
@property(nonatomic, retain)NSString *name;
@property(nonatomic, retain)NSString *genre;
@property(nonatomic, retain)NSString *origin;
@property(nonatomic, retain)NSString *yearsactive;

@end
