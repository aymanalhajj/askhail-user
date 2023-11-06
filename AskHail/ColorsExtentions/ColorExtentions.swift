//
//  ColorExtentions.swift
//  AskHail
//
//  Created by Mohab on 7/28/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
import UIKit


struct Colors {
    
    
    
    static let WhiteBlue = UIColor(hexString: "39CDEE"),
               DarkBlue = UIColor(hexString: "034B89"),
               lineView = UIColor(hexString: "39CDEE"),
               errorLineView = UIColor(hexString: "FF7994"),
               TopGradBtnColoer = UIColor(hexString: "6BE4FF"),
               ViewBackGroundColoer = UIColor(hexString: "#F5FDFF") ,
               ButtomGradBtnColoer = UIColor(hexString: "39CDEE"),
               PlaceHolderColoer = #colorLiteral(red: 0, green: 0.3139962554, blue: 0.5492177606, alpha: 0.5),
               AvilableColor = UIColor(hexString: "#49DB7F"),
               NotAvilableColor = UIColor(hexString: "#FF7A94")
    
               }

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
        
//        struct remeny {
//            static let primary = UIColor(netHex: 0x60737C)
//            static let secondry = UIColor(netHex: 0xF7EDEF)
//            static let filledStar = UIColor(netHex: 0xE8B332)
//            static let emptyStar = UIColor(netHex: 0xE9E5E5)
//            static let buttonBackGroundColor = UIColor(netHex: 0xDE406B)
//
//        }
//
//        convenience init(hex: String) {
//            let scanner = Scanner(string: hex)
//            scanner.scanLocation = 0
//
//            var rgbValue: UInt64 = 0
//
//            scanner.scanHexInt64(&rgbValue)
//
//            let r = (rgbValue & 0xff0000) >> 16
//            let g = (rgbValue & 0xff00) >> 8
//            let b = rgbValue & 0xff
//
//            self.init(
//                red: CGFloat(r) / 0xff,
//                green: CGFloat(g) / 0xff,
//                blue: CGFloat(b) / 0xff, alpha: 1
//            )
//        }
//
//        convenience init(red: Int, green: Int, blue: Int, opacity: Float) {
//            assert(red >= 0 && red <= 255, "Invalid red component")
//            assert(green >= 0 && green <= 255, "Invalid green component")
//            assert(blue >= 0 && blue <= 255, "Invalid blue component")
//            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(opacity))
//        }
//
//        convenience init(netHex:Int, alpha: Float = 1.0) {
//            self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, opacity: alpha)
//        }
//
//        class func colorFromHexString (_ hex: String, alpha: Float = 1.0) -> UIColor {
//            var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//
//            if cString.hasPrefix("#") {
//                cString.remove(at: cString.startIndex)
//            }
//
//            if cString.count != 6 {
//                return UIColor.gray
//            }
//
//            var rgbValue: UInt32 = 0
//            Scanner(string: cString).scanHexInt32(&rgbValue)
//
//            return UIColor(
//                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//                alpha: CGFloat(alpha)
//            )
//        }
//
//        // Check if the color is light or dark, as defined by the injected lightness threshold.
//        // Some people report that 0.7 is best. I suggest to find out for yourself.
//        // A nil value is returned if the lightness couldn't be determined.
//        func isLight(threshold: Float = 0.5) -> Bool? {
//            let originalCGColor = self.cgColor
//
//            // Now we need to convert it to the RGB colorspace. UIColor.white / UIColor.black are greyscale and not RGB.
//            // If you don't do this then you will crash when accessing components index 2 below when evaluating greyscale colors.
//            let RGBCGColor = originalCGColor.converted(to: CGColorSpaceCreateDeviceRGB(), intent: .defaultIntent, options: nil)
//            guard let components = RGBCGColor?.components else {
//                return nil
//            }
//            guard components.count >= 3 else {
//                return nil
//            }
//
//            let brightness = Float(((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000)
//            return (brightness > threshold)
//        }
//
//        convenience init(hexString: String) {
//            let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//            var int = UInt32()
//            Scanner(string: hex).scanHexInt32(&int)
//            let a, r, g, b: UInt32
//            switch hex.count {
//            case 3: // RGB (12-bit)
//                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//            case 6: // RGB (24-bit)
//                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//            case 8: // ARGB (32-bit)
//                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//            default:
//                (a, r, g, b) = (255, 0, 0, 0)
//            }
//            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
//        }
//
//        @nonobjc class var appThemeColor: UIColor {
//            return UIColor(hexString: "#0E4191")
//        }
    
}


extension UIColor {
    //For Display HTML Into String
    //    var hexString: String {
    //        let components = cgColor.components
    //        let r: CGFloat = components?[0] ?? 0.0
    //        let g: CGFloat = components?[1] ?? 0.0
    //        let b: CGFloat = components?[2] ?? 0.0
    //
    //        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)),
    //                               lroundf(Float(b * 255)))
    //
    //        return hexString
    //    }
    
    
    
    func hexStringFromColor(color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        
        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        print(hexString)
        return hexString
    }
    
    func colorWithHexString(hexString: String) -> UIColor {
        var colorString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()
        
        print(colorString)
        let alpha: CGFloat = 1.0
        let red: CGFloat = self.colorComponentFrom(colorString: colorString, start: 0, length: 2)
        let green: CGFloat = self.colorComponentFrom(colorString: colorString, start: 2, length: 2)
        let blue: CGFloat = self.colorComponentFrom(colorString: colorString, start: 4, length: 2)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {
        
        let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
        let endIndex = colorString.index(startIndex, offsetBy: length)
        let subString = colorString[startIndex..<endIndex]
        let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
        var hexComponent: UInt32 = 0
        
        guard Scanner(string: String(fullHexString)).scanHexInt32(&hexComponent) else {
            return 0
        }
        let hexFloat: CGFloat = CGFloat(hexComponent)
        let floatValue: CGFloat = CGFloat(hexFloat / 255.0)
        print(floatValue)
        return floatValue
    }
}
