//
//  main.swift
//  协议
//
//  Created by zhangwenyi on 2022/5/15.
//

import Foundation

print("Hello, World!")

/*
 1、基本定义
 提供方法、计算属性、下标
 */
protocol Drawable {
    func draw()
    var x: Int { get set }
    var y: Int { get }
    subscript(index: Int) -> Int {get set}
}

/*
 2、关键字
 */
//static 可以看到类中可以使用static也可以使用class，struct只能使用static
protocol Drawable2 {
    static func draw()
}

class Person1 : Drawable2 {
    class func draw(){
        print("Person1 draw")
    }
}
class Person2 : Drawable2 {
    static func draw() {
        print("Person2 draw")
    }
}

struct Person3 : Drawable2 {
    static func draw() {
        print("Person3 draw")
    }
}

Person1.draw()
Person2.draw()
Person3.draw()

//mutating 类本身就可以进行修改，不需要mutating标记，结构体需要使用mutating标记
protocol Drawable3 {
    mutating func draw()
}

class Size: Drawable3 {
    var width: Int = 0
    func draw() {
        width = 10
    }
}
struct Point : Drawable3 {
    var x: Int = 0
    mutating func draw() {
        x = 10
    }
}

/*
 3、属性
 协议中的属性需要指明是否可读可写，类在实现时只要能够实现可读可写就行，可以是计算属性也可以是存储属性
 */
protocol Drawable4 {
    func draw()
    var x: Int { get set}
    var y: Int { get }
    subscript(index: Int) -> Int { get set }
}

class Person31: Drawable4 {
    var x: Int = 0
    let y: Int = 0
    func draw() {
        print("Person31 draw")
    }
    subscript(index: Int) -> Int {
        set { }
        get { index }
    }
}

class Person32: Drawable4 {
    var x: Int {
        get { 0 }
        set { }
    }
    var y: Int { 0 }
    func draw() {
        print("Person32 draw")
    }
    subscript(index: Int) -> Int {
        set { }
        get { index }
    }
}

/*
 4、init
 Student的init既重写协议又重写父类的init，此时必须同时加上required和override
 */
protocol Livable {
    init(age: Int)
}
class Person41 {
    init(age: Int) {
        print("Person init")
    }
}
class Student: Person41, Livable {
    required override init(age: Int) {
        super.init(age: age)
        print("Student init")
    }
}
//Person init
//Student init
let stu = Student.init(age: 10)

protocol Livable2 {
    init()
    init?(age: Int)
    init?(no: Int)
}
class Person42: Livable2 {
    required init() {
        print("Person42 init")
    }
    required init?(age: Int) {
        print("Person42 init?")
    }
    required init!(no: Int) {
        print("Person42 init!")
    }
}
let p1 = Person42.init()
let p2 = Person42.init(age: 10)
let p3 = Person42.init(no: 100)
/*
 协议.Person42
 Optional(协议.Person42)
 Optional(协议.Person42)
 */
print(p1.self)
print(p2.self)
print(p3.self)

///*
// 5、继承
// */
//protocol Runnable {
//    func run()
//}
//protocol Livable : Runnable {
//    func breath()
//}
//class Person : Livable {
//    func breath() {}
//    func run() {}
//}

/*
 6、协议组合
 */
protocol Livable6 {}
protocol Runnable6 {}
class Person6 {}

// 1、接收Person或者其子类的实例
func fn0(obj: Person6) {}
// 2、接收遵守Livable协议的实例
func fn1(obj: Livable6) {}
// 3、接收同时遵守Livable、Runnable协议的实例
func fn2(obj: Livable6 & Runnable6) {}
// 4、接收同时遵守Livable、Runnable协议、并且是Person或者其子类的实例
func fn3(obj: Person6 & Livable6 & Runnable6) {}

//5、也可以直接定义一下使用
typealias RealPerson = Person6 & Livable6 & Runnable6
// 接收同时遵守Livable、Runnable协议、并且是Person或者其子类的实例
func fn4(obj: RealPerson) {}

/*
 7、CaseIterable,遍历枚举
 */
enum Season : CaseIterable {
    case spring, summer, autumn, winter
}
let seasons = Season.allCases
print(seasons.count) // 4
for season in seasons {
    print(season)
} // spring summer autumn winter

//CustomStringConvertible ，自定义打印字符串
//CustomDebugStringConvertible，打印debug字符串
class Person : CustomStringConvertible, CustomDebugStringConvertible {
    var age = 0
    var description: String { "person_\(age)" }
    var debugDescription: String { "debug_person_\(age)" }
}
var person = Person()
print(person) // person_0
debugPrint(person) // debug_person_0

/*
 8、任意类型
 */
var stu81: Any = 10
stu81 = "Jack"
var stu82: AnyObject = person
stu82 = Person42()
var classType: AnyClass = Person.self

/*
 9、类型判断
 */
protocol Runnable9 {
    func run()
}
class Person9 { }
class Student9 : Person9, Runnable9 {
    func run() {
        print("Student run")
    }
    func study() {
        print("Student study")
    }
}
//is
var stu9: Any = 10
print(stu9 is Int) // true
stu9 = "Jack"
print(stu9 is String) // true
stu9 = Student9()
print(stu9 is Person9) // true
print(stu9 is Student9) // true
print(stu9 is Runnable9) // true

//as
var stu92: Any = 10
(stu92 as? Student9)?.study() // 返回nil，不会调用study
stu92 = Student9()
(stu92 as? Student9)?.study() // 解包，Student study
(stu92 as! Student9).study() // 自动解包 ，可能会报错 Student study
(stu92 as? Runnable9)?.run() // 解包，Student run

/*
 10、元类型
 */
class Person10 {}
class Student10 : Person10 {}
var perType: Person10.Type = Person10.self//拿到Person10的类型赋值给perType变量
var stuType: Student10.Type = Student10.self
perType = Student10.self//因为是继承关系，所以可以这样赋值
var anyType: AnyObject.Type = Person10.self
anyType = Student10.self//任意类型

public typealias AnyClass = AnyObject.Type
var anyType2: AnyClass = Person10.self
anyType2 = Student10.self
var per = Person10()
var perType2 = type(of: per) // Person.self
print(Person10.self == type(of: per)) // true

//应用
class Animal { required init() {} }
class Cat : Animal {}
class Dog : Animal {}
class Pig : Animal {}

func create(_ clses: [Animal.Type]) -> [Animal] {
    var arr = [Animal]()
    for cls in clses {
        arr.append(cls.init())
    }
    return arr
}

print(create([Cat.self, Dog.self, Pig.self]))

protocol Runnable {
    func test() -> Self
}
class Person : Runnable {
    required init() {}
    func test() -> Self { type(of: self).init() }
}
class Student : Person {}
