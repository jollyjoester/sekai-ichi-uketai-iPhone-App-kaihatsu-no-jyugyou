//: Playground - noun: a place where people can play

import UIKit

//足し算メソッド
func adding(num1: Int, num2: Int) -> Int {
    //変数addnumに引数num1と引数num2を足した値を代入
    let addNum = num1 + num2
    //引数num1と引数num2を足した値を格納した変数addnumを返す
    return addNum
}
//Int型の変数addResultを宣言
var addResult: Int
addResult = adding(num1: 1, num2: 2)
//引数にラベルを付けた足し算メソッド
func adding3(number1 num1: Int, number num2: Int) -> Int{
    //変数addnumに引数num1と引数num2を足した値を代入
    let addNum = num1 + num2
    //引数num1と引数num2を足した値を格納した変数addnumを返す
    return addNum
}
//addResultに足し算メソッドの引数を設定し、戻り値を代入
addResult = adding3(number1: 1, number: 2)
