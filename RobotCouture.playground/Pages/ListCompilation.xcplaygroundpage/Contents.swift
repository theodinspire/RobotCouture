//: [Previous](@previous)

import RobotCouture
import SwiftSoup

let encoder = JSONEncoder()
let dataDirectory = URL(fileURLWithPath: "/Users/corms/git/GitHub/theodinspire/RobotCouture/Data/", isDirectory: true)

let timeFormatter = DateFormatter(fromFormatString: "HH:mm:ss")

year: for year in 2019...2019 {
    month: for month in 8...8 {
        guard let archivePageURL = URL(string: "http://www.thesartorialist.com/archives/page/\(year)\(month.padded(to: 2))/?view=list") else { continue month }

        do {
            let html = try String(contentsOf: archivePageURL, encoding: .ascii)
            let document = try SwiftSoup.parse(html)

            let links = try document.select(".list-archive-post h3 a").array().filter { try $0.text().lowercased().hasPrefix("on the street") }.map { try $0.attr("href") }

            guard !links.isEmpty else { continue month }

            let imageDetails = links.compactMap(URL.init).compactMap(ImageDetails.from).flatMap({ $0 })

            let filePath = URL(fileURLWithPath: "\(year).\(month.padded(to: 2)).json", relativeTo: dataDirectory)

            try encoder.encode(imageDetails).write(to: filePath, options: .atomicWrite)
            print("Saved \(month) \(year)", timeFormatter.string(from: Date()))
        } catch {
            print(error)
        }
    }
}
