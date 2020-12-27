//
//  ColorCollectionViewCell.swift
//  CATransfrom3d
//
//  Created by Bohdan Savych on 10/17/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import UIKit

final class ColorCollectionViewCell: UICollectionViewCell {
  private lazy var layerConfigured = false
  private lazy var topView = UIView()
  private lazy var bottomView = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.setup()
  }

  required init?(coder aDecoder: NSCoder) { nil }

  override func awakeFromNib() {
    super.awakeFromNib()

    self.contentView.layer.shouldRasterize = true
    self.contentView.layer.rasterizationScale = UIScreen.main.scale
  }

  func configure(
    color: UIColor,
    prevColor: UIColor,
    itemSize: CGSize,
    r: CGFloat,
    intersectionPoint: CGFloat,
    topIntersectionYPoint: CGFloat,
    isLast: Bool) {
    self.contentView.backgroundColor = color
    self.backgroundColor = .clear
    self.topView.backgroundColor = prevColor
    self.bottomView.backgroundColor = color
    self.bottomView.isHidden = isLast

    if !self.layerConfigured {
      self.layerConfigured = true
      self.configureLayer(
        size: itemSize,
        r: r,
        intersectionPoint: intersectionPoint,
        topIntersectionYPoint: topIntersectionYPoint)
    }
  }
}

// MARK: - Private
private extension ColorCollectionViewCell {
   func setup() {
    self.topView.translatesAutoresizingMaskIntoConstraints = false
    self.bottomView.translatesAutoresizingMaskIntoConstraints = false

    self.addSubview(self.topView)
    self.addSubview(self.bottomView)

    NSLayoutConstraint.activate([
      self.topView.topAnchor.constraint(equalTo: self.topAnchor),
      self.topView.leftAnchor.constraint(equalTo: self.leftAnchor),
      self.topView.rightAnchor.constraint(equalTo: self.rightAnchor),
      self.topView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
    ])

    NSLayoutConstraint.activate([
      self.bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.bottomView.leftAnchor.constraint(equalTo: self.leftAnchor),
      self.bottomView.rightAnchor.constraint(equalTo: self.rightAnchor),
      self.bottomView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
    ])

    self.bringSubviewToFront(self.contentView)
  }

  func configureLayer(size: CGSize, r: CGFloat, intersectionPoint: CGFloat, topIntersectionYPoint: CGFloat) {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: -r + (size.width / 2), y: r))
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: r), radius: r, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
    path.addLine(to: CGPoint(x: (size.width / 2) + intersectionPoint, y: size.height))
    path.addQuadCurve(to: CGPoint(x: (size.width / 2) - intersectionPoint, y: size.height), controlPoint: CGPoint(x: size.width / 2, y: size.height - topIntersectionYPoint))
    path.addLine(to: CGPoint(x: 0, y: size.height))
    path.close()

    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.shadowPath = path.cgPath
    self.contentView.layer.mask = shapeLayer
  }
}
