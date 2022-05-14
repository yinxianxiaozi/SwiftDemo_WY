//
//  main.swift
//  泛型
//
//  Created by 张文艺 on 2022/5/14.
//

import Foundation

print("Hello, World!")

/*
 1、实现
 */
func test1() {
    //用在函数
    func swapValues<T>(_ a: inout T, _ b: inout T) {
        (a, b) = (b, a)
    }
    var i1 = 10
    var i2 = 20
    swapValues(&i1, &i2)
    
    var d1 = 10.0
    var d2 = 20.0
    swapValues(&d1, &d2)
    
    struct Date {
        var year = 0, month = 0, day = 0
    }
    var dd1 = Date(year: 2011, month: 9, day: 10)
    var dd2 = Date(year: 2012, month: 10, day: 11)
    swapValues(&dd1, &dd2)
    
    //用在类型
    
    //用在枚举
}
