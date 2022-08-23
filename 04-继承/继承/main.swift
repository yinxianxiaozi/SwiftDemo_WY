//
//  main.swift
//  继承
//
//  Created by 张文艺 on 2022/5/14.
//

import Foundation

print("Hello, World!")


/*
 1、内存结构
 */
func test1() {
    class Animal {
        var age = 0
    }
    class Dog : Animal {
        var weight = 0
    }
    class ErHa : Dog {
        var iq = 0
    }
    
    //父类
    let a = Animal()
    a.age = 10
    // 32
    print(Mems.size(ofRef: a))
    /*
     0x00000001000073e0
     0x0000000000000002
     0x000000000000000a
     0x0000000000000000
     */
    print(Mems.memStr(ofRef: a))
    
    //子类
    let d = Dog()
    d.age = 10
    d.weight = 20
    // 32
    print(Mems.size(ofRef: d))
    /*
     0x0000000100007490
     0x0000000000000002
     0x000000000000000a
     0x0000000000000014
     */
    print(Mems.memStr(ofRef: d))
    
    //孙子类
    let e = ErHa()
    e.age = 10
    e.weight = 20
    e.iq = 30
    // 48
    print(Mems.size(ofRef: e))
    /*
     0x0000000100007560
     0x0000000000000002
     0x000000000000000a
     0x0000000000000014
     0x000000000000001e
     0x0000000000000000
     */
    print(Mems.memStr(ofRef: e))
    
}
//test1()

/*
 2、下标、方法重写
 */
func test2() {
    class Animal {
        func speak() {
            print("Animal speak")
        }
        subscript(index: Int) -> Int {
            return index
        }
    }
    
    class Cat : Animal {
        //方法重写
        override func speak() {
            super.speak()
            print("Cat speak")
        }
        //下标重写
        override subscript(index: Int) -> Int {
            return super[index] + 1
        }
    }
    
    let cat: Animal = Cat()
    cat.speak()
    print(cat[1])
    
//    Cat.speak()
//    print(Cat(2))
}
//test2()

/*
 3、属性重写
 */
func test3() {
    class Circle {
        var radius: Int = 0
        var diameter: Int {
            set {
                print("Circle setDiameter")
                radius = newValue / 2
            }
            get {
                print("Circle getDiameter")
                return radius * 2
            }
        }
    }
    class SubCircle : Circle {
        override var radius: Int {
            set {
                print("SubCircle setradius")
                super.radius = newValue > 0 ? newValue : 0
            }
            get {
                print("SubCircle getradius")
                return super.radius
            }
        }
        
        override var diameter: Int {
            set {
                print("SubCircle setDiameter")
                super.diameter = newValue > 0 ? newValue : 0
            }
            get {
                print("SubCircle getDiameter")
                return super.diameter
            }
        }
    }
    let circle = SubCircle()
    
    //SubCircle setradius
    circle.radius = 6
    
    /*
     SubCircle getDiameter
     Circle getDiameter
     SubCircle getradius
     12
     */
    print(circle.diameter)
    
    //SubCircle setDiameter
    circle.diameter = 20
    
    /*
     SubCircle setDiameter
     Circle setDiameter
     SubCircle setradius
     SubCircle getradius
     10
     */
    print(circle.radius)
}
//test3()

/*
 4、属性观察器重写
 */
func test4() {
    class Circle {
        var radius: Int = 1
    }
    class SubCircle : Circle {
        override var radius: Int {
            willSet {
                print("SubCircle willSetRadius",newValue)
            }
            didSet {
                print("SubCircle didSetRadius",oldValue,radius)
            }
        }
    }
    let circle = SubCircle()
    /*
     SubCircle willSetRadius 10
     SubCircle didSetRadius 1 10
     */
    circle.radius = 10
}
test4()

