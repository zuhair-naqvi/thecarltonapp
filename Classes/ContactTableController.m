//
//  ContactTableController.m
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 27/11/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "ContactTableController.h"


@implementation ContactTableController

@synthesize contactMenu;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
//    if ((self = [super initWithStyle:style])) {
//		//self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"bg.jpg"]]; 		
//    }
	contactMenu = [[NSMutableArray alloc] init];
	
	
	[contactMenu addObject:@"Telephone: (03) 9663 3246"];
	[contactMenu addObject:@"Email: manager@thecarlton.com.au"];
	[contactMenu addObject:@"Visit: www.thecarlton.com.au"];
	[contactMenu addObject:@"Locate"];
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.view.backgroundColor = [UIColor clearColor];
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
    return [contactMenu count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
	cell.contentView.alpha = 0.6;
	
	UIView *v = [[[UIView alloc] init] autorelease];
	v.backgroundColor = [UIColor colorWithRed:0.700 green:0.168 blue:0.425 alpha:1.5];
	
	// Configure the cell...
	cell.selectedBackgroundView = v;
	UIFont *cellFont = [UIFont fontWithName:@"TrebuchetMS" size:16.0];
	cell.textLabel.textColor = [UIColor blackColor];
	cell.textLabel.font = cellFont;
	NSString *cellValue = [contactMenu objectAtIndex:indexPath.row];
	cell.textLabel.text = cellValue;
    
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

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		switch (alertView.tag) {
			case 1:
				[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0396633246"]];
				break;
			case 2:
				[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:manager@thecarlton.com.au"]];
				break;
			case 3:
				[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.thecarlton.com.au"]];
				break;
			case 4:
				[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:@"tt://locate"] applyAnimated:YES]];
				break;
				
			default:
				break;
		}
	}
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//NSMutableArray *selectedItem = [contactMenu objectAtIndex:indexPath.row];
	int row = indexPath.row;
	NSLog(@"opt %d", row);

	switch (row) {
		case 0:
		{
			//NSLog(@"phone");
			UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Call us?" message:@"This will take you outside The Carlton app, are you sure?" delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:nil] autorelease];
			[alert setTag:1];
			[alert addButtonWithTitle:@"Call"];		
			[alert show];
			break;
		}
		case 1:
		{
			//NSLog(@"email");
			UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Email us?" message:@"This will take you outside The Carlton app, are you sure?" delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:nil] autorelease];
			[alert setTag:2];
			[alert addButtonWithTitle:@"Email"];		
			[alert show];
			break;
		}
		case 2:
		{
			//NSLog(@"website");
			UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Visit website?" message:@"This will take you outside The Carlton app, are you sure?" delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:nil] autorelease];
			[alert setTag:3];
			[alert addButtonWithTitle:@"Visit"];		
			[alert show];
			break;
		}
		case 3:
		{
			//NSLog(@"map");
			[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:@"tt://locate"] applyAnimated:YES]];
			break;			
		}		default:
			break;
	}
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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
	[contactMenu release];
    [super dealloc];
}


@end

