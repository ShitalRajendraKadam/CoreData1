//
//  ViewController.m
//  IOS_CoreData1
//
//  Created by Student P_02 on 18/06/18.
//  Copyright © 2018 Shital. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Fetch];
    // Do any additional setup after loading the view, typically from a nib.
   /* self.itemNameArray=[[NSArray alloc]init];
    self.itemRateArray=[[NSArray alloc]init];
    
    [self.ItemNameTextField becomeFirstResponder];
   // self.ItemRateTextField.delegate=self;
    //self.ItemNameTextField.delegate=self;
    self.SearchItemTextField.delegate=self;
    
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[delegate managedObjectContext];
    NSError *error;
    NSObject *myobject;
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Items" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    if(self.SearchItemTextField.text.length>0)
    {
        //NSPredicate *namePredicate=[NSPredicate predicateWithFormat:@"(itemName contains[cd]      %@)",self.SearchItemTextField.text];
       // [request setPredicate:namePredicate];
    }
    self.allObjects=[context executeFetchRequest:request error:&error];
//    if(self.allObjects.count==1)
//    {
//        myobject=[self.allObjects firstObject];
//        NSString *name,*rate;
//        name=[myobject valueForKey:@"itemName"];
//        self.ItemNameTextField.text=[myobject valueForKey:@"itemName"];
//        //id object=[myobject valueForKey:@"itemRate"];
//        rate=[myobject valueForKey:@"itemRate"];
//        self.ItemRateTextField.text=[NSString stringWithFormat:@"%@",rate];
//    }
//    else
//    {
    NSLog(@"%@",self.allObjects);
    self.itemNameArray=[self.allObjects valueForKey:@"itemName"];
    self.itemRateArray=[self.allObjects valueForKey:@"itemRate"];
    NSLog(@"NamesArray:%@",self.itemNameArray);
    NSLog(@"itemRateArray:%@",self.itemRateArray);
   // [self.myTableView reloadData];
   // }*/
    
    
}

