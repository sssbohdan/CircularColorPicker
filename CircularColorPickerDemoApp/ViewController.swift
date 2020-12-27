//
//  ViewController.swift
//  CircularColorPickerDemoApp
//
//  Created by Bohdan Savych on 08/12/2020.
//

import UIKit
import CircularColorPicker

class ViewController: UIViewController {
  private enum Constrants {
    static let colorPickerSize = CGSize(width: 400, height: 800)
    static let colorPickerTopOffset: CGFloat = 150
  }

  lazy var colorPicker = CircularColorPickerView(frame: CGRect(origin: .zero, size: Constrants.colorPickerSize))

  override func viewDidLoad() {
    super.viewDidLoad()

    self.colorPicker.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(self.colorPicker)

    // colorPicker
    NSLayoutConstraint.activate([
      self.colorPicker.widthAnchor.constraint(equalToConstant: Constrants.colorPickerSize.width),
      self.colorPicker.heightAnchor.constraint(equalToConstant: Constrants.colorPickerSize.height),
      self.colorPicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.colorPicker.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Constrants.colorPickerTopOffset)
    ])

    self.colorPicker.didChangeColor = { [weak self] color in
      self?.view.backgroundColor = color.uicolor
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    self.colorPicker.toMiddle()
  }
}

