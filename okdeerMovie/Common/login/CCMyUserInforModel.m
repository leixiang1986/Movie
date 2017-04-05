//
//  CCMyUserInforModel.m
//  OkdeerUser
//
//  Created by Mac on 16/9/9.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCMyUserInforModel.h"
#import "CCNameAndIdModel.h"

#define kUserInfoModel @"KEY_USERINFORMODEL"

@implementation CCMyUserInforModel
@synthesize gender = _gender;
@synthesize maritalStatus = _maritalStatus;
@synthesize picUrl = _picUrl;

static CCMyUserInforModel *model = nil;
+(instancetype)instance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSData *data = [[NSUserDefaults standardUserDefaults] dataForKey:kUserInfoModel];
        
        if (data){
            model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        if (!model || !model.userId.length){
            model = [[CCMyUserInforModel alloc] init];
            if (data){  // 处理本地有数据但解档nil情况，(1.不可直接发通知，在清除数据时由于接受通知的对象在单例方法还未返回实例时又调用该单例方法会出现异常而程序崩；2.在delegate提前实例化model,由于通知必须在其注册者实例化后才能接受，但又无法保证注册者对象内可能调用该单例对象从而出现1情况，也会存在比较大的风险，所以通过延时通知处理)
                // 若data有值但是解档出来为nil则kUserInfoModel key对应的值为nil
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kUserInfoModel];
                [[NSUserDefaults standardUserDefaults] synchronize];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //[[NSNotificationCenter defaultCenter] postNotificationName:kCleanUserDataNotificationName object:nil];
                });
            }
        }
    });
    return model;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.loginName = [aDecoder decodeObjectForKey:@"loginName"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.realName = [aDecoder decodeObjectForKey:@"realName"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        self.maritalStatus = [aDecoder decodeObjectForKey:@"maritalStatus"];
        self.interest = [aDecoder decodeObjectForKey:@"interest"];
        self.profession = [aDecoder decodeObjectForKey:@"profession"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.phoneMac = [aDecoder decodeObjectForKey:@"phoneMac"];
        self.picUrl = [aDecoder decodeObjectForKey:@"picUrl"];
        self.sign = [aDecoder decodeObjectForKey:@"sign"];
        
        self.descriptionStr = [aDecoder decodeObjectForKey:@"descriptionStr"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.updateTime = [aDecoder decodeObjectForKey:@"updateTime"];
        self.sysNotice = [aDecoder decodeObjectForKey:@"sysNotice"];
        self.propNotice = [aDecoder decodeObjectForKey:@"propNotice"];
        self.isLoginPassword = [aDecoder decodeObjectForKey:@"isLoginPassword"];
        self.serviceUrl = [aDecoder decodeObjectForKey:@"serviceUrl"];
        self.invitationCode = [aDecoder decodeObjectForKey:@"invitationCode"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.loginName forKey:@"loginName"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.realName forKey:@"realName"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    
    [aCoder encodeObject:self.maritalStatus forKey:@"maritalStatus"];
    [aCoder encodeObject:self.interest forKey:@"interest"];
    [aCoder encodeObject:self.profession forKey:@"profession"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.phoneMac forKey:@"phoneMac"];
    [aCoder encodeObject:self.picUrl forKey:@"picUrl"];
    [aCoder encodeObject:self.sign forKey:@"sign"];
    
    [aCoder encodeObject:self.descriptionStr forKey:@"descriptionStr"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.updateTime forKey:@"updateTime"];
    [aCoder encodeObject:self.sysNotice forKey:@"sysNotice"];
    [aCoder encodeObject:self.propNotice forKey:@"propNotice"];
    [aCoder encodeObject:self.isLoginPassword forKey:@"isLoginPassword"];
    [aCoder encodeObject:self.serviceUrl forKey:@"serviceUrl"];
    [aCoder encodeObject:self.invitationCode forKey:@"invitationCode"];
}

+ (instancetype)modelObjectWithDictionaryForUserInfor:(NSDictionary *)dic {
   CCMyUserInforModel *model = [CCMyUserInforModel instance];
    model.loginName = DicGetValue(dic, @"loginName");
    model.userId = DicGetValue(dic, @"id");
    model.nickName = DicGetValue(dic, @"nickName");
    model.realName = DicGetValue(dic, @"realName");
    model.birthday = DicGetValue(dic, @"birthday");
    model.interest = DicGetValue(dic, @"interest");
    model.profession = DicGetValue(dic, @"profession");
    model.phone = DicGetValue(dic, @"phone");
    model.email = DicGetValue(dic, @"email");
    model.status = DicGetValue(dic, @"status");
    model.phoneMac = DicGetValue(dic, @"phoneMac");
    model.serviceUrl = DicGetValue(dic, @"picServerUrl");
    model.picUrl = DicGetValue(dic, @"userPicUrl");
    
    if ([model.picUrl isHttpString]) {
        [model downLoadHeaderImage:model.picUrl];
    }
    else {
        //UIImage *image=kShareImgInHome(@"headerDefault");//系统默认图片
        //model.headerImage = image;
       // [[NSNotificationCenter defaultCenter] postNotificationName:kHEADIMAGEDOWNLOADED object:image];
    }
    model.sign = DicGetValue(dic, @"sign");
    model.descriptionStr = DicGetValue(dic, @"description");
    model.createTime = DicGetValue(dic, @"createTime");
    model.updateTime = DicGetValue(dic, @"updateTime");
    model.sysNotice = DicGetValue(dic, @"sysNotice");
    model.propNotice = DicGetValue(dic, @"propNotice");
    model.isLoginPassword = DicGetValue(dic, @"isLoginPassword");
    model.maritalStatus = DicGetValue(dic, @"maritalStatus");
    model.gender = DicGetValue(dic, @"gender");
    NSString *point = DicGetValue(dic, @"pointVal");
    model.invitationCode = DicGetValue(dic, @"invitationCode");
    if (point.intValue){
       // [[NSNotificationCenter defaultCenter] postNotificationName:kSendPointNotification object:point];
    }
    [self saveMyUserInfo];
    return model;
}

/**
 *  保存用户信息到本地沙盒
 *
 *  @return 是否成功保存
 */
+ (BOOL)saveMyUserInfo {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[CCMyUserInforModel instance]];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kUserInfoModel];
    BOOL isOk = [[NSUserDefaults standardUserDefaults] synchronize];
    return isOk;
}

/**
 *  退出登录清楚用户数据-用户信息
 */
- (void)cleanMyUserInfo {
    _phone = @"";
    _loginName = @"";
    _nickName = @"";
    _realName = @"";
    _userId = @"";
    _phoneMac = @"";
    _picUrl = @"";
    _serviceUrl = @"";
    //_headerImage = kShareImgInHome(@"headerDefault");
    _gender = @"";
    _birthday = @"";
    _profession = @"";
    _interest = @"";
    _email = @"";
    _maritalStatus = @"";
    _sign = @"";
    _status = @"";
    _descriptionStr = @"";
    _createTime = @"";
    _updateTime = @"";
    _sysNotice = @"";
    _propNotice = @"";
    _isLoginPassword = @"";
    _invitationCode = @"";
    [[self class] saveMyUserInfo];
}

/**
 *  setter方法，通过性别的字符串(根据后台返回的数据如果是id也可用id匹配)匹配选中的model
 *
 *  @param gender
 */
-(void)setGender:(NSString *)gender {
    _gender = gender;
    for (NSInteger i = 0; i < self.genderArr.count; i++) {
        CCNameAndIdModel *model = self.genderArr[i];
        if ([_gender isEqualToString:model.Id]) {
            _selectedGenderModel = model;
        }
    }
    if (!_selectedGenderModel) {
        _selectedGenderModel = [[CCNameAndIdModel alloc] init];
    }
}


/**
 *  setter方法，通过感情状态的字符串（也可以是id，根据后台返回数据定）匹配选中的model
 *
 *  @param affectionState
 */
- (void)setMaritalStatus:(NSString *)maritalStatus {
    _maritalStatus = maritalStatus;
    for (NSInteger i = 0; i < self.affectionStateArr.count; i ++) {
        CCNameAndIdModel *model = self.affectionStateArr[i];
        if ([_maritalStatus isEqualToString:model.Id]) {
            _selectedAffectionStateModel = model;
        }
        if (!_selectedAffectionStateModel) {
            _selectedAffectionStateModel = [[CCNameAndIdModel alloc] init];
        }
    }
}

/**
 *  性别选项数组
 *
 *  @return
 */
-(NSArray<CCNameAndIdModel *> *)genderArr {
    if (!_genderArr) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        NSArray *nameArr = @[@"男",@"女"];
        for (NSInteger i = 0; i < nameArr.count; i++) {
            CCNameAndIdModel *model = [[CCNameAndIdModel alloc] init];
            model.Id = [NSString stringWithFormat:@"%ld",(long)(i + 1)];
            model.name = nameArr[i];
            [tempArr addObject:model];
        }
        _genderArr = tempArr;
    }
    return _genderArr;
}

/**
 *  感情状态选项数组
 *
 *  @return
 */
-(NSArray<CCNameAndIdModel *> *)affectionStateArr {
    if (!_affectionStateArr) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        NSArray *nameArr = @[@"保密",@"单身",@"热恋中",@"已婚"];
        for (NSInteger i = 0; i < nameArr.count; i++) {
            CCNameAndIdModel *model = [[CCNameAndIdModel alloc] init];
            model.name = nameArr[i];
            model.Id = [NSString stringWithFormat:@"%ld",(long)i];
            [tempArr addObject:model];
        }
        _affectionStateArr = tempArr;
    }
    return _affectionStateArr;
}

