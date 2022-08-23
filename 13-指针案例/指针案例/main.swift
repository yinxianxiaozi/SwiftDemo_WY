//
//  main.swift
//  指针案例
//
//  Created by zhangwenyi on 2022/5/16.
//

import Foundation

print("Hello, World!")

var arr = NSArray(objects: 11, 22, 33, 44)
arr.enumerateObjects { (obj, idx, stop) in
    print(idx, obj)
    if idx == 2 { // 下标为2就停止遍历
        stop.pointee = true//指针赋值
    }
}

var age = 11
////带泛型指针
//var ptr1 = withUnsafeMutablePointer(to: &age) { $0 }
//var ptr2 = withUnsafePointer(to: &age) { $0 }
//ptr1.pointee = 22
//print(ptr2.pointee) // 22
//print(age) // 22
//
////无泛型指针
//var ptr3 = withUnsafeMutablePointer(to: &age) { UnsafeMutableRawPointer($0) }
//var ptr4 = withUnsafePointer(to: &age) { UnsafeRawPointer($0) }
//ptr3.storeBytes(of: 33, as: Int.self)
//print(ptr4.load(as: Int.self)) // 33
//print(age) // 33
//
//class Person {
//    var age: Int
//    init (age: Int) {
//        self.age = age
//    }
//}
//var person = Person(age: 18)
////var ptr = withUnsafePointer(to: &person) { $0 }
////print("变量指针：",ptr)
//
////var personPointer = UnsafeMutableRawPointer?(bitPattern: ptr)
////print("对象指针：",personPointer)
//
//var ptr = unsafeBitCast(person, to: UnsafeRawPointer.self)
//print(ptr)

////方式一：
//var ptr = malloc(16)
//ptr?.storeBytes(of: 10, as: Int.self)
//ptr?.storeBytes(of: 20, toByteOffset: 8, as: Int.self)
//free(ptr)//释放内存

//方式二：
//var ptr = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
//ptr.storeBytes(of: 11, as: Int.self)
//ptr.advanced(by: 8).storeBytes(of: 22, as: Int.self)//偏移8字节
//ptr.deallocate()//释放

////方式三：
//var ptr = UnsafeMutablePointer<Int>.allocate(capacity: 2)
////ptr.initialize(repeating: 10, count: 2)//同时赋值两个值
//ptr.initialize(to: 10)//先初始化一个
//ptr.successor()//偏移8个字节
//ptr.successor().successor()//偏移16个字节


class Person {}
var person: Person = Person()
var ptr = unsafeBitCast(person, to: UnsafeRawPointer.self)
pt
print(ptr)
