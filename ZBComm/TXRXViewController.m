/**
 * ZBModule Demo Project
 * Code for ZBModule transparent data transmission.
 * Created on: 15/07/13
 * Blog : http://blog.csdn.net/u011341435
 * Copyright 2013 Cole Yu <gzble@qq.com>
 * QQ: <2843127527>
 * TaoBao:< http://antek.taobao.com/ >
 */

#import "TXRXViewController.h"

@interface TXRXViewController ()

@end

@implementation TXRXViewController
@synthesize gSendTxt;
@synthesize gTxMethord;
@synthesize gConDev;
@synthesize gNavigationBar;
@synthesize gRecvTxt;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    gSendTxt.delegate = self;
    gRecvTxtStr =[[NSMutableString alloc] initWithString:@""];
    gTxMethord.hidden = YES;
    
    t = [bluekitBle getSharedInstance];//get bluekit instance
    [t controlSetup:1];//set up bluekit
    t.delegate = self;// set delegate
    gRecvTxt.text = @"";

    if(gConDev!=nil)
    {
        gNavigationBar.title = gConDev.name;
        [t connectPeripheral:gConDev]; //connect to bluekit
    }
    [NSTimer scheduledTimerWithTimeInterval:(float)1 target:self selector:@selector(RssiReadTimer:) userInfo:nil repeats:YES];//set rssi reader timer
    //NSLog(gConDev.name);
}

-(void) RssiReadTimer:(NSTimer *)timer
{
  if(t.activePeripheral!=nil)
  {
      [t myReadRssi];
  }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//limit length of send string
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 16)
    return NO;
	else
    return YES;
}

-(void) RxValueUpdate:(Byte *)buf
{
    if (t.activePeripheral != nil)
    {
        NSLog(@"RxValueUpdate");
        NSString *recvPkt = [NSString stringWithCString:(char*)buf encoding:NSASCIIStringEncoding];
        
       
        gRecvTxtStr = [gRecvTxtStr stringByAppendingString:recvPkt];
        
        NSLog(@"%@", gRecvTxtStr);
        gRecvTxt.text = gRecvTxtStr;
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

-(void) bluekitDisconnect
{   
}

-(void) updateRssiValue:(int)rssi
{
    NSString *rssiStr ;
    rssiStr = [NSString stringWithFormat:@"%ddBm",rssi];
    gNavigationBar.rightBarButtonItem.title = rssiStr;
}

-(void) blueConnect
{
    
}

- (IBAction)doSend:(id)sender
{
    if(t.activePeripheral!=nil)
    {
        NSString *TxData = gSendTxt.text;
        NSData *aData = [TxData dataUsingEncoding:NSUTF8StringEncoding];
        [t writeDataToSscomm:aData];
    }
}

- (IBAction)doClean:(id)sender
{
    gRecvTxt.text=@"";
    gRecvTxtStr = @"";
}

- (IBAction)doDisconnect:(id)sender
{
    if(t.activePeripheral!=nil)
    {
        [t cancelConnectPeripheral];
        gNavigationBar.rightBarButtonItem.title = @"RSSI";
        gNavigationBar.title = @"Disconnected";
    }
}
@end
