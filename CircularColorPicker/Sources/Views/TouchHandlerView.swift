//
//  TouchHandlerView.swift
//  Coloretta
//
//  Created by Bohdan Savych on 2/22/20.
//  Copyright © 2020 Padres. All rights reserved.
//

import UIKit

final class TouchHandlerView: UIView {
  var touchBeganEvent: ((_ point: CGPoint, _ velocity: CGPoint) -> Void)?
  var touchMovedEvent: ((_ point: CGPoint, _ velocity: CGPoint) -> Void)?
  var touchesEnded: ((_ point: CGPoint, _ velocity: CGPoint) -> Void)?
  var touchesCancelled: ((_ point: CGPoint, _ velocity: CGPoint) -> Void)?
  var onTap: ((CGPoint) -> Void)?

  lazy var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.onPan(sender:)))
  lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onTap(sender:)))

  init() {
    super.init(frame: .zero)

    self.configure()
  }

  required init?(coder: NSCoder) { nil }

  func configure() {
    self.addGestureRecognizer(self.panGestureRecognizer)
    self.addGestureRecognizer(self.tapGestureRecognizer)
    self.isUserInteractionEnabled = true
  }

  @objc func onPan(sender: UIPanGestureRecognizer) {
    let state = sender.state
    let point = sender.location(in: self)
    let velocity = sender.velocity(in: self)

    switch state {
    case .began:
      self.touchBeganEvent?(point, velocity)
    case .changed:
      self.touchMovedEvent?(point, velocity)
    case .ended:
      self.touchesEnded?(point, velocity)
    default:
      self.touchesCancelled?(point, velocity)
    }
  }

  @objc func onTap(sender: UITapGestureRecognizer) {
    let point = sender.location(in: self)
    self.onTap?(point)
  }
}
