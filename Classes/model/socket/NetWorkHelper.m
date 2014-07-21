
#import "NetWorkHelper.h"

#define kRead_Timeout 1.

@implementation NetWorkHelper
@synthesize netActive = _netActive,hostReachable = _hostReachable;
@synthesize socket = _socket;
@synthesize hostIp = _hostIp,hostPort = _hostPort;
@synthesize parsers = _parsers;
@synthesize shouldReloginInSocket = _shouldReloginInSocket;
@synthesize _isTryConnecting=_isTryConnecting;
static int connectTime;// connect cycle...

static NetWorkHelper *netWorkHelper = nil;

- (id) init
{
    if (self = [super init])
    {
        _parsers = [[NSMutableArray alloc] initWithCapacity:10];
        [netWorkHelper addNotificationObservers];
        _shouldReloginInSocket = YES;
        _parserQueue = dispatch_queue_create([NetworkParserQueueName UTF8String], NULL);
        //add login parser
    }
    return self;
}

+ (id) share
{
    if (!netWorkHelper)
    {
        netWorkHelper = [[NetWorkHelper alloc] init];
    }
    return netWorkHelper;
}

- (void) dealloc
{
    [self removeNotificatoinObservers];
}

#pragma mark - initializaitona ... share

+ (NetWorkHelper *) connectSocket
{
    //TEST PRODUCT>>>>
    
    NSString *fileName = @"/20130808/20130808_104630.02.003.000_2.40.zdb";
    [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVEPRODUCTADDRESS object:fileName];
    fileName = @"/20130808/20130808_104630.02.004.000_2.40.zdb.zdb";
    [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVEPRODUCTADDRESS object:fileName];
    fileName = @"/20130808/20130808_104630.02.005.000_2.40.zdb";
    [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVEPRODUCTADDRESS object:fileName];
    
    fileName = @"/20130808/20130808_104814.03.003.000_4.00.zdb";
    [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVEPRODUCTADDRESS object:fileName];
    fileName = @"/20130808/20130808_104814.03.004.000_4.00.zdb";
    [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVEPRODUCTADDRESS object:fileName];
    fileName = @"/20130808/20130808_104814.03.005.000_4.00.zdb";
    [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVEPRODUCTADDRESS object:fileName];
    
    return [NetWorkHelper share];
    //TEST END>>>>>>
    
    if ([NetWorkHelper isConnect])
    {
        DLog(@">>>>>>SOCKET HAS CONNECT, DON`T NEED CONNET AGAIN!!!RETURN.")
        return [NetWorkHelper share];
    }
    
//    [[NetWorkHelper share] setDelegate:aTarget];
    [[NetWorkHelper share] connectSocket:LOCALHOST port:chat_Port];
    //login...and the server will create a socket with userId...
//    UserVo *userVo = [UserDBModel getInstanceOfUser];
    [[NetWorkHelper share] sendWithType:1 dataString:@"ddd"];
    
    connectTime = 0;
    return [NetWorkHelper share];
}

- (void) connectSocket:(NSString *)aIp port:(uint)aPort
{
    if (!_socket)
    {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    DLog(@"\n>>>>>>>Socket is connecting %@:%u withState:%u",aIp,aPort,_socket.isConnected);
    
    if (_socket.isConnected)
    {
        _isTryConnecting = YES;
        [_socket disconnect];
    }
    [_socket connectToHost:aIp onPort:aPort error:nil];
    //    [self addParsers:[NSArray arrayWithObject:[Parser parserWith:self selector:@selector(parser_Login:) dataType:t_Login]]];
}

- (void) disconnectSocket
{
    if (_parsers && [_parsers count] > 0)
    {
        [_parsers removeAllObjects];
    }
    if (_socket.isConnected)
    {
        _isTryConnecting = YES;
        [_socket disconnect];
    }
}

+(BOOL) isConnect
{
    DLog(@"\n>>>>>>>SOCKET STATE : %@",netWorkHelper.socket.isConnected?@"YES":@"NO")
    return netWorkHelper.socket.isConnected;
}

#pragma mark - GCDAsyncSocketDelegate check internet environment and connect to host

- (void) socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    self.hostIp = host;
    self.hostPort = port;
    
    if (_isTryConnecting) _isTryConnecting = NO;
    connectTime = 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:k_n_NetworkDidConnect object:nil];
    [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:0];
    
    
    //set the socket active while the application is in background
    [sock performBlock:^{
        [sock enableBackgroundingOnSocket];
    }];
}

