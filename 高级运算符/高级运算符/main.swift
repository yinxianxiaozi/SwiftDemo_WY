//
//  main.swift
//  高级运算符
//
//  Created by zhangwenyi on 2022/5/15.
//

import Foundation

print("Hello, World!")

/*
 1、溢出运算符
 */
var min = UInt8.min
print(min &- 1) // 255, Int8.max

var max = UInt8.max
print(max &+ 1) // 0, Int8.min
print(max &* 2) // 254, 等价于 max &+ max

/*
 2、运算符重载
 */
//struct Point {
//    var x: Int, y: Int
//    static func + (p1: Point, p2: Point) -> Point {
//        Point(x: p1.x + p2.x, y: p1.y + p2.y)
//    }
//    static func - (p1: Point, p2: Point) -> Point {
//        Point(x: p1.x - p2.x, y: p1.y - p2.y)
//    }
//    static prefix func - (p: Point) -> Point {
//        Point(x: -p.x, y: -p.y)
//    }
//    static func += (p1: inout Point, p2: Point) {
//        p1 = p1 + p2
//    }
//
//    static prefix func ++ (p: inout Point) -> Point {
//        p += Point(x: 1, y: 1)
//        return p
//    }
//    static postfix func ++ (p: inout Point) -> Point {
//        let tmp = p
//        p += Point(x: 1, y: 1)
//        return tmp
//    }
//    static func == (p1: Point, p2: Point) -> Bool {
//        (p1.x == p2.x) && (p1.y == p2.y)
//    }
//}
//
//let point1 = Point(x: 1, y: 1)
//let point2 = Point(x: 1, y: 1)
//print(point1 + point2)//Point(x: 2, y: 2)
//print(point1 == point2)//true

/*
 Equatable协议
 */
//struct Point : Equatable {
//var x: Int, y: Int
//}
//var p1 = Point(x: 10, y: 20)
//var p2 = Point(x: 11, y: 22)
//print(p1 == p2) // false
//print(p1 != p2) // true
//
//class Person : Equatable {
//    var age: Int
//    init(age: Int) {
//        self.age = age
//    }
//    static func == (lhs: Person, rhs: Person) -> Bool {
//        lhs.age == rhs.age
//    }
//}
//var p1 = Person(age: 10)
//var p2 = Person(age: 11)
//print(p1 == p2)//false
//print(p1 != p2)//true

//enum Answer : Equatable {
//case wrong(Int)
//    case right
//}
//var s1 = Answer.wrong(10)
//var s2 = Answer.wrong(20)
//print(s1 == s2)

//Comparable协议
struct Student : Comparable {
    var age: Int
    var score: Int
    init(score: Int, age: Int) {
        self.score = score
        self.age = age
    }
    static func < (lhs: Student, rhs: Student) -> Bool {
        (lhs.score < rhs.score)
        || (lhs.score == rhs.score && lhs.age > rhs.age)
    }
    static func > (lhs: Student, rhs: Student) -> Bool {
        (lhs.score > rhs.score)
        || (lhs.score == rhs.score && lhs.age < rhs.age)
    }
    static func <= (lhs: Student, rhs: Student) -> Bool {
        !(lhs > rhs)
    }
    static func >= (lhs: Student, rhs: Student) -> Bool {
        !(lhs < rhs)
    }
}
var stu1 = Student(score: 100, age: 20)
var stu2 = Student(score: 98, age: 18)
var stu3 = Student(score: 100, age: 20)
print(stu1 > stu2) // true
print(stu1 >= stu2) // true
print(stu1 >= stu3) // true
print(stu1 <= stu3) // true
print(stu2 < stu1) // true
print(stu2 <= stu1) // true



