//
//  PaintItem.swift
//  CircularColorPicker
//
//  Created by Bohdan Savych on 08/12/2020.
//

import UIKit

public final class PaintColor: Equatable {
  public let uicolor: UIColor
  public let uint32: UInt32
  public let cgColor: CGColor

  public init(uicolor: UIColor) {
    self.uicolor = uicolor
    self.uint32 = uicolor.toInt32Value()
    self.cgColor = uicolor.cgColor
  }

  func diff(from color: PaintColor) -> CGFloat {
    if self == color { return 0 }

    let currentComponents = self.uicolor.components()
    let diffColorComponents = color.uicolor.components()
    let rDiff = abs(currentComponents.r - diffColorComponents.r)
    let bDiff = abs(currentComponents.b - diffColorComponents.b)
    let gDiff = abs(currentComponents.g - diffColorComponents.g)

    return (rDiff + bDiff + gDiff) / 3
  }
  
  public static func == (lhs: PaintColor, rhs: PaintColor) -> Bool {
    lhs.uint32 == rhs.uint32
  }
}

extension UIColor {
  var redValue: CGFloat{ return CIColor(color: self).red }
  var greenValue: CGFloat{ return CIColor(color: self).green }
  var blueValue: CGFloat{ return CIColor(color: self).blue }
  var alphaValue: CGFloat{ return CIColor(color: self).alpha }

  static func interpolate(
    from: UIColor,
    to: UIColor,
    with fraction: CGFloat
  ) -> UIColor {
    let f = min(1, max(0, fraction))
    let c1 = from.components()
    let c2 = to.components()
    let r = c1.0 + (c2.0 - c1.0) * f
    let g = c1.1 + (c2.1 - c1.1) * f
    let b = c1.2 + (c2.2 - c1.2) * f
    let a = c1.3 + (c2.3 - c1.3) * f

    return UIColor(red: r, green: g, blue: b, alpha: a)
  }

  func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a:CGFloat) {
    guard let c = cgColor.components else { return (0, 0, 0, 1) }

    if (cgColor.numberOfComponents == 2) {
      return (c[0], c[0], c[0], c[1])
    }

    return (c[0], c[1], c[2], c[3])
  }

  func toInt32Value() -> UInt32 {
    let model = self.cgColor.colorSpace?.model
    var r, g, b, a: UInt8

    if model == .monochrome {
      var white: CGFloat = 0
      var alpha: CGFloat = 0
      self.getWhite(&white, alpha: &alpha)
      r = UInt8(white * 255)
      g = UInt8(white * 255)
      b = UInt8(white * 255)
      a = UInt8(alpha * 255)
    } else if model == .rgb {
      var rr: CGFloat = 0
      var gg: CGFloat = 0
      var bb: CGFloat = 0
      var aa: CGFloat = 0
      self.getRed(&rr, green: &gg, blue: &bb, alpha: &aa)
      r = UInt8(rr * 255)
      g = UInt8(gg * 255)
      b = UInt8(bb * 255)
      a = UInt8(aa * 255)
    } else {
      r = 0
      g = 0
      b = 0
      a = 0
    }

    var total = (UInt32(a) << 24)
    total += (UInt32(r) << 16)
    total += (UInt32(g) << 8)
    total += UInt32(b)

    return total
  }

}
