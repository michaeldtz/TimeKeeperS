	//
	//  RootViewController.m
	//  Team Communicator
	//
	//  Created by Michael Dietz on 16.04.10.
	//  Copyright __MyCompanyName__ 2010. All rights reserved.
	//

#import "MainViewController.h"
#import "ItemCreateViewController.h"
#import "PersonalRecordingItem.h"
#import "ImageScaler.h"
#import "UIImage+UIImageUtils.h"
#import "PersonalTimeRecord.h"
#import "ItemViewController.h"
#import "PersonalRecordingItem.h"
#import "ExportHandler.h"
#import "BarChartViewController.h"
#import "SettingsView.h"
#import "ItemTypeManager.h"
#import "ChartHandler.h"

@implementation MainViewController

@synthesize squareView,listView;

- (void)viewDidLoad {
		//Prepare Image
	NSString *path = [[NSBundle mainBundle] pathForResource:@"chart_pie" ofType:@"png"]; 
	UIImage *image = [UIImage imageWithContentsOfFile:path]; 
	
		//Set Buttons and Background Color
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(askForType)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(showAnalytics)];
	
		//Bouncing 
	squareView.bounces = YES;
	squareView.alwaysBounceVertical = YES;
	[self refreshSquarePane];
}

-(void)viewWillAppear:(BOOL)animated{
	self.navigationItem.titleView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"slogo.png"]];

	
	BOOL listViewActive = [[NSUserDefaults standardUserDefaults] boolForKey:@"LISTVIEW"];
	if(listViewActive == YES){
		listView.alpha = 1;
		squareView.alpha = 0;
	}		else {
		listView.alpha = 0;
		squareView.alpha = 1;	
	}
}

-(void)viewDidAppear:(BOOL)animated{
	[self refreshSquarePane];
	[listView reloadData];
}

#pragma mark AddAction

-(void)askForType{
	UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"What kind of recording item would you like to create?", @"") delegate:self cancelButtonTitle:nil destructiveButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:nil];
	
	ItemTypeManager* itemTypMg = [ItemTypeManager getInstance];
	for(int i = 0; i < [itemTypMg.itemTypes count]; i++){
		[sheet addButtonWithTitle:[ItemTypeManager text4ItemType:i] ];
	}	
	
	sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[sheet showInView:self.view];
	[sheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
		ItemCreateViewController* tvController = [[ItemCreateViewController alloc] initWithNibName:@"ItemCreateView" bundle:nil];
		tvController.delegate = self;
		tvController.itemType = buttonIndex - 1;
		[self presentModalViewController:tvController animated:YES];
		[tvController release];
	}
}

#pragma mark UIActions

-(IBAction)showAnalytics{
    ChartHandler* handler = [[ChartHandler alloc] initWithViewController:self];
    [handler startChartView];
}

-(IBAction)openExportAll{
    ExportHandler* handler = [[ExportHandler alloc] initWithViewController:self];
    [handler prepareExport:nil];
}

-(IBAction)changeViewType{
	
	BOOL listViewActive = [[NSUserDefaults standardUserDefaults] boolForKey:@"LISTVIEW"];
	[UIView beginAnimations:@"CHANGEVIEWTYPE" context:nil];
	[UIView setAnimationDuration:0.6];
	
	if(listViewActive == NO){
		listViewActive = YES;
		listView.alpha = 1;
		squareView.alpha = 0;
		[self refreshSquarePane];
	} else {
		listViewActive = NO;
		listView.alpha = 0;
		squareView.alpha = 1;
		[listView reloadData];
	}
	
	[UIView commitAnimations];
	[self refreshSquarePane];
	[listView reloadData];
	
	[[NSUserDefaults standardUserDefaults] setBool:listViewActive forKey:@"LISTVIEW"];
}

-(void)openRecordingItem:(id)eventObject{
	UIButton* button = (UIButton*) eventObject;
	NSArray* teamList = [CacheDataManager loadItemList];
	PersonalRecordingItem* team = [teamList objectAtIndex:button.tag];
	[team retain];
	
	self.navigationItem.title = NSLocalizedString(@"Back", @"");
	ItemViewController* controller = [[ItemViewController alloc] initWithNibName:@"ItemViewNew" bundle:nil];
	controller.recordingitem = team;
	
	[self.navigationController pushViewController:controller animated:YES];
	
}

