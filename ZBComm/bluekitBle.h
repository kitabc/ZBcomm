/**
 * ZBModule Demo Project
 * Code for ZBModule transparent data transmission.
 * Created on: 15/07/13
 * Blog : http://blog.csdn.net/u011341435
 * Copyright 2013 Cole Yu <gzble@qq.com>
 * QQ: <2843127527>
 * TaoBao:< http://antek.taobao.com/ >
 */
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>

@protocol blueKitBLEDelegate
@optional
-(void) blueKitBLEReady;

@required
-(void) deviceFoundUpdate:(CBPeripheral*)p;
-(void) RxValueUpdate:(Byte*)buf;
-(void) bluekitDisconnect;
-(void) updateRssiValue:(int)rssi;
-(void) blueConnect;
@end

@interface bluekitBle : NSObject <CBCentralManagerDelegate,CBPeripheralDelegate> 
+(bluekitBle *)getSharedInstance;
+(CBCentralManager*) getSharedCM;

@property (nonatomic,assign) id <blueKitBLEDelegate> delegate;
@property (strong, nonatomic)  NSMutableArray *peripherals;
@property (strong, nonatomic) CBCentralManager *CM;
@property (strong, nonatomic) CBPeripheral *activePeripheral;

-(int) findBLEPeripherals:(int) timeout;
-(int) controlSetup: (int) s;
-(void) writeValue:(int)serviceUUID characteristicUUID:(int)characteristicUUID  p:(CBPeripheral *)p data:(NSData *)data;
-(void) readValue: (int)serviceUUID characteristicUUID:(int)characteristicUUID  p:(CBPeripheral *)p;
-(void) notification:(int)serviceUUID characteristicUUID:(int)characteristicUUID  p:(CBPeripheral *)p on:(BOOL)on;
-(void) connectPeripheral:(CBPeripheral *)peripheral;
-(void) cancelConnectPeripheral;
-(void) writeDataToSscomm:(NSData *)data;
-(void)myReadRssi;

@end
