//: [Previous](@previous)

import Foundation

print(FileManager.default.currentDirectoryPath)

for element in FileManager.default.contentsOfDirectory(atPath: FileManager.default.currentDirectoryPath).sorted() {
    print(element)
}

//: [Next](@next)
