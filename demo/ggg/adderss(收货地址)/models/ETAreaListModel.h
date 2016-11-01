//
//  ETAreaListModel.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <Foundation/Foundation.h>

@class City,Town;

@interface ETAreaListModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray<City *> *edsAddrList;

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, copy) NSString *name;

@end

@interface City : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray<Town *> *edsAddrList;

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, copy) NSString *name;

@end

@interface Town : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray *edsAddrList;

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, copy) NSString *name;

@end

