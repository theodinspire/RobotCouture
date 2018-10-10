//: [Previous](@previous)

import Foundation
import RobotCouture
import SwiftSoup

guard let url = URL(string: "http://www.thesartorialist.com/photos/on-the-street-eva-milan-9/") else { abort() }

do {
    let html = try String(contentsOf: url, encoding: .ascii)
    let doc = try SwiftSoup.parse(html)
    print(try doc.title())

    guard let post = try doc.getElementsByClass("post").first() else {
        abort()
    }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"

    //    print(try post.getElementsByClass("date-post").first()?.text())

    let dateString = try post.getElementsByClass("date-post").first()?.text() ?? ""

    let date = dateFormatter.date(from: dateString)

    print(date ?? "No date found")

    let classes = try post.classNames()

    let splitter: (String) -> String = { $0.split(separator: "-").suffix(from: 1).joined(separator: " ") }

    //    "category-men".split(separator: "-").suffix(from: 1).joined(separator: " ")
    let categories = classes.filter { $0.hasPrefix("category") }.map(splitter)
    let tags = classes.filter { $0.hasPrefix("tag") }.map(splitter)

    print(categories)
    print(tags)

    let content = try post.getElementsByClass("article-content").first()
    let imageElements = try content?.getElementsByTag("img")
    let imageSources = try imageElements?.map { try $0.attr("src") } ?? []

    print(imageSources)

    let imageUrls = imageSources.compactMap(URL.init)
    let _ = try imageUrls.map { ImageDetails(url: $0, postUrl: url, postTitle: try doc.title(), postDate: date, categories: categories, tags: tags) }

} catch Exception.Error(let type, let message) {
    print(type)
    print(message)
} catch {
    print("error")
}

//: [Next](@next)

