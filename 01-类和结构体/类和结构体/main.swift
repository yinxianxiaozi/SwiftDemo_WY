//
//  main.swift
//  类和结构体
//
//  Created by 张文艺 on 2022/5/12.
//

import Foundation

print("Hello, World!")
func test1 (){
/*
 1、结构体的初始化器
 注意：初始化器必须保证所有存储属性都完成初始化
 */
struct Point1 {
    var x: Int = 5
    var y: Int
}

//此时都有值
var p11 = Point1(x: 10, y: 10)
//xYou自己的初始值5
var p12 = Point1(y: 10)
//y没值
//var p3 = Point(x:5)
//x、y都没值
//var p4 = Point()

/*
 2、自定义初始化器
 */
struct Point2 {
    var x : Int = 0
    var y : Int = 0
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
//只有这个初始化器
var p21 = Point2(x: 10, y: 10)
//系统不再提供默认初始化器
//var p22 = Point2(y: 10)
//var p23 = Point2(x:5)
//var p24 = Point2()

/*
 3、结构体的内存查看
 */
struct Point3 {
    var x: Int = 0
    var y: Int = 0
    var origin: Bool = false
}
print(MemoryLayout<Point3>.size) // 17
print(MemoryLayout<Point3>.stride) // 24
print(MemoryLayout<Point3>.alignment) // 8

/*
 1、类的初始化器
 */
//没有给存储属性赋值，类的定义会报错
//class Point4 {
//    var x: Int
//    var y: Int
//}
//let p41 = Point4()//报错，没有给存储属性赋初始值

//只有空构造
class Point5 {
    var x: Int = 0
    var y: Int = 0
}
let p51 = Point5()//空构造中赋初始值，不报错
//let p52 = Point5(x: 10,y: 20)//默认没有其他构造器
//let p53 = Point5(x: 10)//默认没有其他构造器
//let p54 = Point2(y: 20)//默认没有其他构造器

/*
 2、类的反初始化器
 */
class Person {
    var x: Int = 0
    var y: Int = 0
    deinit {
        print("WY:Perosn对象销毁了")
    }
}

func testInit() -> Void {
    var person = Person()
}

testInit()//WY:Perosn对象销毁了

//继承关系中的反初始化器
class Student : Person {
    deinit {
        print("WY:Student对象销毁了")
    }
}
func testInit2() -> Void {
    var student = Student()
}
//WY:Student对象销毁了
//WY:Perosn对象销毁了
testInit2()

//类的内存大小分析
func testInstanceSize() {
    class Point {
        var x = 11//8
        var test = true//1
        var y = 22//8
    }//33、40、48
    
    let p = Point()
    print(class_getInstanceSize(type(of: p)))//40 print(class_getInstanceSize(Point.self))
    print(Mems.size(ofRef: p))//48
}
testInstanceSize()
}

func test2 (){
    struct WYPoint {
        var x: Int = 5
        var y: Int = 5
    }
    var p = WYPoint()
}

test2()

func test3 (){
    struct WYPoint {
        var x: Int = 5
        var y: Int = 5
    }
    var p = WYPoint()
}
