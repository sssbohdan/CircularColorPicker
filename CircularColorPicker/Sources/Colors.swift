//
//  Colors.swift
//  CircularColorPicker
//
//  Created by Bohdan Savych on 26/12/2020.
//

import UIKit

public final class Colors {
  public static var `default`: [[PaintColor]] {
    return [red1(), red2(),
            orange1(), orange2(), orange3(), orange4(),
            yellow1(), yellow2(), yellow3(),
            green1(), green2(), green3(), green4(), green5(), green6(), green7(),
            cyan1(),
            blue1(), blue2(), blue3(),
            purple1(), purple2(), purple3(), purple4(),
            gray1(),
            pink1(), pink2(), pink3(), pink4(), pink5(), pink6(), pink7(), pink8()]
  }

  private static func red1() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:1.00, green:0.84, blue:0.84, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:1.00, green:0.74, blue:0.71, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.99, green:0.56, blue:0.54, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.98, green:0.40, blue:0.34, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.85, green:0.38, blue:0.34, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.57, green:0.30, blue:0.28, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.35, green:0.22, blue:0.21, alpha:1.00))
    ]
  }

  private static func red2() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.99, green:0.85, blue:0.82, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.99, green:0.76, blue:0.70, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.99, green:0.60, blue:0.52, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.99, green:0.44, blue:0.32, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.84, green:0.42, blue:0.32, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.58, green:0.32, blue:0.27, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.36, green:0.24, blue:0.22, alpha:1.00))
    ]
  }

  private static func orange1() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.98, green:0.87, blue:0.82, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.98, green:0.78, blue:0.70, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.96, green:0.63, blue:0.51, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.96, green:0.48, blue:0.33, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.82, green:0.45, blue:0.33, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.57, green:0.35, blue:0.27, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.35, green:0.25, blue:0.20, alpha:1.00))
    ]
  }

  private static func orange2() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.99, green:0.89, blue:0.82, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.98, green:0.81, blue:0.71, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.97, green:0.70, blue:0.52, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.96, green:0.56, blue:0.32, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.84, green:0.52, blue:0.33, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.59, green:0.40, blue:0.29, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.36, green:0.27, blue:0.22, alpha:1.00))
    ]
  }

  private static func orange3() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:1.00, green:0.91, blue:0.82, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:1.00, green:0.85, blue:0.69, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:1.00, green:0.76, blue:0.51, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.99, green:0.66, blue:0.31, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.87, green:0.60, blue:0.33, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.63, green:0.46, blue:0.29, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.39, green:0.31, blue:0.23, alpha:1.00))
    ]
  }

  private static func orange4() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:1.00, green:0.93, blue:0.82, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:1.00, green:0.88, blue:0.70, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:1.00, green:0.81, blue:0.52, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.99, green:0.73, blue:0.31, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.88, green:0.67, blue:0.33, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.66, green:0.51, blue:0.30, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.41, green:0.33, blue:0.24, alpha:1.00))
    ]
  }

  private static func yellow1() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:1.00, green:0.96, blue:0.84, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.99, green:0.92, blue:0.71, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:1.00, green:0.88, blue:0.54, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.97, green:0.83, blue:0.37, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.87, green:0.75, blue:0.36, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.65, green:0.58, blue:0.33, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.41, green:0.38, blue:0.24, alpha:1.00))
    ]
  }

  private static func yellow2() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:1.00, green:0.97, blue:0.84, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:1.00, green:0.96, blue:0.73, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.99, green:0.93, blue:0.55, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.98, green:0.90, blue:0.37, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.88, green:0.81, blue:0.38, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.67, green:0.63, blue:0.35, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.42, green:0.39, blue:0.26, alpha:1.00))
    ]
  }

  private static func yellow3() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:1.00, green:0.98, blue:0.83, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:1.00, green:0.97, blue:0.70, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.99, green:0.95, blue:0.53, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.99, green:0.93, blue:0.35, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.89, green:0.83, blue:0.37, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.67, green:0.64, blue:0.35, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.42, green:0.40, blue:0.25, alpha:1.00))
    ]
  }

  private static func green1() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.96, green:0.98, blue:0.84, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.94, green:0.97, blue:0.73, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.91, green:0.97, blue:0.56, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.87, green:0.95, blue:0.41, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.78, green:0.84, blue:0.42, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.60, green:0.63, blue:0.36, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.38, green:0.40, blue:0.27, alpha:1.00))
    ]
  }

  private static func green2() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.93, green:0.94, blue:0.83, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.88, green:0.92, blue:0.72, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.83, green:0.91, blue:0.56, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.76, green:0.88, blue:0.40, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.70, green:0.78, blue:0.42, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.51, green:0.56, blue:0.35, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.34, green:0.36, blue:0.26, alpha:1.00))
    ]
  }

  private static func green3() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.84, green:0.90, blue:0.79, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.81, green:0.90, blue:0.71, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.74, green:0.89, blue:0.58, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.66, green:0.88, blue:0.44, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.60, green:0.76, blue:0.44, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.45, green:0.54, blue:0.35, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.29, green:0.33, blue:0.24, alpha:1.00))
    ]
  }

  private static func green4() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.78, green:0.84, blue:0.75, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.73, green:0.84, blue:0.67, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.65, green:0.83, blue:0.57, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.56, green:0.82, blue:0.45, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.53, green:0.71, blue:0.42, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.38, green:0.51, blue:0.34, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.26, green:0.31, blue:0.24, alpha:1.00))
    ]
  }

  private static func green5() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.73, green:0.80, blue:0.72, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.67, green:0.80, blue:0.65, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.60, green:0.78, blue:0.56, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.51, green:0.78, blue:0.45, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.46, green:0.68, blue:0.41, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.36, green:0.49, blue:0.34, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.24, green:0.31, blue:0.23, alpha:1.00))
    ]
  }

  private static func green6() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.71, green:0.76, blue:0.71, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.65, green:0.75, blue:0.65, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.55, green:0.73, blue:0.55, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.45, green:0.71, blue:0.45, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.41, green:0.62, blue:0.40, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.31, green:0.45, blue:0.31, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.23, green:0.29, blue:0.23, alpha:1.00))
    ]
  }

  private static func green7() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.75, green:0.83, blue:0.78, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.68, green:0.81, blue:0.73, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.59, green:0.79, blue:0.66, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.49, green:0.76, blue:0.58, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.41, green:0.67, blue:0.49, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.32, green:0.49, blue:0.38, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.22, green:0.31, blue:0.25, alpha:1.00))
    ]
  }

  private static func green8() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.78, green:0.87, blue:0.84, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.72, green:0.87, blue:0.81, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.62, green:0.85, blue:0.76, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.52, green:0.84, blue:0.71, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.42, green:0.73, blue:0.61, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.33, green:0.52, blue:0.45, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.23, green:0.33, blue:0.29, alpha:1.00))
    ]
  }

  private static func cyan1() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.77, green:0.89, blue:0.89, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.70, green:0.89, blue:0.88, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.58, green:0.88, blue:0.87, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.45, green:0.87, blue:0.85, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.39, green:0.77, blue:0.75, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.32, green:0.56, blue:0.55, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.22, green:0.36, blue:0.35, alpha:1.00))
    ]
  }

  private static func blue1() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.76, green:0.87, blue:0.88, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.69, green:0.85, blue:0.88, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.55, green:0.84, blue:0.87, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.42, green:0.81, blue:0.86, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.37, green:0.73, blue:0.76, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.31, green:0.55, blue:0.57, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.23, green:0.35, blue:0.35, alpha:1.00))
    ]
  }

  private static func blue2() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.75, green:0.83, blue:0.87, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.66, green:0.81, blue:0.86, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.55, green:0.78, blue:0.86, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.40, green:0.73, blue:0.84, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.36, green:0.65, blue:0.75, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.32, green:0.49, blue:0.58, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.24, green:0.33, blue:0.36, alpha:1.00))
    ]
  }

  private static func blue3() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.75, green:0.80, blue:0.85, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.65, green:0.77, blue:0.85, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.52, green:0.71, blue:0.84, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.39, green:0.66, blue:0.83, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.36, green:0.59, blue:0.75, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.32, green:0.46, blue:0.58, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.23, green:0.31, blue:0.36, alpha:1.00))
    ]
  }

  private static func purple1() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.72, green:0.78, blue:0.84, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.63, green:0.73, blue:0.83, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.51, green:0.66, blue:0.83, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.37, green:0.58, blue:0.82, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.35, green:0.53, blue:0.74, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.31, green:0.43, blue:0.56, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.22, green:0.29, blue:0.35, alpha:1.00))
    ]
  }

  private static func purple2() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.71, green:0.76, blue:0.84, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.63, green:0.70, blue:0.83, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.50, green:0.61, blue:0.82, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.37, green:0.52, blue:0.80, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.35, green:0.48, blue:0.73, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.30, green:0.39, blue:0.55, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.22, green:0.27, blue:0.35, alpha:1.00))
    ]
  }

  private static func purple3() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.73, green:0.74, blue:0.84, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.65, green:0.67, blue:0.83, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.52, green:0.56, blue:0.82, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.38, green:0.45, blue:0.81, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.36, green:0.42, blue:0.72, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.32, green:0.35, blue:0.55, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.23, green:0.25, blue:0.34, alpha:1.00))
    ]
  }

  private static func purple4() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.72, green:0.72, blue:0.83, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.65, green:0.64, blue:0.83, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.53, green:0.53, blue:0.83, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.41, green:0.41, blue:0.82, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.37, green:0.38, blue:0.73, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.32, green:0.32, blue:0.54, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.23, green:0.22, blue:0.35, alpha:1.00))
    ]
  }

  private static func gray1() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.96, green:0.97, blue:0.97, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.86, green:0.87, blue:0.87, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.73, green:0.74, blue:0.74, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.59, green:0.59, blue:0.60, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.43, green:0.44, blue:0.44, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.09, green:0.10, blue:0.10, alpha:1.00))
    ]
  }

  private static func pink1() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.75, green:0.76, blue:0.85, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.70, green:0.68, blue:0.85, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.59, green:0.56, blue:0.84, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.48, green:0.44, blue:0.83, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.43, green:0.39, blue:0.73, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.34, green:0.33, blue:0.53, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.24, green:0.23, blue:0.33, alpha:1.00))
    ]
  }

  private static func pink2() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.80, green:0.78, blue:0.88, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.75, green:0.71, blue:0.87, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.66, green:0.59, blue:0.86, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.58, green:0.46, blue:0.85, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.50, green:0.41, blue:0.74, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.38, green:0.32, blue:0.53, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.25, green:0.23, blue:0.33, alpha:1.00))
    ]
  }

  private static func pink3() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.85, green:0.81, blue:0.91, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.80, green:0.73, blue:0.90, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.74, green:0.62, blue:0.90, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.67, green:0.49, blue:0.88, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.57, green:0.42, blue:0.76, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.41, green:0.31, blue:0.52, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.27, green:0.23, blue:0.33, alpha:1.00))
    ]
  }

  private static func pink4() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.88, green:0.83, blue:0.93, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.85, green:0.75, blue:0.93, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.80, green:0.64, blue:0.92, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.76, green:0.51, blue:0.91, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.65, green:0.43, blue:0.76, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.44, green:0.31, blue:0.52, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.28, green:0.23, blue:0.32, alpha:1.00))
    ]
  }

  private static func pink5() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.92, green:0.85, blue:0.95, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.91, green:0.77, blue:0.95, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.88, green:0.64, blue:0.94, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.85, green:0.52, blue:0.93, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.72, green:0.44, blue:0.79, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.49, green:0.33, blue:0.54, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.31, green:0.24, blue:0.33, alpha:1.00))
    ]
  }

  private static func pink6() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.96, green:0.85, blue:0.96, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.95, green:0.78, blue:0.96, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.95, green:0.65, blue:0.96, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.94, green:0.52, blue:0.95, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.80, green:0.45, blue:0.81, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.55, green:0.34, blue:0.55, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.33, green:0.24, blue:0.35, alpha:1.00))
    ]
  }

  private static func pink7() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.98, green:0.87, blue:0.95, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.97, green:0.77, blue:0.93, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.96, green:0.64, blue:0.88, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.96, green:0.50, blue:0.84, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.83, green:0.44, blue:0.71, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.56, green:0.34, blue:0.50, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.34, green:0.25, blue:0.32, alpha:1.00))
    ]
  }

  private static func pink8() -> [PaintColor] {
    return [
      PaintColor(uicolor: UIColor(red:0.98, green:0.85, blue:0.87, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.98, green:0.73, blue:0.78, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.96, green:0.57, blue:0.65, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.95, green:0.38, blue:0.50, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.81, green:0.37, blue:0.47, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.55, green:0.30, blue:0.35, alpha:1.00)),
      PaintColor(uicolor: UIColor(red:0.35, green:0.23, blue:0.25, alpha:1.00))
    ]
  }
}
