//
//  Calculator.swift
//  MyCalculator
//
//  Created by wenge on 2021/9/28.
//

import UIKit

var is_Rad = true

class Calculator: NSObject {
    enum Operation {
        case UnaryOp((Double)->Double)
        case BinaryOp((Double,Double)->Double)
        case EqualOp
        case Constant(Double)
    }
    
    var operations = [
        "+": Operation.BinaryOp{
            (op1, op2) in
            return op1 + op2
        },
        
        "-": Operation.BinaryOp{
            (op1, op2) in
            return op1 - op2
        },
        
        "×": Operation.BinaryOp{
            (op1, op2) in
            return op1 * op2
        },
        
        "÷": Operation.BinaryOp{
            (op1, op2) in
            return op1 / op2
        },
        
        "=":Operation.EqualOp,
        
        "+/-": Operation.UnaryOp{
            op in
            return -op
        },
        
        "%": Operation.UnaryOp{
            op in
            return op / 100.0
        },
        
        "AC": Operation.UnaryOp {
            _ in
            return 0
        },
        
        "x²": Operation.UnaryOp {
            op in
            return pow(op,2)
        },
        
        "x³": Operation.UnaryOp {
            op in
            return pow(op,3)
        },
        
        "xʸ": Operation.BinaryOp {
            op1,op2 in
            return pow(op1,op2)
        },
        
        "yˣ": Operation.BinaryOp {
            op1,op2 in
            return pow(op2,op1)
        },
        
        "eˣ": Operation.UnaryOp {
            op in
            return exp(op)
        },
        
        "2ˣ": Operation.UnaryOp {
            op in
            return pow(2,op)
        },
        
        "10ˣ": Operation.UnaryOp {
            op in
            return pow(10,op)
        },
        
        "1/x": Operation.UnaryOp {
            op in
            return 1.0/op
        },
        
        "²√x": Operation.UnaryOp {
            op in
            return sqrt(op)
        },
        
        "³√x": Operation.UnaryOp {
            op in
            return cbrt(op)
        },
        
        "ʸ√x":Operation.BinaryOp {
            op1,op2 in
            return pow(op1,1.0/op2)
        },
        
        "ln": Operation.UnaryOp {
            op in
            return log(op)
        },
        
        "logy": Operation.BinaryOp {
            op1,op2 in
            return log(op1)/log(op2)
        },
        
        "log₁₀": Operation.UnaryOp {
            op in
            return log10(op)
        },
        
        "log2": Operation.UnaryOp {
            op in
            return log2(op)
        },
        
        "x!": Operation.UnaryOp {
            op in
            var tmp = op
            var res = 1.0
            while (tmp > 1){
                res *= tmp
                tmp -= 1.0
            }
            return res
        },
        
        "sin": Operation.UnaryOp {
            op in
            if is_Rad{
                return sin(op)
            }
            else{
                return sin(op/180.0 * .pi)
            }
        },
        
        "asin": Operation.UnaryOp {
            op in
            if is_Rad{
                return asin(op)
            }
            else{
                return asin(op/180.0 * .pi)
            }
        },
        
        "cos": Operation.UnaryOp {
            op in
            if is_Rad{
                return cos(op)
            }
            else{
                return cos(op/180.0 * .pi)
            }
        },
        
        "acos": Operation.UnaryOp {
            op in
            if is_Rad{
                return acos(op)
            }
            else{
                return acos(op/180.0 * .pi)
            }
        },
        
        "tan": Operation.UnaryOp {
            op in
            if is_Rad{
                return tan(op)
            }
            else{
                return tan(op/180.0 * .pi)
            }
        },
        
        "atan": Operation.UnaryOp {
            op in
            if is_Rad{
                return atan(op)
            }
            else{
                return atan(op/180.0 * .pi)
            }
        },
        
        "e": Operation.UnaryOp {
            op in
            return exp(1)
        },
        
        "EE": Operation.BinaryOp {
            op1, op2 in
            return op1 * pow(10,op2)
        },
        
        "sinh": Operation.UnaryOp {
            op in
            if is_Rad{
                return sinh(op)
            }
            else{
                return sinh(op/180.0 * .pi)
            }
        },
        
        "asinh": Operation.UnaryOp {
            op in
            if is_Rad{
                return asinh(op)
            }
            else{
                return asinh(op/180.0 * .pi)
            }
        },
        
        "cosh": Operation.UnaryOp {
            op in
            if is_Rad{
                return cosh(op)
            }
            else{
                return cosh(op/180.0 * .pi)
            }
        },
        
        "acosh": Operation.UnaryOp {
            op in
            if is_Rad{
                return acosh(op)
            }
            else{
                return acosh(op/180.0 * .pi)
            }
        },
        
        "tanh": Operation.UnaryOp {
            op in
            if is_Rad{
                return tanh(op)
            }
            else{
                return tanh(op/180.0 * .pi)
            }
        },
        
        "atanh": Operation.UnaryOp {
            op in
            if is_Rad{
                return atanh(op)
            }
            else{
                return atanh(op/180.0 * .pi)
            }
        },
        
        "π": Operation.UnaryOp {
            op in
            return .pi
        },
        
        "Rand": Operation.UnaryOp {
            op in
            return drand48()
        },
        
        "Rad": Operation.UnaryOp {
            op in
            is_Rad = !is_Rad
            return op
        },
        
        "Deg": Operation.UnaryOp {
            op in
            is_Rad = !is_Rad
            return op
        }
    ]
    
    struct Intermediate {
        var firstOp: Double
        var waitingOperation: (Double,Double) -> Double
    }
    var pendingOp: Intermediate? = nil
    
    func performOperation(operation: String, operand: Double)->Double?{
        if let op = operations[operation] {
            switch op {
            case .BinaryOp(let function):
                pendingOp = Intermediate(firstOp: operand, waitingOperation: function)
                return nil
            case .Constant(let value):
                return value
            case .EqualOp:
                if pendingOp == nil{
                    return operand
                }
                else{
                    let res = pendingOp!.waitingOperation(pendingOp!.firstOp,operand)
                    pendingOp = nil
                    return res
                }
            case .UnaryOp(let function):
                return function(operand)
            }
        }
        return nil
    }
}
