//
//  PaintColorPicker.swift
//  Coloretta
//
//  Created by Bohdan Savych on 10/20/19.
//  Copyright © 2019 Padres. All rights reserved.
//

import UIKit

private struct Constants {
  static var lowestInertiaVelocity: CGFloat { 0.3 }
  static var inertiaResistence: CGFloat { 2 }
}

public final class CircularColorPickerView: UIView {
  private var collectionView: UICollectionView!
  private let realRadius: CGFloat
  private let infiniteSize: Int
  private lazy var layout = CircularCollectionViewLayout()
  private lazy var globalOffset: CGFloat = 0
  private lazy var outerColorsIndex = 0
  private lazy var innerColorsIndex = 0
  private lazy var item = DynamicItem()
  private lazy var dynamicAnimator = UIDynamicAnimator(referenceView: self.collectionView)

  private lazy var intersection = CircularCollectionViewLayout.calculateIntersectionPoint(
    itemSize: CircularCollectionViewLayout.itemSize,
    items: CircularCollectionViewLayout.normalizeRows(self.infiniteSize))

  private lazy var itemCutIntersection = CircularCollectionViewLayout.calculateItemCutIntersection(
    itemSize: CircularCollectionViewLayout.itemSize,
    cutRadius: self.itemCutRadius,
    normalizedElementsCount: CircularCollectionViewLayout.normalizeRows(self.infiniteSize))

  private lazy var topIntersectionYPoint = CircularCollectionViewLayout.calculateTopIntersectionYPoint(
    itemSize: CircularCollectionViewLayout.itemSize,
    items: CircularCollectionViewLayout.normalizeRows(self.infiniteSize))

  private lazy var itemCutRadius = CircularCollectionViewLayout.calculateItemCutRadius(
    itemSize: CircularCollectionViewLayout.itemSize,
    anglePerItem: CGFloat.pi * 2 / CGFloat(CircularCollectionViewLayout.normalizeRows(self.infiniteSize)))

  private lazy var inneRadius = CircularCollectionViewLayout.calculateInnerRadius(
    itemSize: CircularCollectionViewLayout.itemSize,
    anglePerItem: CGFloat.pi * 2 / CGFloat(CircularCollectionViewLayout.normalizeRows(self.infiniteSize)))

  private lazy var innerBottomRadius = CircularCollectionViewLayout.calculateInnerBottomRadius(
    itemSize: CircularCollectionViewLayout.itemSize,
    items: CircularCollectionViewLayout.normalizeRows(self.infiniteSize))

  private lazy var currentColorView = CurrentColorView()
  private lazy var touchHandlerView = TouchHandlerView()
  private var previousPoint: CGPoint?
  private var currentPoint: CGPoint?
  private let minPickerStep: CGFloat = 0
  private let maxPickerStep: CGFloat = 12
  private let xMultiplier: CGFloat = 1.4
  private var keyValueObserver: NSKeyValueObservation?
  private lazy var isInerting = false
  private var prevOffset: CGPoint?
  private let colors:  [[PaintColor]]
  private var tapNormalizationTimer: Timer?

  // MARK: - Public
  public var didChangeColor: ((PaintColor) -> Void)?
  public var currentColor: PaintColor? {
    currentColorView.currentColor
  }

