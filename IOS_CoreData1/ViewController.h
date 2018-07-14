//
//  ViewController.h
//  IOS_CoreData1
//
//  Created by Student P_02 on 18/06/18.
//  Copyright © 2018 Shital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *SearchItemTextField;

@property (weak, nonatomic) IBOutlet UITextField *ItemNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ItemRateTextField;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)InsertButtonAction:(id)sender;
- (IBAction)UpdateButtonAction:(id)sender;

- (IBAction)DeleteButtonAction:(id)sender;

@property NSArray *allObjects;
@property NSArray *itemNameArray;
@property NSArray *itemRateArray;

@property NSManagedObjectContext *context;

@end

