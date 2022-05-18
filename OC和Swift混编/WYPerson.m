//
//  WYPerson.m
//  OC和Swift混编
//
//  Created by zhangwenyi on 2022/5/18.
//

#import "WYPerson.h"
#import "OC和Swift混编-Swift.h"

@implementation WYPerson
- (instancetype)initWithAge:(NSInteger)age name:(NSString *)name {
    if (self = [super init]) {
        self.age = age;
        self.name = name;
    }
    return self;
}
+ (instancetype)personWithAge:(NSInteger)age name:(NSString *)name {
    return nil;
}
+ (void)run { NSLog(@"Person +run"); }
- (void)run { NSLog(@"%zd %@ -run", _age, _name); }
+ (void)eat:(NSString *)food other:(NSString *)other { NSLog(@"Person +eat %@ %@", food, other); }
- (void)eat:(NSString *)food other:(NSString *)other { NSLog(@"%zd %@ -eat %@ %@", _age, _name, food, other); }
@end

void testSwift() {
    Car *c = [[Car alloc] initWithPrice:100 band:@"bm"];
    [c run];
    [c test];
    [Car run];
}
