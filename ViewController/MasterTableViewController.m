//
//  MasterTableViewController.m
//  SampleFMDB00
//
//  Created by MacPro01 on 2013/10/30.
//  Copyright (c) 2013年 eyoneya. All rights reserved.
//

#import "MasterTableViewController.h"
#import "Artist.h"
#import "DetailViewController.h"

@interface MasterTableViewController ()

@end

@implementation MasterTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Master";
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"sample.sqlite"];
    BOOL success = [fileManager fileExistsAtPath:writableDBPath];
    if (!success){
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"sample.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    }
    if (!success){
        NSAssert1(0, @"failed to create writable db file with message '%@'.", [error localizedDescription]);
    }
    
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    if (![db open])
    {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
    [db setShouldCacheStatements:YES];
    
    NSString* sql = @"SELECT * FROM artist;";
    FMResultSet* rs = [db executeQuery:sql];
    mArtists = [[NSMutableArray alloc] init];
    while ( [rs next] )
    {
        Artist * artist = [[Artist alloc] init];
        //artist.id = [rs intForColumn:@"artistid"];
        artist.id = [rs stringForColumn:@"artistid"];
        artist.name = [rs stringForColumn:@"artistname"];
        artist.genre = [rs stringForColumn:@"genre"];
        artist.origin = [rs stringForColumn:@"origin"];
        artist.yearsactive = [rs stringForColumn:@"yearsactive"];
        [mArtists addObject:artist];
        
    }
    
    [rs close];
    [db close];
    
    // ここまで！==============
}

/*　いらないみたい　=====
 
 - (void)viewDidUnload
 {
 [super viewDidUnload];
 // Release any retained subviews of the main view.
 // e.g. self.myOutlet = nil;
 }
 

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)InterfaceOrientation
{
    return (InterfaceOrientation == UIInterfaceOrientationPortrait);
}
=====　ここまで　*/

#pragma mark - Table view data source

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [mArtists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    // ここから===========
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Artist *artist = [mArtists objectAtIndex:indexPath.row];
    cell.textLabel.text = artist.name;
    cell.detailTextLabel.text = artist.genre;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // ここまで===========
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

// ここから=====
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    detailViewController.title = @"Detail";
    detailViewController.artist = [mArtists objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
// ここまで=====

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
