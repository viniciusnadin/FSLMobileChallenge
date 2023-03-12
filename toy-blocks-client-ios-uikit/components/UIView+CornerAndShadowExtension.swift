//
//  UIView+CornerAndShadowExtension.swift
//  toy-blocks-client-ios-uikit
//
//  Created by Vinicius Nadin on 12/03/23.
//

import UIKit

extension UIView {
    func applyShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 8
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = UIColor(red: 0.329, green: 0.431, blue: 0.478, alpha: 0.24).cgColor
    }
}
