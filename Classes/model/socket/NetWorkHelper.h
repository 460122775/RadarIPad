#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

#define k_n_NetworkDidDisconnect @"networkDidDisconnect"
#define k_n_NetworkDidConnect @"networkDidConnect"
#define k_n_NetworkBackDisconnect @"backdisconnect"

struct s_HostConfig {
    char * ip;
    uint port;
};
typedef struct s_HostConfig HostConfig;

//网络包包头
typedef struct _PT_NET_PACKHEAD_
{
    unsigned int SOI;                   //0xa55a4321
    unsigned int DataPackSize;          //整个网路包的大小
    unsigned int VER;                   //
    unsigned int DataType;              //(必须)NET_DATA_TYPE_PTTOUT_GEN_RESULT
    unsigned int PackID;                //网络包序号
}tagPtNetPackHead;

static NSString *const NetworkParserQueueName = @"parserQueue";

@class Reachability,Player;
@protocol Parser;
//@protocol NetWorkHelperAppDelegate,NetWorkHelperUserCenterDelegate;
//@protocol NetWorkHelperGameDelegate,NetWorkHelperLobbyDelegate;

#define k_n_ApplicationWillTerminate @"applicationWillTerminate"
#define k_n_ApplicationEnterBackground @"applicationEnterBackground"
#define k_n_ApplicationBacomeActive @"applicationBecomeActive"
#define k_n_RepeatLogin @"repeatLogin"

@interface  NetWorkHelper: NSObject <GCDAsyncSocketDelegate> {
    GCDAsyncSocket *_socket;
    Reachability *netReachable;
    Reachability *hostReachable;
    
    BOOL _netActive;
    BOOL _hostReachable;
    
    NSTimer *timer;
    NSString *_hostIp;
    uint16_t _hostPort;
    
    NSMutableArray *_parsers;
    BOOL _shouldReloginInSocket;
    dispatch_queue_t _parserQueue;
    
    BOOL _isTryConnecting;
}

@property (nonatomic, retain) NSMutableArray *parsers;
@property (nonatomic, assign) BOOL netActive;
@property (nonatomic, assign) BOOL hostReachable;
@property (nonatomic, readonly) GCDAsyncSocket *socket; 

@property (nonatomic, copy) NSString *hostIp;
@property (nonatomic, assign) uint16_t hostPort;
@property (nonatomic, assign) BOOL shouldReloginInSocket;
@property (nonatomic, assign) BOOL _isTryConnecting;

//todo imploment check network eveironment
//-(void ) checkNetEnvironment;
+(NetWorkHelper *) connectSocket;
+(id) share;
+(BOOL)isConnect;
-(void) connectSocket:(NSString *)aIp port:(uint)aPort;
-(void) disconnectSocket;

-(void) addNotificationObservers;
-(void) removeNotificatoinObservers;
-(void) parseMetaData:(NSData *)metaData;

-(void) sendWithType:(uint)aType dataString:(NSString *)dataString;
-(void) addParsers:(NSArray *)aParsers;
-(void) removeParser:(NSArray *)aParsers;
-(void) removeParsersWithTarget:(id)aTarget;


@end
