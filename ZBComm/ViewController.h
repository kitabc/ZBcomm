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
#import "bluekitBle.h"
#import <CoreBluetooth/CBPeripheral.h>

@interface ViewController : UIViewController<blueKitBLEDelegate,UITableViewDelegate, UITableViewDataSource>
{
    bluekitBle *t;
    Boolean isConnect;
}
@property (strong, nonatomic) NSArray *list;  
@property (weak, nonatomic) IBOutlet UITableView *gDevView;
- (IBAction)doSearchDev:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myIndicator;
@property (weak, nonatomic) IBOutlet CBPeripheral *gSelectDev;

@end
