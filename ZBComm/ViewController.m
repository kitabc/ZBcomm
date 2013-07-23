/**
 * ZBModule Demo Project
 * Code for ZBModule transparent data transmission.
 * Created on: 15/07/13
 * Blog : http://blog.csdn.net/u011341435
 * Copyright 2013 Cole Yu <gzble@qq.com>
 * QQ: <2843127527>
 * TaoBao:< http://antek.taobao.com/ >
 */
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize list = _list;
@synthesize gDevView;
@synthesize myIndicator;
@synthesize gSelectDev;

#define SearchTimeOut 1

- (void)viewDidLoad
{
    [super viewDidLoad];
    t = [bluekitBle getSharedInstance];    
    [t controlSetup:1];
    t.delegate = self;
    myIndicator.hidden = YES;
    isConnect = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if(t.peripherals!=nil)
    {
        return [t.peripherals count];
    }
    else
    {
		return 0;
	}
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:TableSampleIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    
    CBPeripheral *p = [t.peripherals objectAtIndex:row];
    
    cell.textLabel.text = p.name;
    
    CFStringRef sKey = CFUUIDCreateString(NULL, p.UUID);
    NSString  *changeUUIDToStr = [[NSString  alloc]initWithCString:CFStringGetCStringPtr(sKey, 0)
                                                          encoding:NSUTF8StringEncoding];
    cell.detailTextLabel.text = changeUUIDToStr;

	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    gSelectDev = [t.peripherals objectAtIndex:[indexPath row]];
    [self performSegueWithIdentifier:@"TXRX" sender:self];
}

- (IBAction)doSearchDev:(id)sender
{
    [myIndicator startAnimating];
    myIndicator.hidden = NO;
    [self DoSearch];
}

-(void)bluekitDisconnect
{
    NSLog(@"bluekitDisconnect");
}

-(void) RxValueUpdate:(Byte *)buf
{
    if (t.activePeripheral != nil)
    {
        NSLog(@"connect!");
    }
}

-(void) deviceFoundUpdate:(CBPeripheral *)p
{
    printf("Do device Found Update");
}

-(void) disconnectBle
{
    [t cancelConnectPeripheral];
}

-(void) DoSearch
{
    t.peripherals = nil;
    
    [gDevView reloadData];
    
    if (t.activePeripheral)
    {
        [t cancelConnectPeripheral];
        t.peripherals = nil;
    }
    [t findBLEPeripherals:SearchTimeOut];
    [NSTimer scheduledTimerWithTimeInterval:(float)SearchTimeOut target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
}

-(void) connectionTimer:(NSTimer *)timer
{
    [myIndicator stopAnimating];
    myIndicator.hidden = YES;
	[gDevView reloadData];	
}

-(void)ShowMessage:(NSString *) title msg:(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:@"Cancle", nil];
    [alert show];
}

-(void)doStopIndicator{
    
    [myIndicator stopAnimating];
    myIndicator.hidden = YES;

    if(t.activePeripheral !=nil)
    {
        NSLog(@"Connected!");
    }
    else
    {
        NSLog(@"Disconnect");
    }
    
    
}

- (IBAction)doDeviceConnect:(id)sender {
    
    t = [bluekitBle getSharedInstance];
    if(t.activePeripheral)
    {
        [t controlSetup:1];
        t.delegate = self;
        [t cancelConnectPeripheral];
    }
    else
    {
        [self DoSearch];
        // myIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        myIndicator.hidden = NO;
        [myIndicator startAnimating];
        [self performSelector:@selector(doStopIndicator) withObject:nil afterDelay:5.0];
        
    }
}

-(void) updateRssiValue:(int)rssi
{
    
}
-(void) blueConnect
{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"TXRX"]) 
    {
        if(gSelectDev!=nil)
        {
            id theSegue=segue.destinationViewController;
            [theSegue setValue:gSelectDev forKey:@"gConDev"];
        }
    }
}

@end
