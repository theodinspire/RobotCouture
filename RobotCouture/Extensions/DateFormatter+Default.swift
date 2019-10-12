//
//  DateFormatter+Default.swift
//  RobotCouture
//
//  Created by Eric Cormack on 10/15/18.
//  Copyright © 2018 the Odin Spire. All rights reserved.
//

import Foundation

public extension DateFormatter {
    static let `default` = DateFormatter(fromFormatString: "EEEE, MMMM d, yyyy")

    convenience init(fromFormatString string: String) {
        self.init()
        self.dateFormat = string
    }
}