#pragma mark Show About Screen and Closer

-(IBAction)showAbout{
	AboutViewController* creditsViewController = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
	creditsViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	creditsViewController.delegate = self;
	[self presentModalViewController:creditsViewController animated:YES];
}

- (void)closeModalScreen:(UIViewController *)controller{
	[self dismissModalViewControllerAnimated:YES];
	[self refreshSquarePane];
}

#pragma mark RefreshUI

-(void)refreshSquarePane{
	NSArray* itemList = [CacheDataManager loadItemList];
	
	for(int i = 0; i < 9; i++){
		if(i >= [itemList count]){
			[[self.squareView.subviews objectAtIndex:i] setHidden:YES] ;
			[[self.squareView.subviews objectAtIndex:i+9] setHidden:YES] ;
			[[self.squareView.subviews objectAtIndex:i+18] setHidden:YES] ;
			[[self.squareView.subviews objectAtIndex:i+27] setHidden:YES] ;
		} else {			
			PersonalRecordingItem* team  = (PersonalRecordingItem*)[itemList objectAtIndex:i];
			
			UIButton* imageButton = (UIButton*)[self.squareView.subviews objectAtIndex:i];
			[imageButton addTarget:self action:@selector(openRecordingItem:) forControlEvents:UIControlEventTouchDown];
			imageButton.hidden = NO;
			imageButton.tag = i;
			
				//Image
			if(team.image != nil)
				[imageButton setBackgroundImage:team.image forState:UIControlStateNormal];
			
				//Label
			UILabel* label = (UILabel*)[self.squareView.subviews objectAtIndex:i+9];
			label.text     = team.name;
			label.hidden   = NO;
			
				//Type Label
			UILabel* typeLabel = (UILabel*)[self.squareView.subviews objectAtIndex:i+18];
			typeLabel.text     = [ItemTypeManager text4ItemType:team.type];
			typeLabel.hidden   = NO;
			
			if(team.startedTimeRecording > 0)
				[[self.squareView.subviews objectAtIndex:i+27] setHidden:NO] ;
			else 
				[[self.squareView.subviews objectAtIndex:i+27] setHidden:YES] ;
		}
	}
}


#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[CacheDataManager loadItemList] count];
}


	// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"RecordingItemCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
	
	PersonalRecordingItem* item = [[CacheDataManager loadItemList] objectAtIndex:indexPath.row];
	
	cell.textLabel.text = item.name;
	cell.detailTextLabel.text = [ItemTypeManager text4ItemType:item.type];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"applogo" ofType:@"png"]; 
	UIImage* defaultImage = [UIImage imageWithContentsOfFile:path]; 
	
	if(item.image == nil)
		cell.imageView.image = defaultImage;
	else 
		cell.imageView.image = item.image;	
	
	if(item.startedTimeRecording > 0){
		NSString *timerecordingstartedimagepath = [[NSBundle mainBundle] pathForResource:@"calendar_edit" ofType:@"png"]; 
		UIImage* timerecimage = [UIImage imageWithContentsOfFile:timerecordingstartedimagepath]; 
		UIImageView* imageView = [[UIImageView alloc] initWithImage:timerecimage];
		[cell addSubview:imageView];
	}
	
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	PersonalRecordingItem* item = [[CacheDataManager loadItemList] objectAtIndex:indexPath.row];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	self.navigationItem.title = NSLocalizedString(@"Back", @"");
	ItemViewController* controller = [[ItemViewController alloc] initWithNibName:@"ItemViewNew" bundle:nil];
	controller.recordingitem = item;
	
	[self.navigationController pushViewController:controller animated:YES];
}

	// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		PersonalRecordingItem* item = [[CacheDataManager loadItemList] objectAtIndex:indexPath.row];
		[CacheDataManager removeItem:item];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
	}   
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return NSLocalizedString(@"Your Recording Items", @"");
}

#pragma mark Finalizer

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	squareView = nil;
	listView = nil; 
}

- (void)dealloc {
    [super dealloc];
}


@end


