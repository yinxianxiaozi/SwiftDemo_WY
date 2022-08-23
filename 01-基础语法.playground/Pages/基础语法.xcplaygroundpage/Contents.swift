import UIKit

var greeting = "Hello, playground"

print("zwy \(greeting)")

//: #### 元组
/*
 元组的创建
 */
//直接赋值
let http404Error = (404,"Not Found")
//带有标识符
let http202Status = (statusCode:200,desciption:"OK")
/*
 元组的使用
 */
//用下标来获取
print("The status code is \(http404Error.0)")
//用标识符来获取
print("The status code is \(http202Status.statusCode)")
//直接统一赋值给多个变量
let (statusCode,statusMessage) = http404Error
let (justTheStatusCode,_) = http202Status
let (statusCode2, statusMessage2): (Int, String) =  http404Error//正确
print(statusCode2,statusMessage2)

//var 变量名：类型
//不限定数据类型
var i = 1
//限定数据类型
var str: String = "2"
print("wy:\(i)--\(str)")

//let 常量名：类型
//不限定数据类型
let l1 = "l1"
//限定数据类型
let l2: String = "l2"
//可以在运行时确定值，因此可以赋值变量,此时必须先确定数据类型
let l3:Int
var ii = 1
l3 = ii
print("wy:\(l1)--\(l2)--\(l3)")

//这里的Float、Character必须要加数据类型，其他的可加可不加
let a1: Int = 1
let a2: Float = 2.0
let a3: Bool = true
let a4: String = "a4"
let a5: Character = "5"
let array6:Array = [1,2,3]
let set7:Set = [4,5,5,5]
let dictionary: Dictionary = ["age":"18","name":"wy"]//类型要注意匹配


let a7: Int = 1
let a8: Double = Double(a7)
let a9: String = String(a7)
print(a9)
print(a8)

let ss = "swift"
print("快乐","学习","\(ss)语言", separator: "-", terminator: "~啦啦")
