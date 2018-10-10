//
//  ImageDetails.swift
//  RobotCouture
//
//  Created by Eric Cormack on 9/28/18.
//  Copyright © 2018 the Odin Spire. All rights reserved.
//

import Foundation

public struct ImageDetails: Codable {
    public let url: URL
    public let postUrl: URL

    public let postTitle: String
    public let postDate: Date?

    public let categories: [String]
    public let tags: [String]

    public init(url: URL, postUrl: URL, postTitle: String, postDate: Date?, categories: [String], tags:[String]) {
        self.url = url
        self.postUrl = postUrl
        self.postTitle = postTitle
        self.postDate = postDate
        self.categories = categories
        self.tags = tags
    }
}
