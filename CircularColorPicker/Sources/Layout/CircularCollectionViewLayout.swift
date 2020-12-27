//
//  CircularCollectionViewLayout.swift
//  CATransfrom3d
//
//  Created by Bohdan Savych on 10/15/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import UIKit

final class CircularCollectionViewLayout: UICollectionViewLayout {
    static let maxItemsCount = 33
    static let itemSize = CGSize(width: 70, height: 70)
    static let minimumItemSpacing: CGFloat = -10
    
    private(set) var headIndex = 0
    
    private var attributesList = [CircularCollectionViewLayoutAttributes]()
    
    private(set) lazy var radius: CGFloat = {
        let radius = (CircularCollectionViewLayout.itemSize.width + CircularCollectionViewLayout.minimumItemSpacing) / 2 / sin(self.anglePerItem / 2)
        
        return radius
    }()
    
    private lazy var angleAtExtreme: CGFloat = {
        let angle = -CGFloat(numberOfItems() - 1) * anglePerItem
        return angle
    }()
    
    private var angle: CGFloat {
        let angle = angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize.width - collectionView!.bounds.width)
        return angle
    }
    
    private lazy var anglePerItem: CGFloat = {
        let angle = .pi * 2 / CGFloat(self.normalizedNumberOfItems())
        return angle
    }()
    
    override func prepare() {
        super.prepare()

        let theta = atan2(collectionView!.bounds.width / 2.0,
                          radius + (CircularCollectionViewLayout.itemSize.height / 2.0) - (collectionView!.bounds.height / 2.0))
        var startIndex = 0
        var endIndex = numberOfItems() - 1
        if (angle < -theta) {
          startIndex = Int(floor((-theta - angle) / anglePerItem))
        }
        endIndex = min(endIndex, Int(ceil((theta - angle) / anglePerItem)))
        if (endIndex < startIndex) {
          endIndex = 0
          startIndex = 0
        }
        
        let realStart = startIndex % CircularCollectionViewLayout.maxItemsCount
        var realEnd = endIndex % CircularCollectionViewLayout.maxItemsCount
        realEnd = realEnd < realStart ? realEnd + CircularCollectionViewLayout.maxItemsCount : realEnd
        self.headIndex = (realStart + (realEnd  - realStart) / 2) % CircularCollectionViewLayout.maxItemsCount

        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2
        attributesList = (startIndex...endIndex).map { i -> CircularCollectionViewLayoutAttributes in
            return self.generateAttribute(for: i, centerX: centerX)
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2
        return self.generateAttribute(for: indexPath.row, centerX: centerX)
    }
    
    override var collectionViewContentSize: CGSize {
        let size = CGSize(width: CGFloat(numberOfItems()) * (CircularCollectionViewLayout.itemSize.width + CircularCollectionViewLayout.minimumItemSpacing),
                          height: self.collectionView!.bounds.height)
        return size
    }
    
    override class var layoutAttributesClass: AnyClass {
        return CircularCollectionViewLayoutAttributes.self
    }
}

// MARK: - Private
private extension CircularCollectionViewLayout {
    @inline(__always) private func generateAttribute(for index: Int, centerX: CGFloat) -> CircularCollectionViewLayoutAttributes {
        let attributes = CircularCollectionViewLayoutAttributes(forCellWith: IndexPath(item: index, section: 0))
        attributes.size = CircularCollectionViewLayout.itemSize
        attributes.center = CGPoint(x: centerX, y: CircularCollectionViewLayout.itemSize.height / 2)
        attributes.angle = self.angle + (self.anglePerItem * CGFloat(index))
        
        let anchorPointX: CGFloat = 0.5
        let anchorPointY = ((CircularCollectionViewLayout.itemSize.height / 2.0) + radius) / CircularCollectionViewLayout.itemSize.height
        attributes.anchorPoint = CGPoint(x: anchorPointX, y: anchorPointY)
        
        return attributes
    }
    
