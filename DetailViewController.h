//
//  DetailViewController.h
//  SampleFMDB00
//
//  Created by MacPro01 on 2013/10/30.
//  Copyright (c) 2013年 eyoneya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artist.h"

@interface DetailViewController : UIViewController
{
    Artist *artist;
    UILabel *name;
    UILabel *genre;
    UILabel *origin;
    UILabel *yearsActive;
}
@property (nonatomic, retain) Artist *artist;
@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UILabel *genre;
@property (nonatomic, retain) IBOutlet UILabel *origin;
@property (nonatomic, retain) IBOutlet UILabel *yearsActive;
/*
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *genre;
@property (weak, nonatomic) IBOutlet UILabel *origin;
@property (weak, nonatomic) IBOutlet UILabel *yearsActive;
*/
@end
