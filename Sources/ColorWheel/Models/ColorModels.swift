
import SwiftUI

public struct RGB: Equatable {
    public let r: CGFloat
    public let g: CGFloat
    public let b: CGFloat
    
    public init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.r = max(0, min(1, r))
        self.g = max(0, min(1, g))
        self.b = max(0, min(1, b))
    }
    
    public var hsv: HSV {
        RGB.toHSV(r: r, g: g, b: b)
    }

    public var color: Color {
        Color(uiColor: uiColor)
    }
        
    public var uiColor: UIColor {
        UIColor(cgColor: cgColor)
    }
        
    public var cgColor: CGColor {
        CGColor(red: r, green: g, blue: b, alpha: 1.0)
    }
        
    // Initialize from Color
    public init(color: Color) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        UIColor(color).getRed(&r, green: &g, blue: &b, alpha: nil)
        self.init(r: r, g: g, b: b)
    }
        
    // Initialize from UIColor
    public init(uiColor: UIColor) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: nil)
        self.init(r: r, g: g, b: b)
    }

    private static func toHSV(r: CGFloat, g: CGFloat, b: CGFloat) -> HSV {
        let min = r < g ? (r < b ? r : b) : (g < b ? g : b)
        let max = r > g ? (r > b ? r : b) : (g > b ? g : b)
        
        let v = max
        let delta = max - min
        
        guard delta > 0.00001 else { return HSV(h: 0, s: 0, v: max) }
        guard max > 0 else { return HSV(h: -1, s: 0, v: v) }
        
        let s = delta / max
        let h = calculateHue(r: r, g: g, b: b, max: max, delta: delta)
        
        return HSV(h: h, s: s, v: v)
    }
    
    private static func calculateHue(r: CGFloat, g: CGFloat, b: CGFloat, max: CGFloat, delta: CGFloat) -> CGFloat {
        let h: CGFloat
        if r == max {
            h = (g - b) / delta
        } else if g == max {
            h = 2 + (b - r) / delta
        } else {
            h = 4 + (r - g) / delta
        }
        
        let hDegrees = h * 60
        return hDegrees < 0 ? hDegrees + 360 : hDegrees
    }
}

public struct HSV: Equatable {
    public let h: CGFloat
    public let s: CGFloat
    public let v: CGFloat
    
    public init(h: CGFloat, s: CGFloat, v: CGFloat) {
        self.h = h.truncatingRemainder(dividingBy: 360)
        self.s = max(0, min(1, s))
        self.v = max(0, min(1, v))
    }
    
    public var rgb: RGB {
        HSV.toRGB(h: h, s: s, v: v)
    }
    
    // Added Color functions
    public var color: Color {
        rgb.color
    }
    
    public var uiColor: UIColor {
        rgb.uiColor
    }
    
    public var cgColor: CGColor {
        rgb.cgColor
    }
    
    // Initialize from Color
    public init(color: Color) {
        let rgb = RGB(color: color)
        let hsv = rgb.hsv
        self.init(h: hsv.h, s: hsv.s, v: hsv.v)
    }
    
    // Initialize from UIColor
    public init(uiColor: UIColor) {
        let rgb = RGB(uiColor: uiColor)
        let hsv = rgb.hsv
        self.init(h: hsv.h, s: hsv.s, v: hsv.v)
    }

    private static func toRGB(h: CGFloat, s: CGFloat, v: CGFloat) -> RGB {
        if s == 0 { return RGB(r: v, g: v, b: v) }
        
        let angle = h.truncatingRemainder(dividingBy: 360)
        let sector = angle / 60
        let i = floor(sector)
        let f = sector - i
        
        let p = v * (1 - s)
        let q = v * (1 - (s * f))
        let t = v * (1 - (s * (1 - f)))
        
        switch i {
        case 0: return RGB(r: v, g: t, b: p)
        case 1: return RGB(r: q, g: v, b: p)
        case 2: return RGB(r: p, g: v, b: t)
        case 3: return RGB(r: p, g: q, b: v)
        case 4: return RGB(r: t, g: p, b: v)
        default: return RGB(r: v, g: p, b: q)
        }
    }
}
