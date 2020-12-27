//
//  DynamicItem.swift
//  Coloretta
//
//  Created by Bohdan Savych on 23.03.2020.
//  Copyright © 2020 Bohdan Savych. All rights reserved.
//

import UIKit

final class DynamicItem: NSObject, UIDynamicItem {
    var center = CGPoint.zero
    var bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
    var transform = CGAffineTransform.identity
}
