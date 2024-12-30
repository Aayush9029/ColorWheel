import CoreGraphics

internal enum GeometryUtils {
    static func angleToHue(_ angle: CGFloat) -> CGFloat {
        var angle = angle * 180 / .pi
        if angle < 0 {
            angle += 360
        }
        return angle
    }
    
    static func distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
        let xDist = point1.x - point2.x
        let yDist = point1.y - point2.y
        return sqrt(xDist * xDist + yDist * yDist)
    }
}