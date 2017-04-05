//
//  CCNumnerHeader.h
//  CloudCity
//
//  Created by Mac on 15/11/14.
//  Copyright © 2015年 JuGuang. All rights reserved.
//

#ifndef CCNumnerHeader_h
#define CCNumnerHeader_h


typedef NS_ENUM(NSInteger, CCNumberTypeOf){
    /**< 0-9 */
    CCNumberTypeOf0              = 0 ,
    CCNumberTypeOf1              = 1 ,
    CCNumberTypeOf2              = 2 ,
    CCNumberTypeOf3              = 3 ,
    CCNumberTypeOf4              = 4 ,
    CCNumberTypeOf5              = 5 ,
    CCNumberTypeOf6              = 6 ,
    CCNumberTypeOf7              = 7 ,
    CCNumberTypeOf8              = 8 ,
    CCNumberTypeOf9              = 9 ,
    
    /**< 10-19 */
    CCNumberTypeOf10             = 10,
    CCNumberTypeOf11             = 11,
    CCNumberTypeOf12             = 12,
    CCNumberTypeOf13             = 13,
    CCNumberTypeOf14             = 14,
    CCNumberTypeOf15             = 15,
    CCNumberTypeOf16             = 16,
    CCNumberTypeOf17             = 17,
    CCNumberTypeOf18             = 18,
    CCNumberTypeOf19             = 19,
    
    /**< 20-29 */
    CCNumberTypeOf20             = 20,
    CCNumberTypeOf21             = 21,
    CCNumberTypeOf22             = 22,
    CCNumberTypeOf23             = 23,
    CCNumberTypeOf24             = 24,
    CCNumberTypeOf25             = 25,
    CCNumberTypeOf26             = 26,
    CCNumberTypeOf27             = 27,
    CCNumberTypeOf28             = 28,
    CCNumberTypeOf29             = 29,
    
    /**< 30-39 */
    CCNumberTypeOf30             = 30,
    CCNumberTypeOf31             = 31,
    CCNumberTypeOf32             = 32,
    CCNumberTypeOf33             = 33,
    CCNumberTypeOf34             = 34,
    CCNumberTypeOf35             = 35,
    CCNumberTypeOf36             = 36,
    CCNumberTypeOf37             = 37,
    CCNumberTypeOf38             = 38,
    CCNumberTypeOf39             = 39,
    
    /**< 40-49 */
    CCNumberTypeOf40             = 40,
    CCNumberTypeOf41             = 41,
    CCNumberTypeOf42             = 42,
    CCNumberTypeOf43             = 43,
    CCNumberTypeOf44             = 44,
    CCNumberTypeOf45             = 45,
    CCNumberTypeOf46             = 46,
    CCNumberTypeOf47             = 47,
    CCNumberTypeOf48             = 48,
    CCNumberTypeOf49             = 49,
    
    /**< 50-59 */
    CCNumberTypeOf50             = 50,
    CCNumberTypeOf51             = 51,
    CCNumberTypeOf52             = 52,
    CCNumberTypeOf53             = 53,
    CCNumberTypeOf54             = 54,
    CCNumberTypeOf55             = 55,
    CCNumberTypeOf56             = 56,
    CCNumberTypeOf57             = 57,
    CCNumberTypeOf58             = 58,
    CCNumberTypeOf59             = 59,
    
    /**< 60-69 */
    CCNumberTypeOf60             = 60,
    CCNumberTypeOf61             = 61,
    CCNumberTypeOf62             = 62,
    CCNumberTypeOf63             = 63,
    CCNumberTypeOf64             = 64,
    CCNumberTypeOf65             = 65,
    CCNumberTypeOf66             = 66,
    CCNumberTypeOf67             = 67,
    CCNumberTypeOf68             = 68,
    CCNumberTypeOf69             = 69,
    
    /**< 70-79 */
    CCNumberTypeOf70             = 70,
    CCNumberTypeOf71             = 71,
    CCNumberTypeOf72             = 72,
    CCNumberTypeOf73             = 73,
    CCNumberTypeOf74             = 74,
    CCNumberTypeOf75             = 75,
    CCNumberTypeOf76             = 76,
    CCNumberTypeOf77             = 77,
    CCNumberTypeOf78             = 78,
    CCNumberTypeOf79             = 79,
    
    /**< 80-89 */
    CCNumberTypeOf80             = 80,
    CCNumberTypeOf81             = 81,
    CCNumberTypeOf82             = 82,
    CCNumberTypeOf83             = 83,
    CCNumberTypeOf84             = 84,
    CCNumberTypeOf85             = 85,
    CCNumberTypeOf86             = 86,
    CCNumberTypeOf87             = 87,
    CCNumberTypeOf88             = 88,
    CCNumberTypeOf89             = 89,
    
    /**< 90-99 */
    CCNumberTypeOf90             = 90,
    CCNumberTypeOf91             = 91,
    CCNumberTypeOf92             = 92,
    CCNumberTypeOf93             = 93,
    CCNumberTypeOf94             = 94,
    CCNumberTypeOf95             = 95,
    CCNumberTypeOf96             = 96,
    CCNumberTypeOf97             = 97,
    CCNumberTypeOf98             = 98,
    CCNumberTypeOf99             = 99,
    
    /**< 100-110 */
    CCNumberTypeOf100            = 100,
    CCNumberTypeOf102            = 102,
    CCNumberTypeOf103            = 103,
    CCNumberTypeOf104            = 104,
    CCNumberTypeOf105            = 105,
    CCNumberTypeOf106            = 106,
    CCNumberTypeOf109            = 109,
    
    /**< 110 - 119 */
    CCNumberTypeOf110            = 110,
    CCNumberTypeOf112            = 112,
    CCNumberTypeOf113            = 113,
    CCNumberTypeOf114            = 114,
    CCNumberTypeOf115            = 115,
    CCNumberTypeOf116           = 116,
    CCNumberTypeOf117            = 117,
    CCNumberTypeOf118            = 118,
    
    /**< 120 - 129 */
    CCNumberTypeOf120            = 120,
    CCNumberTypeOf122            = 122,
    CCNumberTypeOf123            = 123,
    CCNumberTypeOf125            = 125,
    
    /**< 130 - 139 */
    CCNumberTypeOf130            = 130,
    CCNumberTypeOf132            = 132,
    CCNumberTypeOf135            = 135,
    CCNumberTypeOf136            = 136,
    CCNumberTypeOf138            = 138,
    
    /**< 140 - 149 */
    CCNumberTypeOf140            = 140,
    CCNumberTypeOf145            = 145,
    
    /**< 150 - 159 */
    CCNumberTypeOf150            = 150,
    CCNumberTypeOf152            = 152,
    CCNumberTypeOf156            = 156,
    
    /**< 160 - 169 */
    CCNumberTypeOf160            = 160,
    CCNumberTypeOf168            = 168,
    
    /**< 170 - 179 */
    CCNumberTypeOf170            = 170,
    CCNumberTypeOf174            = 174,
    
    /**< 180 - 189 */
    CCNumberTypeOf180            = 180,
    CCNumberTypeOf185            = 185,
    
    /**< 190 - 199 */
    CCNumberTypeOf190            = 190,
    CCNumberTypeOf195            = 195,
    
    /**< 200 - */
    CCNumberTypeOf200            = 200,
    CCNumberTypeOf210            = 210,
    CCNumberTypeOf220            = 220,
    CCNumberTypeOf230            = 230,
    CCNumberTypeOf240            = 240,
    CCNumberTypeOf250            = 250,
    CCNumberTypeOf255            = 255,
    
    
    CCNumberTypeOf10000          = 10000,
};

#endif /* CCNumnerHeader_h */
