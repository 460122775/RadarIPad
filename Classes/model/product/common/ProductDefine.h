//
//  ProductDefine.h
//  RadarIPad
//
//  Created by Yachen Dai on 12/6/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#pragma -mark 雷达产品数据文件文件头
typedef struct _REAL_FILE  // 【1266】
{
	tagRealAddrSec addSec;	// 站址参数段 【160】
	tagRealCapabilitySec capabilitySec; // 性能参数段 【40】
	tagRealObserSec obserSec;	// 观察参数段 【1066】
}tagRealFile;

#pragma -mark 实时数据站址参数段
typedef struct _REAL_ADDR_SECTION  //【160】
{
	short int HeadLen;  // 文件头长度 【2】
	char Nation[20];    // 雷达型号 【20】 RadarType[20]
	char State[20];     // 省名 【20】    Province[20]
	char Station[20];   // 区名 【20】
	char SectionSta[20]; // 区站名 【20】
	char Type[20];		 // 文件格式版本号[4 - 7]存放数据来源【20】
	char Longitude[20];  // 格式E15度'12"  【20】
	char Latitude[20];   // 格式N35度'15"  【20】
	long int LongitudeV; // 天线所在径度的数值表示，单位取1／1000度(东经为整，西径为负)【4】
	long int LatitudeV;  // 天线所在纬度的数值表示，单位取1／1000度(北纬为正，南纬为负)【4】
	long int Height;	 // 天线所在的海拔高度，以mm为单位  【4】
	short int Elevation; // 测站四周地物最大仰角，百分之一度为单位 【2】
	short int Elevation1; //测站的最佳观测仰角，百分之一度为单位 【2】
	short int Category;  // 站点编号 【2】
}REAL_ADDR_SEC,tagRealAddrSec;

#pragma -mark 雷达性能参数段
typedef struct _REAL_CAPABILITY_SECTION // 【40】
{
	unsigned short int   iTianXianZenYi;//天线增益,以.01dB为单位【2】     iAntennaPlus
	unsigned short int   iCuiZhiSuKuan; //垂直波束宽度，单位取1/100度【2】 iVBeamwidth
	unsigned short int   iShuiPingSuKuan;//水平波束宽度，单位取1/100度    【2】 iHBeamwidth
	unsigned short int   iJiHuaZhuangKuang;	/*! 极化状况 【2】  iPolarzation
											 - 0：为水平极化；
											 - 1：垂直极化；
											 - 2：为双极化（双偏振）；
											 - 3：为圆偏振；
											 - 4：其它
                                             */
	unsigned short int   iPangBanDianPing;// 第一旁瓣电平，取绝对值（单位取百分之一dB）【2】 iSidelobeLevel
	unsigned short int	 iBoChang;		// 波长，以微米为单位 【2】 iWaveLength
	unsigned long  int	 iFengZhiGongLv;	// 雷达峰值功率,瓦为单位【4】 iPeakPower
	unsigned short int   iDuiShuDongTaiHuanWei; // 对数接收机动态范围，百分之一dB为单位 【2】 iLogExtent
	unsigned short int   iXianXingDongTaiHuanWei; // 线性接收机动态范围，百分之一dB为单位 【2】
    iLinearExtent
	unsigned short int   iAGCYanCiLiang; // AGC延迟量，以微秒为单位 【2】 iAGCDelayAmount
	unsigned short int   iDuShuZuiXiaoGongLv; //对数接收机最小可测功率，百分之一dbmw为单位 【2】iLogMinObsPower
	unsigned short int   iXianXingZuiXiaoGongLv; // 线性接收机最小可测功率，以百分之一dbmw为单位 【2】iLinearMinObsPower
	unsigned short int   iZaoShengYuZhi; // 噪声消除量化阀值(-255)【2】 iNoiseThr
	unsigned short int   iDuoPoLeXiao;  // 多普勒杂波消除阀值，单位.01db【2】iClutterRejectionThr
	unsigned short int   iSQIYuZhi;     // SQI阀值（-1）：实际值乘 【2】iSQIThreshold
	unsigned short int   iSuDuChuLiFangShi; /*! 速度处理方式  【2】 iVProcessMode
											 0:无速度处理；
											 1:PPI；
											 2:FFT；
                                             */
	unsigned short int   iDiWuChuLiFangShi; /*! 地物处理方式 【2】iCluProcessMode
											 - 0:无地物处理；
											 - 1:地物杂波图扣除法；
											 - 2:滤波器处理；
											 - 3:滤波器＋地物杂波图法；
											 - 4:谱分析法
                                             */
	unsigned short int   iQiangDuTongDao;   /*! 强度估算采用的通道 【2】iIntensityGangway
											 - 1:对数;
											 - 2:线性
                                             */
	unsigned short int   iJuLiDingZheng;    // 【2】 iRangeReduction
}REAL_CAPABILITY_SEC,tagRealCapabilitySec;

