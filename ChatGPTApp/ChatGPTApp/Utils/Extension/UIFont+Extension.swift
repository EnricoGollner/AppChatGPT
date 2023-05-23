//
//  UIFont+Extension.swift
//  CHATGPT
//
//  Created by Caio Fabrini on 25/02/23.
//

import Foundation
import UIKit

extension UIFont {
    static func helveticaNeueMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
