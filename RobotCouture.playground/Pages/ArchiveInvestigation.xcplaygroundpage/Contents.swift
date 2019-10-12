//: [Previous](@previous)

import RobotCouture
import SwiftSoup

guard let url = URL(string: "http://www.thesartorialist.com/archives/page/201005/?view=list")
    else { abort() }

do {
    let html = try String(contentsOf: url, encoding: .ascii)
    let document = try SwiftSoup.parse(html)

    print(try document.title())

    let titleLinks = try document.select(".list-archive-post h3 a")

    print(try titleLinks.first()?.text())
    print(try titleLinks.first()?.attr("href") ?? "No link")
    print(try titleLinks.array().count)
} catch {
    print("There was an error")
}

var linkCounts = 0

years: for year in 2005...2005 {
    months: for month in 10...12 {
        guard let url = URL(string: "http://www.thesartorialist.com/archives/page/\(year)\(month.padded(to: 2))/?view=list") else { continue months }
        do {
            let html = try String(contentsOf: url, encoding: .ascii)
            let document = try SwiftSoup.parse(html)

            let titleLinks = try document.select(".list-archive-post h3 a").array().filter { try $0.text().lowercased().hasPrefix("on the street") }.map { try $0.attr("href") }

            linkCounts += titleLinks.count
            print(titleLinks.first ?? "None")
        } catch {
            print(error)
        }
    }
}

print(linkCounts)

//: [Next](@next)
