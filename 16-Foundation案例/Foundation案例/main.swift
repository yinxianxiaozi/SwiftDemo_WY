//
//  main.swift
//  Foundation案例
//
//  Created by zhangwenyi on 2022/5/19.
//

import Foundation

print("Hello, World!")

//test1()
//test2()
test3()

func testString() {
    /*
     1、空字符串
     */
    var emptyStr1 = ""
    var emptyStr2 = String()

    /*
     2、字符串拼接
     */
    var str: String = "1"
    // 拼接， jack_rose
    str.append("_2")
    // 重载运算符 +
    str = str + "_3"
    // 重载运算符 +=
    str += "_4"
    // \()插值
    str = "\(str)_5"
    // 长度， 9，1_2_3_4_5
    print(str.count)

    /*
     3、截取子串
     */
    var str3 = "123456"
    print(str.hasPrefix("123"))
    print(str.hasSuffix("456"))


    /*
     4、字符串插入
     */
    var str4 = "1_2"
    // 1_2_
    str4.insert("_", at: str4.endIndex)
    // 1_2_3_4
    str4.insert(contentsOf: "3_4", at: str4.endIndex)
    // 1666_2_3_4
    str4.insert(contentsOf: "666", at: str4.index(after: str4.startIndex))
    // 1666_2_3_8884
    str4.insert(contentsOf: "888", at: str4.index(before: str4.endIndex))
    // 1666hello_2_3_8884
    str4.insert(contentsOf: "hello", at: str4.index(str4.startIndex, offsetBy: 4))

    /*
     5、字符串删除
     */
    // 666hello_2_3_8884
    str4.remove(at: str4.firstIndex(of: "1")!)
    // hello_2_3_8884
    str4.removeAll { $0 == "6" }
    var range = str4.index(str4.endIndex, offsetBy: -4)..<str4.index(before: str4.endIndex)
    // hello_2_3_4
    str4.removeSubrange(range)

    /*
     6、Substring
     */
    var str6 = "1_2_3_4_5"
    // 1_2
    var substr1 = str.prefix(3)
    // 4_5
    var substr2 = str.suffix(3)
    // 1_2
    var range2 = str6.startIndex..<str6.index(str6.startIndex, offsetBy: 3)
    var substr3 = str[range2]

    // 最初的String，1_2_3_4_5
    print(substr3.base)
    var str61 = String(substr3)

    /*
    7、 Substring -> String
     */
    for c in "jack" { // c是Character类型 print(c)
        print(c)
    }

    var str7 = "jack"
    // c是Character类型
    var c = str7[str7.startIndex]

    /*
     8、多行Sting
     */
    // 缩进以结尾的3引号为对齐线
    //let str8 = """
    //            1
    //                2
    //    3
    //        4
    //        """
    //print(str8)

    func test() {
        /*
        String和NSString的转换
        */
        var str1: String = "WY"
        var str2: NSString = "wenyi"

        var str3 = str1 as NSString
        var str4 = str2 as String

        // ja
        var str5 = str3.substring(with: NSRange(location: 0, length: 2))
        print(str5)
    }
}