    @inline(__always) private func numberOfItems() -> Int {
        return (self.collectionView?.numberOfItems(inSection: 0) ?? 0)
    }
    
    @inline(__always) private func normalizedNumberOfItems() -> Int {
        let number = numberOfItems()
        return number % CircularCollectionViewLayout.maxItemsCount == 0 ? CircularCollectionViewLayout.maxItemsCount : number
    }
}
    
// MARK: - Internal
extension CircularCollectionViewLayout {
    static func normalizeRows(_ rows: Int) -> Int {
      return rows % CircularCollectionViewLayout.maxItemsCount == 0
        ? CircularCollectionViewLayout.maxItemsCount
        : rows
    }
    
    static func calculateRadius(for normalizedElementsCount: Int, itemSize: CGSize, spacing: CGFloat) -> CGFloat {
        let angle = .pi * 2 / CGFloat(normalizedElementsCount)
        let radius = (itemSize.width + spacing) / 2 / sin(angle / 2)
        
        return radius
    }
    
    static func calculateRealRadius(itemSize: CGSize, items: Int) -> CGFloat {
        let anglPerItem = calculateAnglePerItem(for: items)
        let radius = (CircularCollectionViewLayout.itemSize.width) / 2 / sin(anglPerItem / 2)

        return radius
    }
    
    static func calculateIntersectionPoint(itemSize: CGSize, items: Int) -> CGFloat {
        let anglPerItem = calculateAnglePerItem(for: items)
        
        let radius = (CircularCollectionViewLayout.itemSize.width) / 2 / sin(anglPerItem / 2)
        let halfWidth = (CircularCollectionViewLayout.itemSize.width) / 2
        let triangleHeight = radius * cos(anglPerItem / 2)
        let tanAlpha = triangleHeight / halfWidth
        let x = halfWidth - ((itemSize.height) / tanAlpha)
        
        return x
    }
    
    static func calculateTopIntersectionYPoint(itemSize: CGSize, items: Int) -> CGFloat {
        let anglPerItem = calculateAnglePerItem(for: items)
        
        let radius = (CircularCollectionViewLayout.itemSize.width) / 2 / sin(anglPerItem / 2)
        let halfWidth = (CircularCollectionViewLayout.itemSize.width) / 2
        let triangleHeight = radius * cos(anglPerItem / 2)
        var x = sqrt((triangleHeight * triangleHeight) - (halfWidth * halfWidth))
        x = x - (triangleHeight - itemSize.height)

        return itemSize.height - x
    }
    
    static func calculateItemCutRadius(itemSize: CGSize, anglePerItem: CGFloat) -> CGFloat {
        return itemSize.height / 2 / cos(anglePerItem)
    }
    
    static func calculateItemCutIntersection(itemSize: CGSize, cutRadius: CGFloat, normalizedElementsCount: Int) -> CGFloat {
        let angle = .pi * 2 / CGFloat(normalizedElementsCount)

        return cutRadius - (cutRadius * cos(angle))
    }
    
    static func calculateInnerRadius(itemSize: CGSize, anglePerItem: CGFloat) -> CGFloat {
        let radius = (CircularCollectionViewLayout.itemSize.width) / 2 / sin(anglePerItem / 2)
        let triangleHeight = radius * cos(anglePerItem / 2)
        
        return triangleHeight
    }
    
    static func calculateInnerBottomRadius(itemSize: CGSize, items: Int) -> CGFloat {
        let anglPerItem = calculateAnglePerItem(for: items)
        let radius = (CircularCollectionViewLayout.itemSize.width) / 2 / sin(anglPerItem / 2)
        let triangleHeight = radius * cos(anglPerItem / 2)
        let bottomHeight = triangleHeight - itemSize.height
        let bottomRadius = bottomHeight / cos(anglPerItem / 2)

        return bottomRadius
    }

    static func calculateAnglePerItem(for items: Int) -> CGFloat {
        let angle = .pi * 2 / CGFloat(normalizeRows(items))
        return angle
    }
}
