//
//  ViewController.swift
//  Scatter and Gather
//
//  Created by Thomas Dye on 2020-04-10.
//  Copyright © 2019 Thomas Dye. All rights reserved.
//

import UIKit

extension CGColor {
    static func random() -> CGColor {
        return CGColor(
            srgbRed: CGFloat.random(in: 0...1.0),
            green: CGFloat.random(in: 0...1.0),
            blue: CGFloat.random(in: 0...1.0),
            alpha: 1.0
        )
    }
}
