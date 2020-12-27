//
//  CurrentColorView.swift
//  Coloretta
//
//  Created by Bohdan Savych on 10/21/19.
//  Copyright © 2019 Padres. All rights reserved.
//

import UIKit

final class CurrentColorView: UIView {
  private lazy var contentView = UIView()
  private(set) var currentColor: PaintColor?

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.configure()
  }

  required init?(coder: NSCoder) { nil }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.contentView.layer.cornerRadius = self.frame.width / 2
  }

  func configure() {
    self.backgroundColor = .clear
    self.attachContentView()
  }

  func update(color: PaintColor) {
    guard color != self.currentColor else { return }

    self.contentView.backgroundColor = color.uicolor
  }

  func attachContentView() {
    self.contentView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(self.contentView)

    self.contentView.layer.borderWidth = 2
    self.contentView.layer.borderColor = UIColor.white.cgColor
    self.contentView.clipsToBounds = true
    self.contentView.backgroundColor = .clear

    NSLayoutConstraint.activate([
      self.contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      self.contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
      self.contentView.heightAnchor.constraint(equalTo: self.heightAnchor)
    ])
  }
}
