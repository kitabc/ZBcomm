/**
 * ZBModule Demo Project
 * Code for ZBModule transparent data transmission.
 * Created on: 15/07/13
 * Blog : http://blog.csdn.net/u011341435
 * Copyright 2013 Cole Yu <gzble@qq.com>
 * QQ: <2843127527>
 * TaoBao:< http://antek.taobao.com/ >
 */

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CBPeripheral.h>
#import "bluekitBle.h"

@interface TXRXViewController : UIViewController<UITextFieldDelegate,blueKitBLEDelegate>
{
    bluekitBle *t;
    Boolean isConnect;
    NSMutableString *gRecvTxtStr;
}
@property (weak, nonatomic) IBOutlet UITextField *gSendTxt;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gTxMethord;
@property (strong, nonatomic) NSString *UUID;
@property (strong, nonatomic) CBPeripheral *gConDev;

- (IBAction)doSelectMethord:(id)sender;

@property (weak, nonatomic) IBOutlet UINavigationItem *gNavigationBar;

@property (weak, nonatomic) IBOutlet UITextView *gRecvTxt;

- (IBAction)doSend:(id)sender;
- (IBAction)doClean:(id)sender;
- (IBAction)doDisconnect:(id)sender;

@end
