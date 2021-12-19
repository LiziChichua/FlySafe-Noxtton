//
//  UITableViewCell+Extension.swift
//  FlySafe
//
//  Created by LiziChichua on 19.12.21.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle.main)
    }
}