-(CCNameAndIdModel *)selectedGenderModel {
    if (!_selectedGenderModel) {
        _selectedGenderModel = [[CCNameAndIdModel alloc] init];
    }
    return _selectedGenderModel;
}

-(CCNameAndIdModel *)selectedAffectionStateModel {
    if (!_selectedAffectionStateModel) {
        _selectedAffectionStateModel = [[CCNameAndIdModel alloc] init];
    }
    return _selectedAffectionStateModel;
}

- (void)downLoadHeaderImage:(NSString *)urlStr {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image=nil;

        NSURL *url=[NSURL URLWithString:urlStr];
        NSData *data=[NSData dataWithContentsOfURL:url];
        if (data) {
            image=[UIImage imageWithData:data];
        }else{
            image= imageFromBundleName(kShareImageBundleName, kShareImageHomeDirectory, @"headerDefault");//默认图片
        }
        _headerImage = image;
        dispatch_async(dispatch_get_main_queue(), ^{
            //[[NSNotificationCenter defaultCenter] postNotificationName:kHEADIMAGEDOWNLOADED object:image];
        });
    });
}

-(void)setPicUrl:(NSString *)picUrl {
    _picUrl = picUrl;
    CCLog(@"picUrl setter方法:%@",picUrl);
    if ([_picUrl isHttpString]) {
        [self downLoadHeaderImage:_picUrl];
    }
}