#pragma -mark 批处理模式结构体
struct _BATCH_SCAN  // 【92】
{
	unsigned short int scanmode;  /*! 雷达扫描模式:  【2】
                                   - 在大船项目下：具体参见文档
                                   */
	char wavForm[30];		/*! spare[2 - 31], 存储体扫各层的扫描方式 【30】
                             - 0 lcs 模式（R）
                             - 1 lcd 模式（V、W）
                             - 2 hcd( RVW )
                             - 3
                             - 4 batch 模式( RVW )
                             */
	unsigned short int usDopBinNumber[30]; // 各层的多普勒距离库数，usDopBinNumber  【60】
};

#pragma -mark 实时数据观察参数段
typedef struct _REAL_OBSERVATION_SECTION  // 【1066】
{
	unsigned short int iProductNumber;	/*! 产品编号<0>      【2】
                                         - 0:PPI1
                                         - 1:RHI
                                         - 2:立体扫描
                                         - 3.反射率
                                         - 4.速度
                                         - 5.谱宽 */
	unsigned short int   iLiTiSaoMiaoCengShu;	// 立体扫描层数  【2】iScanCutNum
	unsigned short int   iGuanCeKaiShiNian;	// 观测开始时间年（位数如）【2】 iObsStartTimeYear
	unsigned short int   iGuanCeKaiShiYue;	// 观测开始时间月  【2】 iObsStartTimeMonth
	unsigned short int   iGuanCeKaiShiRi;	    // 观测开始时间日  【2】 iObsStartTimeDay
	unsigned short int   iGuanCeKaiShiShi;	// 观测开始时间小时【2】 iObsStartTimeHour
	unsigned short int   iGuanCeKaiShiFen;	// 观测开始时间分【2】 iObsStartTimeMinute
	unsigned short int   iGuanCeKaiShiMiao;   // 观测开始时间秒【2】 iObsStartTimeSecond
	unsigned long        iKaiShiGPSShiJian;   // 开始GPS时间   【4】 iGPSStartTime
	unsigned short int   iDingBiaoQingKuang;	/*! 定标情况  【2】  iCalibrate
												 - 0:没有定标
												 - 1:自动定标
												 - 2:一周内人工定标
												 - 3:一月内人工定标
                                                 */
	unsigned short int   iQianDuJiFenCiShu;	// 强度积分次数 【2】 iIntensityIntNum
	unsigned short int   iSuDuChuLiShu;	    // 速度处理样本数 【2】iVSample
	union  // 【120】
	{
		unsigned long id[30];	// ID 号，仅对体扫产品有用 【120】
		float parame[30];        // 产品的参数 【120】
	};
    
	unsigned char cGuanCeYaoSu[30];	/*! 观测要素  【30】 cObsEssential[30]
                                     - 1:单强度
                                     - 2:单速度（单PRF）
                                     - 3:速度+谱宽（单PRF）
                                     - 4:单速度（双PRF）
                                     - 5:速度+谱宽（双PRF）
                                     - 6:强度+速度（单PRF）
                                     - 7:强度+速度（双PRF）
                                     - 8:三要素（单PRF）
                                     - 9:三要素（双PRF）
                                     - 10：四要素（ConR+R +V+W，单PRF）
                                     - 11：四要素（ConR+R+V+W，双PRF）
                                     */
	unsigned char cSuDuTuiMoFu[30];	/*! 速度退模糊 【30】 cVDeblurring[30]
                                     - 0.无退模糊处理；
                                     - 1.软件退模糊；
                                     - 2.双PRF退模糊；
                                     - 3.批式退模糊；
                                     - 4.批式加软件退模糊；
                                     - 5.双PRF退模糊；
                                     - 6.双PRF+软件退模糊
                                     */
	unsigned short int   iYiMaiChongChongPin[30];	// 各层第一种脉冲重复频率*，计数单位/10HZ  【60】 iFirstKindPRF[30]
	unsigned short int   iErMaiChongChongPin[30];	// 各层第二种脉冲重复频率*，计数单位/10HZ  【60】 iSecondKindPRF[30]
	unsigned short int   iMaiChongKuanDu[30];	// 各层脉冲宽度(1/100微秒)  【60】 iPulseWidth[30]
	unsigned short int   iZuiDaCeSu[30];		// 各层的最大可测速度；单位：厘米/秒 【60】 iMaxObsVel[30]
	unsigned short int   usRefBinNumber[30];  //各层的反射率距离库数，usRefBinNumber  【60】
	unsigned short int   iCaiYangJinXiangShu[30];	// 各层采样的径向数，各层径向数相同 【60】 iRadialNum[30]
    unsigned short int   iKuChangDop[30]; // 各层多普勒库长，米为单【60】 iDopBinLen[30]
	unsigned short int   iKuChang[30];	// 各层反射率库长，米为单位【60】 iRefBinLen[30]
	unsigned short int   iDiYiKuJuLi[30]; // 各层径向上的第一个库（或数据）的开始距离（以米为单位）【60】 iFirstBinDis[30]
    unsigned long  int   iPPIKaiShiWeiZhi[30] ; // 各层PPI在文件中开始的位置(字节，含文件头)【120】 iPPIStartPos[30]
	short int iYangJiao[30];		/*!  各层的仰角，单位/100度  【60】 iElevation[30]
                                     - 做PPI时
                                     -# 仅在第一层填写仰角数。
                                     - 做RHI时
                                     -# 第一层填写方位数
                                     -# 第二层填写RHI的最低仰角
                                     -# 第三层填写RHI的最高仰角
                                     */
	char cShuJuPaiLieFangShi; /*! 一个径向中的数据排列方式 【1】 cDataArrayMode
                               - 11按库排列：库中先速度后强度（两要素）
                               - 12按库排列：库中先强度后速度（两要素）
                               - 13按库排列：库中先速度后谱宽（两要素）
                               - 14按库排列：库中先速度后强度再谱宽
                               - 15按库排列：库中先强度后速度再谱宽
                               - 21按要素排列：单强度,地物滤波( ConR )
                               - 22按要素排列：单速度( V )
                               - 23按要素排列：先强度后速度( ConR + V )
                               - 24按要素排列：先速度后强度( V + ConR )
                               - 25按要素排列：先速度后谱宽( V + W )
                               - 26按要素排列：先速度后强度再谱宽(V+ConR+W )
                               - 27按要素排列：先强度后速度再谱宽(ConR +V + W )
                               - 31 346-S, 按要素排列:  ConR
                               - 32 346-S, 按要素排列:  R
                               - 33 346-S, 按要素排列:  ConR + R
                               - 34 346-S, 按要素排列:  ConR + V + W
                               - 35 346-S, 按要素排列:  R + V + W
                               - 36 346-S, 按要素排列:  ConR + R + V + W
                               */
	unsigned char cQiangDuZiJieShu;	/*! 一个强度数据占用的字节数，百位数表示 【1】 cRByteCount
									 - 是否有符号位，
                                     -#  Oxx：表示不无符号位；
                                     -# 1xx：表示有符号位
                                     */
	unsigned char cSuDuZiJieShu;	/*! 一个速度数据占用的字节数，百位数表示是否有符号位 【1】cVByteCount
									 - Oxx：表示无符号位；
									 - 1xx：表示有符号位。
                                     */
	unsigned char cPuKuanZiJieShu;	/*! 一个谱宽数据占用的字节数，百位数表示是否有符号位 【1】 cWByteCount
									 - 0:表示不无符号位；
									 - 1:表示有符号位。
                                     */
	short int iQiangDuWuHuiBoMa;	// 强度：无回波的代表码 【2】 iRNoEchoCode
	short int iSuDuWuHuiBoMa;		// 速度：无回波的代表码 【2】 iVNoEchoCode
	short int iPuKuanWuHuiBoMa;	// 谱宽：无回波的代表码 【2】 iWNoEchoCode
	short int iQiangDuZengLiang;	// 数据中的强度最小增量 【2】 iRMinIncrement
	short int iSuDuZengLiang;		// 数据中的速度最小增量*1000  【2】 iVMinIncrement
	short int iPuKuanZengLiang;	// 数据中的谱宽最小增量*1000  【2】 iWMinIncrement
	short int iQiangDu0;		    // 强度：如果用无符号类型数表示，填写代表零的数值 【2】 iRef0
	short int iSuDu0;		    // 速度：如果用无符号类型数表示，填写代表零的数值 【2】 iVel0
	short int iPuKuan0;	// 谱宽：如果用无符号类型数表示，填写代表零的数值 【2】 iWid0
	unsigned short int   iGuanCeJieSuNian;	// 观测结束时间，年(四位数)  【2】 iObsEndTimeYear
	unsigned short int   iGuanCeJieSuYue;	// 观测结束时间，月【2】 iObsEndTimeMonth
	unsigned short int   iGuanCeJieSuRi;	// 观测结束时间，日【2】 iObsEndTimeDay
	unsigned short int   iGuanCeJieSuShi;	// 观测结束时间，时【2】 iObsEndTimeHour
	unsigned short int   iGuanCeJieSuFen;	// 观测结束时间，分【2】 iObsEndTimeMinute
	unsigned short int   iGuanCeJieSuMiao;	// 观测结束时间，秒【2】 iObsEndTimeSecond
	unsigned long        iJieSuGPSShiJian;	// GPS时间(无GPS填零)【4】 iGPSEndTime
	unsigned short int   iJieGou1DaXiao;// 应写注结构(1)数组的大小。【2】 iStructSize
	union  // 【100】
	{
		char spare[100];  // 【100】
		_BATCH_SCAN batch;  // 【92】
	};
}REAL_OBSER_SEC,tagRealObserSec;



