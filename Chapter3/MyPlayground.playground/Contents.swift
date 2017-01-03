//: Playground - noun: a place where people can play

import UIKit
// Chapter3-1
var str = "Hello, playground"
// Chapter3-2
// 10 + 20 を計算します。
var number = 10 + 20    // 答えは 30 になると思います。

/*
10 + 20 を計算します。
答えは 30 になると思います。
*/

// Chapter3-3

str = "I love Swift"

var x = 25
var y = 10
x + y
x - y
x * y
x / y
x % y

x++     // インクリメント演算子。x = x + 1と同じであり、xに1が加算される
x--     // デクリメント演算子。x = x - 1と同じであり、xに1が減算される
x += 5  // 複合代入演算子。x = x + 5と同じであり、xに5が加算される
x -= 5  // 複合代入演算子。x = x - 5と同じであり、xに5が減算される

var w = 25
let z = 3
w + z

//z = 10  // エラー。zに代入することはできないとXcodeに怒られる

// Chapter3-4
var str1 = "Hello, "
var str2 = " playground!"
str1 + str2

var num = 4649
var str3 = " playground!"
//num + str3

var number1 = 1
var number2 = 0.5
//number1 + number2

var number3 = 1
//number3 = 0.5

var count = 10          // Int型の変数になる。
var height = 10.0       // Double型の変数になる。
var message = "10"      // String型の変数になる。
var isOK = true         // Bool型の変数になる。

var count2: Int          // Int型の変数になる。
var height2: Double      // Double型の変数になる。
var message2: String     // String型の変数になる。
var isOK2: Bool          // Bool型の変数になる。

var count3: Int = 10         // Int型の変数になる。
var height3: Double = 10.0   // Double型の変数になる。
var message3: String = "10"  // String型の変数になる。
var isOK3: Bool = true       // Bool型の変数になる。

// Int型変数にint1をDouble型に変換して変数double1に代入する
var int1: Int = 10
var double1 = Double(int1)

// Double型変数double1をInt型に変換して変数int2に代入する
var int2 = Int(double1)

// Int型変数int2をString型に変換して変数string1に代入する
var string1 = String(int2)

// Double型変数double1をInt型に変換してInt型変数int1と足す
Int(double1) + int1

// Int型変数int1をDouble型に変換してDouble型変数double1と掛ける
Double(int1) * double1

// String型変数string1をInt型に変換して変数int3に代入する
var int3 = Int(string1)

// String型からInt型に変換したデータを格納したint3に10を足す
int3! + 10


// "さんじゅう"という文字で初期化されたString型の変数をIntに型変換
var string2 = "さんじゅう"
var int4 = Int(string2)

var opVer1: Int? = 10        // ?をつけたオプショナル値
opVer1! + 10    // アンラップすると計算できる
//opVer1 + 10     //ラップされた変数は計算できない


// 表示のためのString型変数str4
var str4 = "あなたのスコアは"
// スコア変数を宣言
var score = 0
// スコア変数をString化。表示のためのString型変数str5に代入
var str5 = String(score)
// 表示のためのString型変数str6
var str6 = "点です"
// 表示のためにString型変数をつなげる
str4 + str5 + str6

// スコア変数を宣言
var score2 = 0
//表示のためのString型変数str7
var str7 = "あなたのスコアは\(score)点です"

var str8 = "HELLO"
str8.lowercaseString

var str9 = "hello"
str9.uppercaseString

str9.characters.count

var str10 = "Hello, Swift"
str10.componentsSeparatedByString(",")

// Chapter3-5

// 配列
// 数字の配列と曜日の配列
var numArray = [1, 2, 3, 4, 5, 6, 7]
var daysArray = ["月", "火", "水", "木", "金", "土", "日"]

var numArray2: [Int] = [1, 2, 3, 4, 5, 6, 7]
var daysArray2: [String] = ["月", "火", "水", "木", "金", "土", "日"]
daysArray2[2]
daysArray2[2...4]

daysArray2.count

daysArray2[2] = "水曜"
daysArray2

daysArray2.removeAtIndex(2)
daysArray2

daysArray2.removeLast()
daysArray2

daysArray2.removeAll()


var daysArray3 = ["月", "火", "木", "金", "土"]
daysArray3.append("日")

daysArray3
daysArray3.insert("水", atIndex: 2)


// 辞書
var adDic = ["国":"日本","都道府県":"神奈川県","市町村":"横浜"]
var scoreDic = ["国語":50, "算数":55, "英語":80]

var adDic2: [String:String] = ["国":"日本","都道府県":"神奈川県","市町村":"横浜"]
var scoreDic2: [String:Int] = ["国語":50, "算数":55, "英語":80]

var scoreDic3 = ["国語":50, "算数":55, "英語":80]
scoreDic3["国語"]
scoreDic3["理科"]  // 登録していないキー"理科"を指定

var lang = scoreDic3["国語"]   // 国語の点数を変数langに代入
var math = scoreDic3["算数"]   // 算数の点数を変数mathに代入
var eng = scoreDic3["英語"]    // 英語の点数を変数engに代入
(lang! + math! + eng!) / 3   // 各変数をアンラップして計算

scoreDic3.count

scoreDic3["国語"] = 70
scoreDic3

scoreDic3["社会"] = 50
scoreDic3

scoreDic3.removeValueForKey("社会")
scoreDic3

scoreDic3.removeAll()
