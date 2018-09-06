//
//  ChartHandler.h
//  TimeKeeper
//
//  Created by Michael Dietz on 06.10.11.
//  Copyright 2011 SAP MD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChartHandler : NSObject <UIActionSheetDelegate>{
    
    UIViewController* viewController;
}

-(id)initWithViewController:(UIViewController*)aViewController;
-(IBAction)startChartView;

@end
