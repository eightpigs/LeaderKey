import PackageDescription

let package = Package(
    name: "Library",
    dependencies: [
        .Package(url: "https://github.com/soffes/HotKey", majorVersion:0, minor:1 )
    ]
)
