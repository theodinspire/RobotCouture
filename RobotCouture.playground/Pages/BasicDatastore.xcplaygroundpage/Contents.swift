//: [Previous](@previous)

import RobotCouture

guard let sourceUrl = URL(string: "http://www.thesartorialist.com/photos/on-the-street-eva-milan-9/") else { abort() }

let encoder = JSONEncoder()

let fileUrl = URL(fileURLWithPath: "/Users/corms/git/GitHub/theodinspire/RobotCouture/Data/test.json")

guard let details = ImageDetails.from(url: sourceUrl) else {
    print("Could not parse page")
    abort()
}
let json = encoder.encode(details)

do {
    try json.write(to: fileUrl)
} catch {
    print(error)
    print("Failure writing file")
}

//: [Next](@next)