- (NSString *)phone {
    return [self checkNil:_phone];
}

-(NSString *)loginName {
    return [self checkNil:_loginName];
}

- (NSString *)nickName {
    return [self checkNil:_nickName];
}

-(NSString *)realName {
    return [self checkNil:_realName];
}

-(NSString *)userId {
    return [self checkNil:_userId];
}

-(NSString *)phoneMac {
    return [self checkNil:_phoneMac];
}

- (NSString *)picUrl {
    return [self checkNil:_picUrl];
}

-(NSString *)gender {
    return [self checkNil:_gender];
}

-(NSString *)birthday {
    return [self checkNil:_birthday];
}

-(NSString *)profession {
    return [self checkNil:_profession];
}

-(NSString *)interest {
    return [self checkNil:_interest];
}

-(NSString *)email {
    return [self checkNil:_email];
}

-(NSString *)maritalStatus {
    return [self checkNil:_maritalStatus];
}

-(NSString *)sign {
    return [self checkNil:_sign];
}

-(NSString *)status {
    return [self checkNil:_status];
}

-(NSString *)descriptionStr {
    return [self checkNil:_descriptionStr];
}

-(NSString *)createTime {
    return [self checkNil:_createTime];
}

-(NSString *)updateTime {
    return [self checkNil:_updateTime];
}

-(NSString *)sysNotice {
    return [self checkNil:_sysNotice];
}

-(NSString *)propNotice {
    return [self checkNil:_propNotice];
}

-(NSString *)isLoginPassword {
    return [self checkNil:_isLoginPassword];
}

- (NSString *)invitationCode {
    return [self checkNil:_invitationCode];
}

- (NSString *)checkNil:(NSString *)str {
    if (!str || [str isKindOfClass:[NSNull class]]){
        return @"";
    }
    return str;
}

