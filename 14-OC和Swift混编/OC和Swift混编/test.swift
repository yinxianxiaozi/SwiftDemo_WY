//
//  test.swift
//  OC和Swift混编
//
//  Created by zhangwenyi on 2022/5/18.
//

import Foundation

/*
 1、继承自NSObject
 2、使用@objcMembers或@object修饰需要暴露给OC的内容
 */
@objcMembers class Car: NSObject {
    var price: Double
    var band: String
    init(price: Double, band: String) {
        self.price = price
        self.band = band
    }
    func run() {
        print(price, band, "run")
    }
    static func run() { print("Car run") }
}
//扩展
extension Car {
    func test() { print(price, band, "test") }
}

var car = Car(price: 10.5, band: "Audi")

