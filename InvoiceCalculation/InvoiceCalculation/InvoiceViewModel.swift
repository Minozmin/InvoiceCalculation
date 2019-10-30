//
//  InvoiceViewModel.swift
//  InvoiceCalculation
//
//  Created by Hehuimin on 2019/9/30.
//  Copyright © 2019 Hehuimin. All rights reserved.
//

import Foundation

class InvoiceViewModel: NSObject {
    public static func matchResult(targetAmount: Double, invoices: Array<Double>) -> ArraySlice<InvoiceModel> {
        // 从小到大排序 sorted()默认从小到大  .sorted { $0 < $1 } / .sorted(by: <)
        let newArray = invoices.sorted(by: >)
        let maxLength = self.getLength(array: newArray.reversed(), total: targetAmount)
        let minLength = self.getLength(array: newArray, total: targetAmount)
        var results = [Array<Double>]()
        for i in minLength ... maxLength {
            let arr = self.choose(array: newArray, size: i)
            results = results + arr
        }
        
        var all: ArraySlice<InvoiceModel> = []
        for item in results {
            let total = self.getSum(item)
            if total >= targetAmount {
                let model = InvoiceModel()
                model.totalAmount = total
                model.group = item.map { "\($0)" }.joined(separator: "-")
                all.append(model)
            }
        }
        
        let models = all.sorted { (model1, model2) -> Bool in
            return model1.totalAmount ?? 0 < model2.totalAmount ?? 0
        }

        // 返回数组前50条数据
        return models.prefix(50)
    }
    
    private static func getLength(array: Array<Double>, total: Double) -> Int {
        var sum: Double = 0
        var result: Int = 0
        for i in 0 ..< array.count {
            sum += array[i]
            if sum >= total {
                result = i
                break
            }
        }
        return result + 1
    }
    
    private static func choose(array: Array<Double>, size: Int) -> Array<Array<Double>> {
        var allResult = [Array<Double>]()

        func fn(arr: Array<Double>, size: Int, result: Array<Double>) {
            let arrCount = arr.count
            guard size < arrCount else {
                return
            }
            
            if size == arrCount  {
                allResult.append(arr + result)
                return
            }
            
            for (idx, item) in arr.enumerated() {
                var newResult = [Double]() + result
                newResult.append(item)
                
                if size == 1 {
                    allResult.append(newResult)
                }else {
                    var tempArr = [Double]() + arr
                    // 删除0~idx+1的
                    tempArr.removeSubrange(Range(uncheckedBounds: (lower: 0, upper: idx + 1)))
                    fn(arr: tempArr, size: size - 1, result: newResult)
                }
            }
        }
        
        fn(arr: array, size: size, result: [])
        
        return allResult
    }
    
    private static func getSum(_ array: Array<Double>) -> Double {
        var num: Double = 0
        for item in array {
            num = num + item
        }
        return num
    }
}