/**
 *  得到第index个的title
 *
 *  @param index 第几个参数
 *
 *  @return 返回标题
 */
+ (NSString *)getTitleWithType:(CCMyUserInforModelType)type {
    NSString *title = @"";
    switch (type) {
        case CCMyUserInforModelTypeHeaderImage:
            title = @"头像";
            break;
            
        case CCMyUserInforModelTypePhoneNum:
            title = @"手机号码";
            break;
            
        case CCMyUserInforModelTypeNickName:
            title = @"昵称";
            break;
            
        case CCMyUserInforModelTypeGender:
            title = @"性别";
            break;
            
        case CCMyUserInforModelTypeBirthday:
            title = @"生日";
            break;
            
        case CCMyUserInforModelTypeProfession:
            title = @"职业";
            break;
            
        case CCMyUserInforModelTypeHoby:
            title = @"爱好";
            break;
            
        case CCMyUserInforModelTypeAffectionState:
            title = @"情感状态";
            break;
            
        case CCMyUserInforModelTypePersonalizedSignature:
            title = @"个性签名";
            break;
            
        default:
            break;
    }
    
    return title;
}


/**
 *  根据类型的到提交数据的key
 *
 *  @param type 类型
 *
 *  @return 返回key
 */
+ (NSString *)getKeyWithType:(CCMyUserInforModelType)type {
    NSString *result = @"";
    switch (type) {
        case CCMyUserInforModelTypeHeaderImage:
            result = @"picUrl";
            break;
            
        case CCMyUserInforModelTypeNickName:
            result = @"nickName";
            break;
            
        case CCMyUserInforModelTypeGender:
            result = @"gender";
            break;
            
        case CCMyUserInforModelTypeBirthday:
            result = @"birthday";
            break;
            
        case CCMyUserInforModelTypeProfession:
            result = @"profession";
            break;
            
        case CCMyUserInforModelTypeHoby:
            result = @"interest";
            break;
            
        case CCMyUserInforModelTypeAffectionState:
            result = @"maritalStatus";
            break;
            
        case CCMyUserInforModelTypePersonalizedSignature:
            result = @"sign";
            break;
        default:
            break;
    }
    return result;
}


/**
 *  得到第index个的内容
 *
 *  @param index 第几个参数
 *
 *  @return 返回内容
 */
- (NSString *)getContentWithType:(CCMyUserInforModelType)type {
    NSString *content = @"";
    switch (type) {
        case CCMyUserInforModelTypeHeaderImage:
            content = _picUrl;
            break;
            
        case CCMyUserInforModelTypePhoneNum:
            content = _phone;
            break;
            
        case CCMyUserInforModelTypeNickName:
            content = _nickName;
            break;
            
        case CCMyUserInforModelTypeGender:
            content = self.selectedGenderModel.name;
            break;
            
        case CCMyUserInforModelTypeBirthday:
            content = _birthday;
            break;
            
        case CCMyUserInforModelTypeProfession:
            content = _profession;
            break;
            
        case CCMyUserInforModelTypeHoby:
            content = _interest;
            break;
            
        case CCMyUserInforModelTypeAffectionState:
            content = _maritalStatus;
            break;
            
        case CCMyUserInforModelTypePersonalizedSignature:
            content = _sign;
            break;
            
        default:
            break;
    }
    return content;
}


/**
 *  设置内容，根据类型
 *
 *  @param type 类型
 *
 *  @return
 */
- (void)setContentWithType:(CCMyUserInforModelType)type withContent:(NSString *)content{
    if (!content) {
        content = @"";
    }
    switch (type) {
        case CCMyUserInforModelTypeHeaderImage:
            _picUrl = content;
            break;
        case CCMyUserInforModelTypePhoneNum:
            _phone = content;
            break;
        case CCMyUserInforModelTypeNickName:
            _nickName = content;
            break;
        case CCMyUserInforModelTypeGender:
            self.gender = content;
            break;
        case CCMyUserInforModelTypeBirthday:
            _birthday = content;
            break;
        case CCMyUserInforModelTypeProfession:
            _profession = content;
            break;
        case CCMyUserInforModelTypeHoby:
            _interest = content;
            break;
        case CCMyUserInforModelTypeAffectionState:
            self.maritalStatus = content;
            break;
        case CCMyUserInforModelTypePersonalizedSignature:
            _sign = content;
            break;
            
        default:
            break;
    }
}


@end
