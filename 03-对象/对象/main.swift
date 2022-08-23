//
//  main.swift
//  对象
//
//  Created by 张文艺 on 2022/5/14.
//

import Foundation

print("Hello, World!")

/*
 1、存储属性和计算属性
 */
func test1() {
    struct Circle {
        //存储属性
        var radius: Double
        //计算属性
        var diameter: Double {
            set {
                radius = newValue / 2
            }
            get {
                radius * 2
            }
        }
    }
    
    let circle = Circle(radius: 5)
    print(circle.radius)
    print(circle.diameter)
    
}
test1()


/*
 2、延迟存储属性
 */
//func test2() {
//    class PhotoView {
//        //这是一个存储属性，直接将闭包表达式结果赋值Image
//        lazy var image: Image = {
//            let url = "https://image.baidu.com/xx.png"
//            let data = Data(url: url)
//            return Image(data: data)
//        }()
//    }
//}

/*
 3、属性观察器
 */
func test3() {
    struct Circle {
        var radius: Double {
            willSet {
                print("willSet", newValue)
            }
            didSet {
                print("didSet", oldValue, radius)
            }
        }
        init() {
            self.radius = 1.0//不会触发观察器
            print("Circle init!")
        }
    }
    // Circle init!
    //willSet 2.0
    //didSet 1.0 2.0
    var cicle = Circle()
    cicle.radius = 2.0
}
test3()

/*
 4、计算属性
 */
func test4() {
    
    //计算属性和存储属性的区别
    struct Circle {
        //存储属性
        var radius: Double
        //计算属性
        var diameter: Double {
            set {
                radius = newValue / 2
            }
            get {
                radius * 2
            }
        }
    }
    
    let circle = Circle(radius: 5)
    print(circle.radius)
    print(circle.diameter)
    
    //只读计算属性
    struct Circle2 {
        //存储属性
        var radius: Double
        //计算属性
        var diameter: Double {
            get {
                radius * 2
            }
        }
    }
    
    //简写
    struct Circle3 {
        //存储属性
        var radius: Double
        //计算属性
        var diameter: Double { radius * 2 }
    }
    
    //枚举的rawValue的本质就是只读计算属性
    enum TestEnum: Int {
        case test1 = 1, test2 = 2, test3 = 3
        var rawValue: Int {
            switch self {
            case .test1:
                return 10
            case .test2:
                return 11
            case .test3:
                return 12
                //条件全部保证，就不需要增加default
                //            default:
                //                <#code#>
                //            }
            }
        }
    }
    print(TestEnum.test3.rawValue)//12
}
test4()

/*
 5、属性使用inout的分析
 */
func test5() {
    //定义一个结构体
    struct Shape {
        var width : Int
        var side : Int {
            willSet {
                print("willSetSide", newValue)
            }
            didSet {
                print("didSetSide", oldValue, side)
            }
        }
        var girth: Int {
            set {
                width = newValue / side
                print("setGirth", newValue)
            }
            get {
                print("getGirth")
                return width * side
            }
        }
        func show() {
            print("width=\(width), side=\(side), girth=\(girth)")
        }
    }
    
    //定义一个函数，传入属性
    func test(_ num: inout Int) {
    num = 20
    }
    
    //传入函数
    var s = Shape(width: 10, side: 4)
    test(&s.width)//传入存储属性
    s.show()
    test(&s.side)//传入带观察器的存储属性
    s.show()
    test(&s.girth)//传入计算属性
    s.show()
}
test5()

/*
 6、类型属性
 */
func test6() {
    //类型属性
    struct Car {
        static var count: Int = 0
        init() {
            Car.count += 1
        }
    }
    let c1 = Car()
    let c2 = Car()
    print(Car.count)//3
    
    //类型属性实现单例模式
    class FileManager {
        //属性获取
        static let shared = {
            FileManager()
        }()
        //私有无法调用
        private init() { }
    }
    //两个对象完全一样
    /*
     对象.(unknown context at $1000039a8).(unknown context at $100003a38).FileManager
     对象.(unknown context at $1000039a8).(unknown context at $100003a38).FileManager
     */
    print(FileManager.shared)
    print(FileManager.shared)
}
test6()

/*
 1、初始化器的分类
 */

/*
 2、两段式初始化
 */
func test7() {
    class Person {
        var age: Int
        init(age: Int) {
            self.age = age
            self.age = 10
        }
    }
    
    class Student : Person {
        var score: Int
        init(age: Int, score: Int) {
            self.score = score
            super.init(age: age)
            self.score = 100
        }
        
        convenience init() {
            self.init(age: 0, score: 0)
        }
    }
    var student: Student = Student()
}
test7()
/*
 3、初始化器的重写和继承
 */
func test8() {
    class Person {
        var age: Int
        var name: String
        init(age: Int, name: String) {
            self.age = age
            self.name = name
        }
        init() {
            self.age = 0
            self.name = ""
        }
        convenience init(age: Int) {
            self.init(age: age, name: "")
        }
        convenience init(name: String) {
            self.init(age: 0, name: name)
        }
    }
    
    class Student : Person {
        //重写或继承父类的指定初始化器，子类也会继承父类的便捷初始化器
        override init(age: Int, name: String) {
            super.init(age: age, name: name)
        }
        override init() {
            super.init(age: 0, name: "")
        }
    }
    
    var stu = Student(age: 10, name: "WY")
    var stu1 = Student()
    var stu2 = Student(age: 20)
    var stu3 = Student(name: "wenyi")
}

/*
 4、必需初始化器
 */
