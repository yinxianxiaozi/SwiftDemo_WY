//
//  main.swift
//  Error
//
//  Created by 张文艺 on 2022/5/14.
//

import Foundation

print("Hello, World!")

/*
 1、抛出异常
 */
enum SomeError : Error {
    case illegalArg(String)
    case outOfBounds(Int, Int)
    case outOfMemory
}

func divide(_ num1: Int, _ num2: Int) throws -> Int {
    if num2 == 0 {
        throw SomeError.illegalArg("0不能作为除数")
    }
    return num1 / num2
}
var result = try divide(20,10)

/*
 2、do- catch
 */
func test() {
    print("1")
    do {
        print("2")
        print(try divide(20, 0))
        print("3")
    } catch let SomeError.illegalArg(msg) {
        print("参数异常:", msg)
    } catch let SomeError.outOfBounds(size, index) {      print("下标越界:", "size=\(size)", "index=\(index)")
    } catch SomeError.outOfMemory {
        print("内存溢出")
    } catch {
        print("其他错误")
    }
    print("4")
}
/*
 1
 2
 参数异常: 0不能作为除数
 4
 */
//test()

/*
 3、throws抛出异常
 */
func test2() throws {
    do {
        print(try divide(200, 0))
    } catch is SomeError {
        print("Thisis SomeError")
    }
}

func test1() throws {
    try test2()
}

func test0() throws {
    try test1()
}

// Thisis SomeError
//try test0()

/*
 4、rethorows
 */
func exec(_ fn: (Int, Int) throws -> Int, _ num1: Int, _ num2: Int) rethrows {
print(try fn(num1, num2))
}
// Fatal error: Error raised at top level
//try exec(divide, 20, 0)

/*
 5、Error不处理方式
 */
func test3() {
    print("1")
    var result1 = try? divide(20, 10)
    var result2 = try? divide(20, 0)
    var result3 = try! divide(20, 10)
    print("2")
}
//test3()

/*
 6、defer
 */
func fn1() {
    print("fn1")
}
func fn2() {
    print("fn2")
}
func test4() {
    defer {
        fn1()
    }
    defer {
        fn2()
    }
}
test4()

/*
 7、断言
 */
func divide2(_ v1: Int, _ v2: Int) -> Int { assert(v2 != 0, "除数不能为0")
    return v1 / v2
}
print(divide2(20, 0))

/*
 8、fatalError
 */
func test(_ num: Int) -> Int {
    if num >= 0 {
        return 1
    }
    fatalError("num不能小于0")
}
