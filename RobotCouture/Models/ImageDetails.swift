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

import SwiftSoup

public extension ImageDetails {
    static func from(url: URL) -> [ImageDetails]? {

        do {
            let document = try SwiftSoup.parse(try String(contentsOf: url, encoding: .ascii))
            let title = try document.title()

            guard let post = try document.getElementsByClass("post").first() else {
                print("Could not find post at \(url.absoluteString). Ending parse.")
                return nil
            }

            guard let dateString = try post.getElementsByClass("date-post").first()?.text(),
                let date = DateFormatter.default.date(from: dateString) else {
                    print("Could not porse post date. Ending parse.")
                    return nil
            }

            let classes = try post.classNames()
            let splitter: (String) -> String = { $0.split(separator: "-").suffix(from: 1).joined(separator: " ") }

            let categories = classes.filter { $0.hasPrefix("category") }.map(splitter)
            let tags = classes.filter { $0.hasPrefix("tag") }.map(splitter)

            let imageSources = try post.getElementsByClass("article-content").first()?.getElementsByTag("img").map { try $0.attr("src") } ?? []

            return imageSources.compactMap(URL.init).map {
                ImageDetails(url: $0, postUrl: url, postTitle: title, postDate: date, categories: categories, tags: tags)
            }
        } catch {
            print(error)
        }

        return nil
    }
}