func test9() {
    class Person {
        var age : Int
        required init() {
            self.age = 0
        }
        init(age: Int) {
            self.age = age
        }
    }
    
    class Student: Person {
        var no : Int
        //正常初始化器规则
        init(no: Int) {
            self.no = no
            super.init(age: 0)
        }
        //重写父类的required初始化器
        required init() {
            self.no = 0
            super.init()
        }
    }
}

/*
 5、可失败初始化器
 */
func test10() {
    class Person {
        var name: String
        init!(name: String){
            if name.isEmpty {
                return nil
            }
            self.name = name
        }
        convenience init() {
            self.init(name: "")
        }
    }
//    var person: Person? = Person()
//    var age = person?.age()
//    var name = person?.name
}

/*
 6、可选链
 */
func test11() {
    class Car {
        var price = 0
    }
    class Dog {
        var weight = 0
    }
    class Person {
        var name: String = ""
        var dog: Dog = Dog()
        var car: Car? = Car()
        func age() -> Int { 18 }
        func eat() { print("Person eat") }
        subscript(index: Int) -> Int { index }
    }
    var person: Person? = Person()//拿到可选项对象
    var age1 = person!.age() // Int 自动解包，nil也会调用age()
    var age2 = person?.age() // Int? 自动解包，nil时直接返回nil
    var name = person?.name // String? 自动解包
    var index = person?[6] // Int? 获取下标，后面会讲到，本质也是一个函数
    
    var dog = person?.dog // Dog?
    var weight = person?.dog.weight // Int? 可选链，有一个为nil就直接返回nil
    var price = person?.car?.price // Int?
    
//    //数组调用
//    var scores = ["WY":[1,2,3],"wenyi":[4,5,6]]
//    scores["WY"]?[0] = 10
//    scores["wenyi"]?[2] += 10
//    scores["wenyiya"]?[0] = 10
//
//    //函数调用
//    var dict: [String : (Int, Int) -> Int] = {
//        "sum" : (+),
//        "diffenrence" : (-)
//    }
//    var result = dict["sum"]?(10,20)
//
//    //可选项赋值
//    var num1: Int? = 5
//    num1? = 10
//    var num2: Int? = nil
//    num2? = 10
}

/*
 1、方法
 */
func test12() {
    //方法定义
    class Car {
        static var cout = 0
        init() {
            Car.cout += 1
        }
        static func getCount() -> Int { cout }
    }
    let c0 = Car()
    let c1 = Car()
    let c2 = Car()
    print(Car.getCount()) // 3
    
    //关键字mutating
    struct Point {
        var x = 0.0, y = 0.0
        mutating func moveBy(deltaX: Double, deltaY: Double) {
            x += deltaX
            y += deltaY
            // self = Point(x: x + deltaX, y: y + deltaY)
        }
    }
    //关键字@discardableResult
    struct Point2 {
        var x = 0.0, y = 0.0
        @discardableResult   mutating func moveX(deltaX: Double) -> Double {
            x += deltaX
            return x
        }
    }
    var p = Point2()
    p.moveX(deltaX: 10)
}

/*
 2、下标
 */
func test13() {
    class Point {
        var x = 0.0, y = 0.0
        //index就是传入的下标
        //在函数内对不同的下标进行不同操作
        //也可以只有get方法
        subscript(index: Int) -> Double {
            set {
                if index == 0 {
                    x = newValue
                } else if index == 1 {
                    y = newValue
                }
            }
            get {
                if index == 0 {
                    return x
                } else if index == 1 {
                    return y
                }
                return 0
            }
        }
    }
    var p = Point()
    p[0] = 11.1
    p[1] = 22.2
    print(p.x) // 11.1
    print(p.y) // 22.2
    print(p[0]) // 11.1
    print(p[1]) // 22.2
    
    //设置参数标签
    class Point2 {
        var x = 0.0, y = 0.0
        subscript(index i: Int) -> Double {
            if i == 0 {
                return x
            } else if i == 1 {
                return y
            }
            return 0
        }
    }
    
    //类方法的下标
    class Sum {
        static subscript(v1: Int, v2: Int) -> Int {
            return v1 + v2
        }
    }
    print(Sum [10, 20]) // 30
}

/*
 3、结构体、类作为返回值对比
 */
//func test14() {
//
//    {
//        //定义类
//        class Point {
//            var x = 0, y = 0
//        }
//        class PointManager {
//            var point = Point()
//            subscript(index: Int) -> Point {
//                get { point }
//            }
//        }
//
//        var pm = PointManager()
//        pm[0].x = 11
//        pm[0].y = 22
//        // Point(x: 11, y: 22)
//        print(pm[0])
//        // Point(x: 11, y: 22)
//        print(pm.point)
//    }
//
//    {
//        //定义结构体
//        struct Point {
//            var x = 0, y = 0
//        }
//        class PointManager {
//            var point = Point()
//            subscript(index: Int) -> Point {
//                set { point = newValue }
//                get { point }
//            }
//        }
//
//        var pm = PointManager()
//        pm[0].x = 11
//        pm[0].y = 22
//        // Point(x: 11, y: 22)
//        print(pm[0])
//        // Point(x: 11, y: 22)
//        print(pm.point)
//    }
//
//}

/*
 4、多维下标
 */
func test15() {
    class Grid {
        var data = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8]
        ]
        subscript(row: Int, column: Int) -> Int {
            set {
                guard row >= 0 && row < 3 && column >= 0 && column < 3 else {
                    return
                }
                data [row][column] = newValue
            }
            get {
                guard row >= 0 && row < 3 && column >= 0 && column < 3 else {
                    return 0
                }
                return data [row][column]
            }
        }
    }
    
    let grid = Grid()
    grid[0, 1] = 77
    grid[1, 2] = 88
    grid[2, 0] = 99
    print(grid.data)
}
