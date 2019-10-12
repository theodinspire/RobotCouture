//
//  Int+Padding.swift
//  RobotCouture
//
//  Created by Eric Cormack on 10/15/18.
//  Copyright © 2018 the Odin Spire. All rights reserved.
//

import Foundation

public extension Int {
    func padded(to places: Int) -> String {
        return String(format: "%0\(places)d", self)
    }
}
