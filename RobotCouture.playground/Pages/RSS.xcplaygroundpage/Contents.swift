import Foundation
import RobotCouture
import FeedKit

//: Build a url of for the feed
guard let url = URL(string: "http://feeds.feedburner.com/TheSartorialist") else { abort() }

//: Parse the feed and pull the first Eva post
let parsed = FeedParser(URL: url).parse()
guard let feed = parsed.rssFeed, let items = feed.items, let eva = items.first(where: { $0.title?.contains("Eva") ?? false }) else { abort() }

//: The title
print(eva.title ?? "Nothing to see here")
//: The post url (maybe this will need to be converted into a permalink)
print(eva.link ?? "No link")
//: The publication date
print(eva.pubDate ?? "Never published")
//: The categories
print(eva.categories?.compactMap { $0.value } ?? "No categories")

/*:

 If we look on the site, we see that there is only a tag for this post,
 "eva fontanelli" and no catagories. But here, the tag is counted as a
 category and "Photos" is included. We might need another way to crawl
 the site.

 */