-(void)Fetch
{
    self.itemNameArray=[[NSArray alloc]init];
    self.itemRateArray=[[NSArray alloc]init];
    
    [self.ItemNameTextField becomeFirstResponder];
        self.SearchItemTextField.delegate=self;
    
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[delegate managedObjectContext];
    NSError *error;
    //NSObject *myobject;
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Items" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    if(self.SearchItemTextField.text.length>0)
    {
        //NSPredicate *namePredicate=[NSPredicate predicateWithFormat:@"(itemName contains[cd]      %@)",self.SearchItemTextField.text];
        // [request setPredicate:namePredicate];
    }
    self.allObjects=[context executeFetchRequest:request error:&error];
    //    if(self.allObjects.count==1)
    //    {
    //        myobject=[self.allObjects firstObject];
    //        NSString *name,*rate;
    //        name=[myobject valueForKey:@"itemName"];
    //        self.ItemNameTextField.text=[myobject valueForKey:@"itemName"];
    //        //id object=[myobject valueForKey:@"itemRate"];
    //        rate=[myobject valueForKey:@"itemRate"];
    //        self.ItemRateTextField.text=[NSString stringWithFormat:@"%@",rate];
    //    }
    //    else
    //    {
    NSLog(@"%@",self.allObjects);
    self.itemNameArray=[self.allObjects valueForKey:@"itemName"];
    self.itemRateArray=[self.allObjects valueForKey:@"itemRate"];
    NSLog(@"NamesArray:%@",self.itemNameArray);
    NSLog(@"itemRateArray:%@",self.itemRateArray);
    // [self.myTableView reloadData];
    // }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)updateObject
{
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[delegate managedObjectContext];
    NSPredicate *namePredicate=[NSPredicate predicateWithFormat:@"(itemName contains[cd] %@)",self.ItemNameTextField.text];
    NSError *error;
    //NSObject *myobject;
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Items" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    [request setPredicate:namePredicate];
    NSArray *allObjects=[context executeFetchRequest:request error:&error];
    if(allObjects.count==1)
    {
        NSManagedObject  *myobject=[allObjects firstObject];
        NSString *name,*rate;
        name=self.ItemNameTextField.text;
        rate=self.ItemRateTextField.text;
        NSNumberFormatter *f=[[NSNumberFormatter alloc]init];
        f.numberStyle=NSNumberFormatterDecimalStyle;
        NSNumber *myNumber= [f numberFromString: self.ItemRateTextField.text];
        [myobject setValue:name forKey:@"itemName"];
        [myobject setValue:myNumber forKey:@"itemRate"];
        [context save:&error];
    }

}

-(void)deleteObject
{
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[delegate managedObjectContext];
    NSPredicate *namePredicate=[NSPredicate predicateWithFormat:@"(itemName contains[cd] %@)",self.ItemNameTextField.text];
    NSError *error;
    NSManagedObject *myobject;
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Items" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    [request setPredicate:namePredicate];
    NSArray *allObjects=[context executeFetchRequest:request error:&error];
    if(allObjects.count>=1)
    {
        myobject=[allObjects firstObject];
        [context deleteObject:myobject];
        [context save:&error];

    }
    else{
        NSLog(@"Deletion Failed");
    }

}
-(void)insertObject
{
    NSError *error;
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[delegate managedObjectContext];
    NSManagedObject *Object=[NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
    [Object setValue:self.ItemNameTextField.text forKey:@"itemName"];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:self.ItemRateTextField.text];
    [Object setValue:myNumber forKey:@"itemRate"];
    [context save:&error];
    self.ItemNameTextField.text=@"";
    self.ItemRateTextField.text=@"";
        [self.myTableView reloadData];

}






- (IBAction)InsertButtonAction:(id)sender
{
    [self insertObject];
    NSLog(@"Core Data-Insert:Success");
    [self Fetch];
    [self.myTableView reloadData];


}

- (IBAction)UpdateButtonAction:(id)sender
{
    [self updateObject];
    NSLog(@"Update:Success");
    [self Fetch];

    [self.myTableView reloadData];
}

- (IBAction)DeleteButtonAction:(id)sender
{
    [self deleteObject];
    NSLog(@"Core Data-Delete:Success");
    [self Fetch];
    [self.myTableView reloadData];

}
-(bool)textFieldShouldReturn:(UITextField *)textField
{
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[delegate managedObjectContext];
    NSError *error;
    NSObject *myobject;
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Items" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    if(textField.text.length>0)
    {
        NSPredicate *namePredicate=[NSPredicate predicateWithFormat:@"(itemName contains[cd]      %@)",textField.text];
        [request setPredicate:namePredicate];
    }
    self.allObjects=[context executeFetchRequest:request error:&error];
    if(self.allObjects.count >0)
    {
        myobject=[self.allObjects firstObject];
        NSString *name,*rate;
        name=[myobject valueForKey:@"itemName"];
        self.ItemNameTextField.text=[myobject valueForKey:@"itemName"];
        //id object=[myobject valueForKey:@"itemRate"];
        rate=[myobject valueForKey:@"itemRate"];
        self.ItemRateTextField.text=[NSString stringWithFormat:@"%@",rate];
    }
    else{
    }
    NSLog(@"%@",self.allObjects);
    self.itemNameArray=[self.allObjects valueForKey:@"itemName"];
    self.itemRateArray=[self.allObjects valueForKey:@"itemRate"];
    NSLog(@"NamesArray:%@",self.itemNameArray);
    NSLog(@"itemRateArray:%@",self.itemRateArray);
    [self.myTableView reloadData];
    return YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemNameArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text=[self.itemNameArray objectAtIndex:indexPath.row];
    id rate=[self.itemRateArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",rate];
    
    return cell;
}



@end
