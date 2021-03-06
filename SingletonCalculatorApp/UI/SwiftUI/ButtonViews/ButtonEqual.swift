//
//  EqualsButton.swift
//  SingletonCalculatorApp
//
//  Created by İbrahim Güler on 2.10.2021.
//

import SwiftUI

struct ButtonEqual: View {
    
    @Binding var firstNumber : String
    @Binding var nums : [String]

    static var calculater = Calculate()
    
    var body: some View {
        Button(action: {
            if self.firstNumber != "" {
                self.nums.append(self.firstNumber)
                
                var value = Int(nums[0]) ?? 0
                var i = 0
                while i < nums.count {
                    if nums[i] == "+"{
                        value = ButtonEqual.calculater.toAdd(num1: value, num2: Int(nums[i+1]) ?? 0)
                    } else if nums[i] == "-" {
                        value = ButtonEqual.calculater.toSubtract(num1: value, num2: Int(nums[i+1]) ?? 0)
                    } else if nums[i] == "x" {
                        value = ButtonEqual.calculater.toMultiply(num1: value, num2: Int(nums[i+1]) ?? 0)
                    } else if nums[i] == "÷" {
                        value = ButtonEqual.calculater.toDivide(num1: value, num2: Int(nums[i+1]) ?? 0)
                    }
                    i += 1
                }
                
                self.nums.removeAll()
                
                self.firstNumber = String(value)
            }
        }) {
            CircleView(iconText: "=", iconColor: .orange, wdh: 0.20, hgt: 70)
        }
    }
}

struct ButtonEqual_Previews: PreviewProvider {
    @State static var numsAdd : [String] = ["4", "+", "2"]
    @State static var numsSubtract : [String] = ["4", "-", "2"]
    @State static var numsMultiply : [String] = ["4", "x", "2"]
    @State static var numsDivide : [String] = ["4", "÷", "2"]
    
    static var previews: some View {
        Group {
            ButtonEqualTests(nums: self.$numsAdd)
            ButtonEqualTests(nums: self.$numsSubtract)
            ButtonEqualTests(nums: self.$numsMultiply)
            ButtonEqualTests(nums: self.$numsDivide)
        }
    }
    
    struct ButtonEqualTests : View {
        @State var firstNumber : String = "0"
        @Binding var nums : [String]
        
        let elseText : String = "Clear"
        var body: some View {
            VStack {
                Spacer()
                
                ButtonEqual(firstNumber: self.$firstNumber, nums: self.$nums)
                
                Spacer()
                
                Text("Result: \(self.firstNumber)")
                
                ForEach(nums, id: \.self) { num in
                    Text("Nums: \(num)")
                }
            }
        }
    }
}
