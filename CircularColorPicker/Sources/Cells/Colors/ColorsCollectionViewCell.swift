//
//  ColorCollectionViewCell.swift
//  CATransfrom3d
//
//  Created by Bohdan Savych on 10/15/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import UIKit

final class ColorsCollectionViewCell: UICollectionViewCell {
  private(set) lazy var colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  private lazy var layerConfigured = false
  private lazy var colors = [PaintColor]()
  private lazy var realRadius: CGFloat = 0
  private lazy var intersectionPoint: CGFloat = 0
  private lazy var topIntersectionYPoint: CGFloat = 0

  var didScroll: ((CGFloat, Int) -> Void)?
  var didSelectColor: ((PaintColor) -> Void)?

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.setup()
  }

  required init?(coder: NSCoder) { nil }

  func configure(
    colors: [PaintColor],
    title: String,
    realRadius: CGFloat,
    innerRadius: CGFloat,
    innerBottomRadius: CGFloat,
    size: CGSize,
    intersectionPoint: CGFloat,
    offset: CGFloat,
    itemCutIntersection: CGFloat,
    topIntersectionYPoint: CGFloat) {
    self.realRadius = realRadius
    self.intersectionPoint = intersectionPoint
    self.topIntersectionYPoint = topIntersectionYPoint

    self.colors = colors
    if !self.layerConfigured {
      self.layerConfigured = true

      self.configureLayer(size: size, innerRadius: innerRadius, innerBottomRadius: innerBottomRadius, intersectionPoint: intersectionPoint, itemCutIntersection: itemCutIntersection, topIntersectionYPoint: topIntersectionYPoint)
    }

    self.colorCollectionView.contentOffset = CGPoint(x: 0, y: offset)
  }

  override func prepareForReuse() {
    self.colors = []
    self.colorCollectionView.reloadData()
  }

  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)

    let circularLayoutAttributes = layoutAttributes as! CircularCollectionViewLayoutAttributes
    self.layer.anchorPoint = circularLayoutAttributes.anchorPoint
    self.center.y += (circularLayoutAttributes.anchorPoint.y - 0.5) * self.bounds.height
  }

  func page() {
    let itemHeight = self.colorCollectionView.bounds.height / 2
    let currentYOffset = self.colorCollectionView.contentOffset.y
    let currentIndex = Int((currentYOffset + itemHeight) / itemHeight)
    let normalizedCurrentIndex = max(min(currentIndex, self.colors.count - 1), 0)
    let offset = (CGFloat(normalizedCurrentIndex - 1) * itemHeight) + itemHeight / 2

    DispatchQueue.main.async { [weak self] in
      self?.colorCollectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
    }
  }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ColorsCollectionViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    targetContentOffset.pointee = scrollView.contentOffset
    self.page()
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.didSelectColor?(self.colors[indexPath.row])
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let itemHeight = scrollView.bounds.height / 2

    guard itemHeight > 0 else { return }

    let currentYOffset = scrollView.contentOffset.y
    let currentIndex = Int((currentYOffset + itemHeight) / itemHeight)
    let normalizedCurrentIndex = max(min(currentIndex, self.colors.count - 1), 0)
    self.didScroll?(scrollView.contentOffset.y, normalizedCurrentIndex)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 2)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .zero
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

// MARK: - UICollectionViewDataSource
extension ColorsCollectionViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    self.colors.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: String(describing: ColorCollectionViewCell.self),
      for: indexPath) as! ColorCollectionViewCell
    let index = indexPath.row
    let itemSize = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 2)
    cell.configure(
      color: self.colors[index].uicolor,
      prevColor: index == 0 ? .clear : self.colors[index - 1].uicolor,
      itemSize: itemSize,
      r: self.realRadius,
      intersectionPoint: intersectionPoint,
      topIntersectionYPoint: topIntersectionYPoint,
      isLast: index == self.colors.count - 1)

    return cell
  }
}

// MARK: - Private
private extension ColorsCollectionViewCell {
  func setup() {
    self.backgroundColor = .clear
    self.contentView.backgroundColor = .clear
    self.colorCollectionView.backgroundColor = .clear
    self.contentView.layer.shouldRasterize = true
    self.contentView.layer.rasterizationScale = UIScreen.main.scale
    self.contentView.clipsToBounds = true
    self.colorCollectionView.delegate = self
    self.colorCollectionView.dataSource = self
    self.colorCollectionView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(self.colorCollectionView)
    self.colorCollectionView.showsVerticalScrollIndicator = false
    self.colorCollectionView.showsHorizontalScrollIndicator = false
    
    NSLayoutConstraint.activate([
      self.colorCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
      self.colorCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
      self.colorCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
      self.colorCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])

    self.colorCollectionView.register(
      ColorCollectionViewCell.self,
      forCellWithReuseIdentifier: String(describing: ColorCollectionViewCell.self))
  }

  func configureLayer(
    size: CGSize,
    innerRadius: CGFloat,
    innerBottomRadius: CGFloat,
    intersectionPoint: CGFloat,
    itemCutIntersection: CGFloat,
    topIntersectionYPoint: CGFloat) {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: -innerRadius + (size.width / 2), y: innerRadius))
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: innerRadius), radius: innerRadius, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
    path.addLine(to: CGPoint(x: size.width, y: topIntersectionYPoint))
    path.addLine(to: CGPoint(x: (size.width / 2) + intersectionPoint, y: size.height))
    path.addQuadCurve(to: CGPoint(x: (size.width / 2) - intersectionPoint, y: size.height), controlPoint: CGPoint(x: size.width / 2, y: size.height - topIntersectionYPoint))
    path.addLine(to: CGPoint(x: 0, y: topIntersectionYPoint))
    path.close()
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.shadowPath = path.cgPath
    self.layer.mask = shapeLayer
    self.colorCollectionView.contentInset = UIEdgeInsets(top: size.height / 4, left: 0, bottom: size.height / 4, right: 0)
  }
}