- (void) socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    DLog(@"\n>>>>>>>SET SOCKET DISCONNECT!!!ERROR:%@",err.description);
    if (!_isTryConnecting)
    {
        connectTime += 3;
        timer = [NSTimer scheduledTimerWithTimeInterval:connectTime target:self selector:@selector(connectAgain) userInfo:nil repeats:NO];
    }else{
        _isTryConnecting = NO;
    }
}

- (void)connectAgain
{
    DLog(@"\n>>>>>>>SOCKET CONNECT FAILED,RECONNECTING SOCKET...")
    if (timer)
    {
        [timer invalidate];
//        ABRelease(timer);
    }
    if (connectTime == 3)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:k_n_NetworkDidDisconnect object:nil];
        [[NetWorkHelper share] disconnectSocket];
        //connect the socket if socket is disconnect...
        [NetWorkHelper connectSocket];
    }
}

#pragma mark - read socket

- (void) socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    [self parseMetaData:data];
    [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:0];
}

- (NSTimeInterval) socket:(GCDAsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length
{
    DLog(@"\n>>>>>>>>Socket read timeout !!!");
    [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:0];
    return kRead_Timeout;
}

- (NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutWriteWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length
{
    DLog(@"\n>>>>>>>>Socket write timeout !!!");
    return kRead_Timeout;
}

#pragma mark - Delegate :read socket data

- (void) parseMetaData:(NSData *)data
{
    if ([data length] == 0)
    {
        return;
    }
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"\n>>>>>Socket receive:%@",dataStr);
    int type = [[dataStr substringToIndex:2] integerValue];
//    DLog(@"\n>>>>>type:%i",type);
    NSString* dataContent = [dataStr substringFromIndex:2];
//    DLog(@"\n>>>>>%@",dataContent);
    
//    //login success ...
//    if (type == TypeOfLogin_SUCCESS) {
//        DLog(@"\n>>>>>Login success.");
//        return;
//    //login failed...
//    }else if (type == TypeOfLogin_FAILED){
//        DLog(@"\n>>>>>Login failed.")
//        return;
//    }
    
//    if (_parsers && _parsers.count > 0)
//    {
//        dispatch_async(_parserQueue, ^{
//            for (Parser *parser in _parsers)
//            {
//                if (parser.dataType == type)
//                {
//                    dispatch_async (dispatch_get_main_queue (), ^{
//                        [parser parserData:dataContent];
//                    });
//                    return ;
//                }
//            }
//        });
//    }
}

#pragma mark - write data to socket

-(void) sendWithType:(uint)aType dataString:(NSString *)dataString
{
    NSData *result = [[NSString stringWithFormat:@"%i%@",aType,dataString] dataUsingEncoding:NSUTF8StringEncoding];
    [_socket writeData:result withTimeout:3 tag:0];
    DLog(@"\n>>>>>>Send data: [type-%i][%@]", aType, dataString);
}

- (void) socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    //todo write succcess... maybe app should do something like write to log or ...
}

#pragma mark - add parser

- (void) addParsers:(NSArray *)aParsers {
    dispatch_sync(_parserQueue, ^{
        [_parsers removeAllObjects];
        [_parsers addObjectsFromArray:aParsers];
    });
}

- (void) removeParser:(NSArray *)aParsers {
//    for (Parser *parser in aParsers) {
//        [_parsers removeObject:parser];
//    }
}

- (void) removeParsersWithTarget:(id)aTarget {
//    int i = 0;
//    for (Parser *parser in _parsers) {
//        if (parser.target == aTarget) {
//            [_parsers removeObjectAtIndex:i];
//        }
//        i++;
//    }
}

#pragma mark - notification

- (void) addNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserverForName:k_n_ApplicationWillTerminate object:nil queue:nil usingBlock:^(NSNotification *note) {
        [_socket disconnect];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:k_n_ApplicationBacomeActive object:nil queue:nil usingBlock:^(NSNotification *note) {
        //todo when reactive , connect the socket and others
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillTerminateNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        //todo app terminate
        DLog (@"-- terminate ");
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(repeatLoginErrorHandle) name:k_n_RepeatLogin object:nil];
}

- (void) removeNotificatoinObservers {
}

@end