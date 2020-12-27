//
//  CircularLayoutAttribute.swift
//  Coloretta
//
//  Created by Bohdan Savych on 10/20/19.
//  Copyright © 2019 Padres. All rights reserved.
//

import UIKit

final class CircularCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var angle: CGFloat = 0 {
        didSet {
            transform = CGAffineTransform(rotationAngle: angle)
        }
    }

    override func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes:CircularCollectionViewLayoutAttributes = super.copy(with: zone) as! CircularCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
}
