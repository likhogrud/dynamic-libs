//
//  Created by Nikolay Lihogrud on 11.08.17.
//  Copyright © 2017 Yandex LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LazySomeDynamicClass : NSObject

@property (nonatomic) NSInteger someVar;

- (nonnull instancetype)init;
- (void)someFunc;
+ (void)someClassFunc;

@end

int lazySomeGlobalFunc();

int getLazySomeGlobalVar();
void setLazySomeGlobalVar(int value);

NSString * _Nonnull getLazySomeGlobalStringVar();
