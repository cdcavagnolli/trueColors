import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    func hexColor(hex:String) -> (color: UIColor, red: Int, green: Int, blue: Int)? {
        var hexColor: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        hexColor.remove(at: hexColor.startIndex)
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexColor).scanHexInt64(&rgbValue)
        
        if hexColor != "000000" && rgbValue == 000000 {
            return nil
        } else {
            let color = UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                           green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                           blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                           alpha: CGFloat(1.0))
            
            return (color: color,
                    red: Int((rgbValue & 0xFF0000) >> 16),
                    green: Int((rgbValue & 0x00FF00) >> 8),
                    blue: Int(rgbValue & 0x0000FF))
        }
    }
}

