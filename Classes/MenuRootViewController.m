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
	self.tableView.contentInset = UIEdgeInsetsMake(75, 0, 0, 0);
	self.tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"bg.jpg"]];
	self.tableView.separatorColor = [UIColor grayColor];
	UIImageView *logoView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]] autorelease];
	[logoView setCenter:CGPointMake((self.view.bounds.size.width/2),-40)];
	[self.tableView addSubview:logoView];
	//[logoView retain];
    if(CurrentLevel == 0) {
		
		//Initialize our table data source
		NSArray *tempArray = [[NSArray alloc] init];
		self.tableDataSource = tempArray;		
		[self initMenu];
		[tempArray release];
	}
	else 
	{
		self.navigationItem.title = CurrentTitle;
	}
}

- (void) initMenu
{
	RemoteDictionary *dict = [[RemoteDictionary alloc] init];
	[dict setDelegate:self];
	[dict dictionaryFromServer:@"menu/plist"];
}

- (void) remoteDictionaryDidLoad:(NSDictionary*)dict
{
	self.tableDataSource = [dict objectForKey:@"Rows"];
	[self.tableView reloadData];
}


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
//	cell.contentView.backgroundColor = [UIColor whiteColor];
//	cell.contentView.alpha = 0.6;
	
	UIView *v = [[[UIView alloc] init] autorelease];
	v.backgroundColor = [UIColor colorWithRed:0.700 green:0.168 blue:0.425 alpha:1.5];
	
	// Configure the cell...
	cell.selectedBackgroundView = v;
	UIFont *cellFont = [UIFont fontWithName:@"TrebuchetMS" size:16.0];
	cell.textLabel.textColor = [UIColor whiteColor];
	cell.textLabel.font = cellFont;
	cell.textLabel.text = [dictionary objectForKey:@"Title"];
    [cellFont retain];	
    return cell;
}

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
    NSLog(@"Memory warning");
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

