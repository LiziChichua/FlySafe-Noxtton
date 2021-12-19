//
//  UIView+Extension.swift
//  FlySafe
//
//  Created by LiziChichua on 19.12.21.
//

import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
