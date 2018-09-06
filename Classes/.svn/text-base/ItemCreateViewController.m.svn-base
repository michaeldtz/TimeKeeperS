	//
	//  TeamView.m
	//  Team Communicator
	//
	//  Created by Michael Dietz on 16.04.10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "ItemCreateViewController.h"
#import "PersonalRecordingItem.h"
#import "ImageScaler.h"
#import "UIImage+UIImageUtils.h"
#import "ItemViewController.h"
#import "ItemTypeManager.h"

@implementation ItemCreateViewController

@synthesize itemName, itemDescription, itemImage, delegate, item, deleteButton, headerLabel, itemType, header;

#pragma mark InitializeView

	// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	if(changeMode ==YES)
	{
		itemName.text          = item.name;
		itemDescription.text   = item.description;
		itemPlannedEffort.text = [NSString stringWithFormat:@"%d", item.planEffort];
		deleteButton.hidden    = NO;
		headerLabel.text       = NSLocalizedString(@"Change Recording Item",@"");
		self.header.title      = [ItemTypeManager text4ItemType:item.type];
		
		if(item.image != nil)
			[itemImage setBackgroundImage:item.image forState:UIControlStateNormal];

	} else{
		headerLabel.text       = NSLocalizedString(@"Create new Recording Item", @"");
		self.header.title      = [ItemTypeManager text4ItemType:itemType];
	}
	
}

-(void) viewDidAppear:(BOOL)animated{
	if(pickedImage != nil)
		[itemImage setBackgroundImage:pickedImage forState:UIControlStateNormal];
}

#pragma mark TextFieldCLoser

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark Actions

-(void)done{
	
	if([itemName.text isEqualToString:@""]){
		[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Item Name", @"") message:NSLocalizedString(@"Please Enter at Least a Name",@"") delegate:self cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil] show];
	
	} else {
	
		if(changeMode == NO)
				//Create Team
			[PersonalRecordingItem createItem:itemName.text :itemDescription.text :[itemPlannedEffort.text intValue] :self.itemType :pickedImage];
		
		else {
				//Change Team
			item.name = itemName.text;
			item.description = itemDescription.text;
			item.planEffort = [itemPlannedEffort.text intValue];

				//Image
			if(pickedImage != nil)
				item.image = pickedImage;
			
				//Update Item
			[CacheDataManager saveItemList];
		}
		
		if([delegate conformsToProtocol:@protocol(ModalScreenCloser)]){
			[delegate closeModalScreen:self];		
		}
	}
}


-(IBAction)deleteItem{
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Delete Item",@"") message:NSLocalizedString(@"Do you Really Want to Delete This Item?", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Yes", @"") otherButtonTitles:NSLocalizedString(@"No", @""),nil];
	[alertView show];
	[alertView release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(imageCheck == YES){
		if(buttonIndex == 0){
			[self selectImageReally];	
		}
		imageCheck = NO;
	} else if(changeMode == YES && buttonIndex == 0){
		[CacheDataManager removeItem:item];
		if([delegate conformsToProtocol:@protocol(ModalScreenCloser)]){
			[delegate closeModalScreen:self];	
			if([delegate isKindOfClass:[ItemViewController class]]){
				ItemViewController* cont = (ItemViewController*)delegate;
				[cont.navigationController popViewControllerAnimated:YES];	
			}
			
		}
	}
}



-(void)cancel{
	if([delegate conformsToProtocol:@protocol(ModalScreenCloser)]){
		[delegate closeModalScreen:self];
	}
}


-(IBAction)selectImage{
		//Check if images are ok, or ask the user
	BOOL appLovesImages = [[NSUserDefaults standardUserDefaults] boolForKey:@"applovesimages"];
	
	if(appLovesImages == YES){
		[self selectImageReally];
	}else{
		imageCheck = YES;
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"iPhone Loves Pictures",@"") message:NSLocalizedString(@"This iPhone app would love to access your image library or make some pictures with the built-in camera!",@"") delegate:self cancelButtonTitle:NSLocalizedString(@"Me Too",@"") otherButtonTitles:NSLocalizedString(@"Not Me",@""),nil];
		[alertView show];
	}
}

-(IBAction)selectImageReally{
		//FInalize that images are ok
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"applovesimages"];
	
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
		
		UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Get Image From",@"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",@"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Camera",@""),NSLocalizedString(@"Photo Library",@""), nil];
		sheet.actionSheetStyle = UIActionSheetStyleDefault;
		[sheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
		[sheet release];
		
	} else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
		
		UIImagePickerController* picker = [[UIImagePickerController alloc] init];	
		picker.delegate = self;
		picker.title = NSLocalizedString(@"Item Photo", @"");
		picker.allowsEditing = YES;
		picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		[self presentModalViewController:picker animated:YES];
		[picker release];
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
		// the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
		UIImagePickerController* picker = [[UIImagePickerController alloc] init];	
		picker.delegate = self;
		picker.title = NSLocalizedString(@"Item Photo",@"");
		picker.allowsEditing = YES;
		picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
		[self presentModalViewController:picker animated:YES];
		[picker release];
    }
    else if (buttonIndex == 1)
    {
		UIImagePickerController* picker = [[UIImagePickerController alloc] init];	
		picker.delegate = self;
		picker.title = NSLocalizedString(@"Item Photo",@"");
		picker.allowsEditing = YES;
		picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		[self presentModalViewController:picker animated:YES];
		[picker release];
    }
}

-(void)set2ChangeMode{
	changeMode = YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)selectedImage editingInfo:(NSDictionary *)editingInfo {
	pickedImage = [selectedImage createSmallThumbnailPicWithSize:77 :1 :5 :kCGInterpolationDefault];
	[pickedImage retain];
	[self dismissModalViewControllerAnimated:YES];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
		// Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark MemoryManagement

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

- (void)dealloc {
    [super dealloc];
}


@end