  public init(frame: CGRect, colors: [[PaintColor]] = Colors.default) {
    self.infiniteSize = Int(1_000_000 / colors.count) * colors.count
    self.colors = colors
    self.realRadius = CircularCollectionViewLayout.calculateRealRadius(itemSize: CircularCollectionViewLayout.itemSize, items: CircularCollectionViewLayout.normalizeRows(self.infiniteSize))

    super.init(frame: frame)

    self.configureCollectionView(size: frame.size)
    self.configureTouchHandler()
    self.attachViews()
    self.configureContentOffsetObserver()
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func toMiddle() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
      guard let self = self else { return }
      
      self.collectionView?.setContentOffset(CGPoint(x: self.collectionView.contentSize.width / 2, y: 0), animated: false)
      DispatchQueue.main.async {
        self.adjustOffset(targetContentOffset: nil)
        UIView.animate(withDuration: 0.2) {
          self.collectionView?.alpha = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          guard let cell = self.collectionView.visibleCells.first as? ColorsCollectionViewCell else { return }
          cell.colorCollectionView.setContentOffset(CGPoint(x: 0, y: cell.colorCollectionView.contentSize.height / 2), animated: true)
        }

        self.colorWasChanged()
      }
    }
  }

  func update(color: UIColor) {
    let newColor = PaintColor(uicolor: color)
    let flattenColors = colors.flatMap { $0 }
    var minDiffColor = flattenColors.first!
    var minDiff = CGFloat(Int.max)

    for color in flattenColors {
      let diff = newColor.diff(from: color)

      if diff < minDiff {
        minDiffColor = color
        minDiff = diff
      }
    }
    let index = colors.firstIndex(where: { $0.contains(minDiffColor) })
    let groupIndex = Int(index ?? 0)
    let leftDiff = groupIndex - self.layout.headIndex
    let sign = self.layout.headIndex > groupIndex ? 1 : -1
    var rightDiff = colors.count - (self.layout.headIndex > groupIndex ? self.layout.headIndex - groupIndex : groupIndex - self.layout.headIndex)
    rightDiff *= sign
    let diff = abs(leftDiff) < abs(rightDiff) ? leftDiff : rightDiff
    let offsetChanges = (CGFloat(diff) * (CircularCollectionViewLayout.itemSize.width + CircularCollectionViewLayout.minimumItemSpacing))
    guard let elementIndex = colors[groupIndex].firstIndex(of: minDiffColor) else { return }
    let newOffset = CGPoint(x: self.collectionView.contentOffset.x + offsetChanges, y: self.collectionView.contentOffset.y)
    collectionView.setContentOffset(newOffset, animated: true)
    let colorCellHeight = (collectionView.visibleCells.first?.bounds.height ?? 0) / 2
    let newContentOffset = CGPoint(x: 0, y: (colorCellHeight * CGFloat(elementIndex)) - colorCellHeight / 2)
    guard let cell = self.collectionView.visibleCells.first as? ColorsCollectionViewCell else { return }
    cell.colorCollectionView.setContentOffset(newContentOffset, animated: true)
    self.globalOffset = newContentOffset.y
  }
}

// MARK: - UICollectionViewDelegate
extension CircularColorPickerView: UICollectionViewDelegate {
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let index = layout.headIndex

    if index != self.outerColorsIndex {
      self.outerColorsIndex = index
      colorWasChanged()
    }

    self.outerColorsIndex = index
  }

  public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    adjustOffset(targetContentOffset: targetContentOffset)
  }

  private func adjustOffset(targetContentOffset: UnsafeMutablePointer<CGPoint>?) {
    targetContentOffset?.pointee = collectionView.contentOffset
    let visibleCells = collectionView.visibleCells.compactMap { $0 as? ColorsCollectionViewCell }

    guard var closestToCenterCell = visibleCells.first else { return }

    var closestToCenterOffset = abs(closestToCenterCell.frame.midX - self.collectionView.contentOffset.x - (self.collectionView.bounds.width / 2))

    for cell in visibleCells {
      let offset = abs(cell.frame.midX - self.collectionView.contentOffset.x - (self.collectionView.bounds.width / 2))
      if offset < closestToCenterOffset {
        closestToCenterCell = cell
        closestToCenterOffset = offset
      }

    }

    visibleCells.first?.page()
    let offsetWithSign = closestToCenterCell.frame.midX - self.collectionView.contentOffset.x - (self.collectionView.bounds.width / 2)

    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      let newOffset = self.collectionView.contentOffset.x + offsetWithSign
      self.collectionView.setContentOffset(CGPoint(x: newOffset, y: 0), animated: true)
    }
  }

}

