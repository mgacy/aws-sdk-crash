// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CrashExample",
    platforms: [.macOS(.v12)],
    products: [
        .executable(name: "CrashExample", targets: ["CrashExample"])
    ],
    dependencies: [
        .package(url: "https://github.com/awslabs/aws-sdk-swift", from: "0.19.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "0.6.0"),
        .package(url: "https://github.com/swift-server/swift-aws-lambda-events", branch: "main"),
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime", branch: "main")
    ],
    targets: [
        .executableTarget(
            name: "CrashExample",
            dependencies: [
                .product(name: "AWSDynamoDB", package: "aws-sdk-swift"),
                .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-events"),
                .product(name: "AWSLambdaRuntime",package: "swift-aws-lambda-runtime"),
                .product(name: "AWSSES", package: "aws-sdk-swift")
            ]
        )
    ]
)
