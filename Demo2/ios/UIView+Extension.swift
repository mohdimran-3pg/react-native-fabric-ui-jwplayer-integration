//
//  UIView+Extension.swift
//  Demo2
//
//  Created by Mohd Imran on 20/01/26.
//

import UIKit

extension UIView {
  var parentViewController: UIViewController? {
      var parentResponder: UIResponder? = self
      while parentResponder != nil {
          parentResponder = parentResponder!.next
          if let viewController = parentResponder as? UIViewController {
              return viewController
          }
      }
      return nil
  }
}
