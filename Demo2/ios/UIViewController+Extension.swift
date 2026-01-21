//
//  UIViewController+Extension.swift
//  Demo2
//
//  Created by Mohd Imran on 20/01/26.
//

import UIKit

extension UIViewController {

  func add(child: UIViewController) {
      addChild(child)
      view.addSubview(child.view)
      child.didMove(toParent: self)
  }

  /// Extension to remove a VC from the Parent VC
  func remove() {
      willMove(toParent: nil)
      view.removeFromSuperview()
      removeFromParent()
  }
}