// MARK: - UICollectionViewDataSource
extension CircularColorPickerView: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.infiniteSize
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: String(describing: ColorsCollectionViewCell.self),
      for: indexPath) as! ColorsCollectionViewCell
    let index = indexPath.row % self.colors.count
    let colors = self.colors[index]
    cell.configure(colors: colors, title: "\(indexPath.row)", realRadius: self.realRadius, innerRadius: inneRadius, innerBottomRadius: innerBottomRadius, size: CircularCollectionViewLayout.itemSize, intersectionPoint: self.intersection, offset: self.globalOffset, itemCutIntersection: self.itemCutIntersection, topIntersectionYPoint: topIntersectionYPoint)
    cell.didSelectColor = { [weak self] color in
      self?.update(color: color.uicolor)
    }
    cell.didScroll = { [weak self] offset, index in
      self?.globalOffset = offset

      if index != self?.innerColorsIndex {
        self?.innerColorsIndex = index
        self?.colorWasChanged()
      }

      self?.innerColorsIndex = index

      collectionView.visibleCells.compactMap { $0 as? ColorsCollectionViewCell}.forEach { cell in
        cell.colorCollectionView.contentOffset = CGPoint(x: 0, y: offset)
      }
    }

    return cell
  }
}

// MARK: - Private
private extension CircularColorPickerView {
  func attachViews() {
    self.currentColorView.isUserInteractionEnabled = false
    self.currentColorView.translatesAutoresizingMaskIntoConstraints = false
    self.touchHandlerView.translatesAutoresizingMaskIntoConstraints = false
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false

    self.addSubview(self.collectionView)
    self.addSubview(self.currentColorView)
    self.addSubview(self.touchHandlerView)

    NSLayoutConstraint.activate([
      self.currentColorView.widthAnchor.constraint(equalToConstant: CircularCollectionViewLayout.itemSize.width / 2),
      self.currentColorView.heightAnchor.constraint(equalToConstant: CircularCollectionViewLayout.itemSize.height / 2),
      self.currentColorView.topAnchor.constraint(
        equalTo: self.topAnchor,
        constant: CircularCollectionViewLayout.itemSize.height / 4),
      self.currentColorView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ])

    NSLayoutConstraint.activate([
      self.touchHandlerView.leftAnchor.constraint(equalTo: self.leftAnchor),
      self.touchHandlerView.rightAnchor.constraint(equalTo: self.rightAnchor),
      self.touchHandlerView.topAnchor.constraint(equalTo: self.topAnchor),
      self.touchHandlerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])

    NSLayoutConstraint.activate([
      self.collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
      self.collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
      self.collectionView.topAnchor.constraint(equalTo: self.topAnchor),
      self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }

  func configureCollectionView(size: CGSize) {
    self.collectionView = UICollectionView(frame: CGRect(origin: .zero, size: size), collectionViewLayout: self.layout)
    self.collectionView?.delegate = self
    self.collectionView?.dataSource = self
    self.collectionView?.alpha = 0
    self.collectionView?.backgroundColor = .clear
    self.collectionView.clipsToBounds = false
    self.collectionView.decelerationRate = .fast
    self.collectionView?.register(ColorsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ColorsCollectionViewCell.self))
  }

  func configureContentOffsetObserver() {
    self.keyValueObserver = self.collectionView.observe(
      \UICollectionView.contentOffset,
      options: .new
    ) { [weak self] collection, change in
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }

        guard let oldValue = self.prevOffset,
              let newValue = change.newValue else {
          self.prevOffset = change.newValue

          return
        }

        if self.isInerting &&
            abs(oldValue.x - newValue.x) < Constants.lowestInertiaVelocity {
          self.dynamicAnimator.removeAllBehaviors()
          self.adjustOffset(targetContentOffset: nil)

          self.isInerting = false
          self.prevOffset = nil
        }

        self.prevOffset = newValue
      }
    }

  }

  func configureTouchHandler() {
    self.collectionView.isUserInteractionEnabled = false
    self.touchHandlerView.touchBeganEvent = { [unowned self] point, velocity in
      self.previousPoint = point
      self.isInerting = false
      self.dynamicAnimator.removeAllBehaviors()
    }

    self.touchHandlerView.touchMovedEvent = { [unowned self] point, velocity in
      self.currentPoint = point
      self.move(prevPoint: self.previousPoint ?? .zero, curPoint: point)
      self.previousPoint = self.currentPoint
    }

    self.touchHandlerView.touchesEnded = { [unowned self] point, velocity in
      let removeVerticalVelocity = CGPoint(x: -velocity.x, y: 0)
      self.isInerting = true
      self.item.center = self.collectionView.contentOffset

      let decelerationBehavior = UIDynamicItemBehavior(items: [self.item])
      decelerationBehavior.resistance = Constants.inertiaResistence
      decelerationBehavior.addLinearVelocity(removeVerticalVelocity, for: self.item)
      decelerationBehavior.action = {
        self.collectionView.contentOffset = self.item.center
      }
      self.dynamicAnimator.addBehavior(decelerationBehavior)

    }

    self.touchHandlerView.touchesCancelled = { [unowned self] point, velocity in
      self.adjustOffset(targetContentOffset: nil)
    }

    self.touchHandlerView.onTap = { [weak self, weak touchHandlerView] point in
      guard
        let self = self else { return }

      let convertedPoint = self.collectionView.convert(point, from: self.touchHandlerView)
      var indexPath: IndexPath?
      for visibleCell in self.collectionView.visibleCells {
        if visibleCell.frame.contains(convertedPoint) {
          indexPath = self.collectionView.indexPath(for: visibleCell)
          break
        }
      }

      guard
        let unwrappedIndexPath = indexPath
      else { return }

      let index = unwrappedIndexPath.row % self.colors.count
      let color = self.colors[index][self.innerColorsIndex]

      self.update(color: color.uicolor)

      if self.tapNormalizationTimer != nil {
        self.tapNormalizationTimer?.invalidate()
        self.tapNormalizationTimer = nil
      }

      self.tapNormalizationTimer = Timer.scheduledTimer(
        withTimeInterval: 0.5,
        repeats: false
      ) { timer in
        touchHandlerView?.touchesEnded?(point, .init(x: 1, y: 1))
      }
    }
  }

  func move(prevPoint: CGPoint, curPoint: CGPoint) {
    let xDiff = curPoint.x - prevPoint.x
    let yDiff = curPoint.y - prevPoint.y
    let xSign =  xDiff == 0 ? 1 : (xDiff / abs(xDiff))
    let ySign = yDiff == 0 ? 1 : (yDiff / abs(yDiff))

    let x = max(min(abs(xDiff), self.maxPickerStep), self.minPickerStep) * -xSign * self.xMultiplier
    let y = max(min(abs(yDiff), self.maxPickerStep), self.minPickerStep) * -ySign
    let offset = CGPoint(x: self.collectionView.contentOffset.x + x, y: self.collectionView.contentOffset.y)
    let cell = (self.collectionView.visibleCells.first as? ColorsCollectionViewCell)
    let innerOffset = cell?.colorCollectionView.contentOffset ?? .zero
    let inset = (cell?.colorCollectionView.contentInset.top ?? 0) * 2
    let innerYContentOffset = min(max(innerOffset.y + y, -inset), (cell?.colorCollectionView.contentSize.height ?? 0) - inset)

    cell?.colorCollectionView.contentOffset = CGPoint(x: innerOffset.x, y: innerYContentOffset)
    self.collectionView.contentOffset = offset
  }

  func colorWasChanged() {
    let index = self.layout.headIndex % self.colors.count
    let color = self.colors[index][self.innerColorsIndex]
    self.currentColorView.update(color: color)
    self.didChangeColor?(color)
  }
}
