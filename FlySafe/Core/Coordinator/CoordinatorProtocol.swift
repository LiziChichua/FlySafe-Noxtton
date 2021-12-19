//
//  CoordinatorProtocol.swift
//  FlySafe
//
//  Created by LiziChichua on 19.12.21.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    init(_ window: UIWindow?, navigationController: UINavigationController?)
    
    func start()
}
