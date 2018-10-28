// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name:"MKBlockQueue",
    products:[
        .library(name:"MKBlockQueue", targets:["MKBlockQueue"])
    ],
    targets:[
        .target(name:"MKBlockQueue", dependencies:[])
    ],
    swiftLanguageVersions:[4]
)

