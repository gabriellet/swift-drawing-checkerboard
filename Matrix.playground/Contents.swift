//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

class GradientView : UIView {
    
    override func draw(_ rect: CGRect) {
        
        guard let context: CGContext = UIGraphicsGetCurrentContext() else { return }
        
        let squareGreen = UIColor(red: 20.0/255.0, green: 180.0/255.0, blue: 66.0/255.0, alpha: 1.0).cgColor
        let lineRed = UIColor(red: 150.0/255.0, green: 30.0/255.0, blue: 39.0/255.0, alpha: 1.0).cgColor
        let lineBlue = UIColor(red: 35.0/255.0, green: 80.0/255.0, blue: 145.0/255.0, alpha: 0.6).cgColor
        let startBlue = UIColor(red: 27.0/255.0, green: 94.0/255.0, blue: 125.0/255.0, alpha: 0.5).cgColor
        let endBlue = UIColor(red: 44.0/255.0, green: 60.0/255.0, blue: 110.0/255.0, alpha: 0.5).cgColor
        
        let locations: [CGFloat] = [0.0, 0.75]
        
        let colors = [startBlue, endBlue]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let gradient: CGGradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)!
        
        let startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint: CGPoint = CGPoint(x: rect.size.width, y: rect.size.height)
        
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        
        let step: CGFloat = 60.0
        let startX: CGFloat = (rect.size.width.truncatingRemainder(dividingBy: step)) * 0.5
        
        context.setStrokeColor(lineBlue)
        context.setLineWidth(2.0)
        
        for i in stride(from: startX, to: rect.size.width, by: step) {
            context.move(to: CGPoint(x: i, y: 0.0))
            context.addLine(to: CGPoint(x: i, y: rect.size.height))
            context.setShadow(offset: CGSize(width: 0, height: 0), blur: 4.0, color: lineBlue)
        }
        
        for j in stride(from: startX, to: rect.size.height, by: step) {
            context.move(to: CGPoint(x: 0.0, y: j))
            context.addLine(to: CGPoint(x: rect.size.width, y: j))
            context.setShadow(offset: CGSize(width: 0, height: 0), blur: 4.0, color: lineBlue)
        }
        
        context.strokePath()
        
        context.setStrokeColor(lineRed)
        context.setLineWidth(2.0)
        
        for i in stride(from: startX, to: rect.size.width, by: step) {
            context.move(to: CGPoint(x: i, y: 0.0))
            context.addLine(to: CGPoint(x: i, y: rect.size.height))
            context.setShadow(offset: CGSize(width: 0, height: 0), blur: 4.0, color: lineRed)
        }
        
        context.strokePath()
        
        let filled = [
            [true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true],
            [true, true, true, false, false, false, false, false, false, false, true, true, true, false, true, false, true],
            [true, false, false, false, true, false, false, false, false, false, true, false, false, false, true, false, true],
            [false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, true],
            [false, false, false, false, false, false, false, false, false, false, true, false, true, true, true, false, true],
            [true, false, false, false, false, false, false, false, false, false, true, false, false, true, true, false, true],
            [true, false, false, false, false, false, false, false, false, false, false, false, false, true, true, false, true],
            [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
            [true, false, false, false, false, false, true, false, false, false, true, true, true, true, true, false, true],
            [true, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, true],
            [true, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, true],
            [true, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, true],
            [true, false, false, false, false, false, false, false, false, true, false, false, false, false, true, false, true],
            ]
        var iPos = 0
        var jPos = 0
        
        for a in 0..<filled.count {
            for b in 0..<filled[a].count {
                print(filled[a][b], separator: " ", terminator: "\t")
            }
            print("\n")
        }
        
        for i in stride(from: 0.0, to: rect.size.height, by: step) {
            
            for j in stride(from: 0.0, to: rect.size.width, by: step) {
                
                if filled[iPos][jPos] == true {
                    print("filled: ", iPos, jPos, "draw: ", i, j)
                    let point = CGPoint(x: rect.origin.x + j + 4.0, y: rect.origin.y + i + 4.0)
                    context.setShadow(offset: CGSize(width: 0, height: 0), blur: 4.0, color: squareGreen)
                    context.setFillColor(squareGreen)
                    let square = CGRect(x: point.x, y: point.y, width: step - 4.0, height: step - 4.0)
                    context.addRect(square)
                }
                print("jPos: ", iPos, jPos)
                if jPos < filled[iPos].count-1 {
                    jPos += 1
                }
                
            }
            jPos = 0
            print("increment iPos: ", iPos, jPos)
            if iPos < filled.count-1 {
                iPos += 1
            }
            
        }
        
        context.fillPath()
        
    }
    
}

var baseView = GradientView(frame: CGRect(x: 0.0, y: 0.0, width: 1024.0, height: 768.0))

