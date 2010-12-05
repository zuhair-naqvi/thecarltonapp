//
//  MenuRootViewController.m
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 4/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "MenuRootViewController.h"
#import "DetailViewController.h"

@implementation MenuRootViewController


@synthesize tableDataSource, CurrentTitle, CurrentLevel, responseData;

#pragma mark -
#pragma mark View lifecycle

//- (void) viewWillAppear:(BOOL)animated
//{
//	self.tableView.frame = CGRectMake(0, 65, TTScreenBounds().size.width, (TTScreenBounds().size.height - 140));
//}

- (void)viewDidLoad {
    [super viewDidLoad];
	UIEdgeInsets inset = UIEdgeInsetsMake(75, 0, 0, 0);
	self.tableView.contentInset = inset;	
	UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
	[logoView setCenter:CGPointMake((TTScreenBounds().size.width/2),-40.0)];
	[self.tableView addSubview:logoView];
	self.tableView.separatorColor = [UIColor grayColor];
	self.tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"bg.jpg"]];
	
	
    if(CurrentLevel == 0) {
		
		//Initialize our table data source
		NSArray *tempArray = [[NSArray alloc] init];
		self.tableDataSource = tempArray;
		[tempArray release];
		
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		NSURL *plistUrl = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"http://%@/front_dev.php/menu/plist", [prefs stringForKey:@"server"]]];
		NSURLRequest *request=[NSURLRequest requestWithURL:plistUrl
												  cachePolicy:NSURLRequestUseProtocolCachePolicy
											  timeoutInterval:60];
		
		NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
		
		self.navigationItem.title = @"Loading...";
	}
	else 
	{
		self.navigationItem.title = CurrentTitle;
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [responseData release];
    [connection release];
	self.navigationItem.title = @"No Internet Connection";	
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.700 green:0.168 blue:0.015 alpha:7.5]; 

    //[textView setString:@"Unable to fetch data"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
	self.navigationItem.title = @"Food & Drings";	
//    NSLog(@"Succeeded! Received %d bytes of data",[responseData
//                                                   length]);
//    NSString *txt = [[[NSString alloc] initWithData:responseData encoding: NSASCIIStringEncoding] autorelease];
	NSString *listFile = [[[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding] autorelease];
	NSDictionary *tempDict = [[NSDictionary alloc] initWithDictionary:[listFile propertyList]];
	self.tableDataSource = [tempDict objectForKey:@"Rows"];
	[self.tableView reloadData];
	
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.tableDataSource count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Cell data
	NSDictionary *dictionary = [self.tableDataSource objectAtIndex:indexPath.row];
	
    // Configure the cell...
		
	
//	cell.contentView.backgroundColor = [UIColor clearColor];
//	cell.contentView.alpha = 0.6;
	
	
	UIView *v = [[[UIView alloc] init] autorelease];
	v.backgroundColor = [UIColor colorWithRed:0.700 green:0.168 blue:0.425 alpha:1.5];
	
	cell.selectedBackgroundView = v;
	UIFont *cellFont = [UIFont fontWithName:@"TrebuchetMS" size:16.0];
	cell.textLabel.textColor = [UIColor whiteColor];
	cell.textLabel.font = cellFont;
	cell.textLabel.text = [dictionary objectForKey:@"Title"];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	//Get the dictionary of the selected data source.
	NSDictionary *dictionary = [self.tableDataSource objectAtIndex:indexPath.row];
	
	//Get the children of the present item.
	NSArray *Children = [dictionary objectForKey:@"Children"];
	
	if([Children count] == 0) {
		
		DetailViewController *dvController = [[DetailViewController alloc] initWithNibName:@"DetailView" bundle:[NSBundle mainBundle]];
		dvController.navigationItem.title = [dictionary objectForKey:@"Title"];
		dvController.itemDesc = [dictionary objectForKey:@"ItemDesc"];
		dvController.itemPic = [dictionary objectForKey:@"ItemPic"];
		[self.navigationController pushViewController:dvController animated:YES];
		[dvController release];
	}
	else {
		
		//Prepare to tableview.
		MenuRootViewController *rvController = [[MenuRootViewController alloc] initWithNibName:@"MenuRootViewController" bundle:[NSBundle mainBundle]];
		
		//Increment the Current View
		rvController.CurrentLevel += 1;
		
		//Set the title;
		rvController.CurrentTitle = [dictionary objectForKey:@"Title"];
		
		//Push the new table view on the stack
		[self.navigationController pushViewController:rvController animated:YES];
		
		rvController.tableDataSource = Children;
		
		[rvController release];
	}	
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[responseData release];
	[CurrentTitle release];
	[tableDataSource release];
    [super dealloc];
}


@end

