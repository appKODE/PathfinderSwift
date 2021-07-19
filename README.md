# Pathfinder

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Pathfinder is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Pathfinder-KODE'
```

## Import Pathfinder to your project
```swift
import Pathfinder
```

## Configure Pathfinder
```swift
let devEnv = PathfinderEnvironment(id: UUID(), name: "DEV", baseUrl: "dev.ru", queryParams: ["__code", "__example"])
let intEnv = PathfinderEnvironment(id: UUID(), name: "INT", baseUrl: "int.ru", queryParams: ["__code"])
let relEnv = PathfinderEnvironment(id: UUID(), name: "REL", baseUrl: "rel.ru", queryParams: [])

Pathfinder.shared.configure(
    specs: [
        .init(id: "auth", pathTemplate: "/auth/login", httpMethod: .get, tag: "auth", name: "Authentication", currentStoplightQueryParams: [:]),
        .init(id: "register", pathTemplate: "/auth/{sessionId}", httpMethod: .post, tag: "auth", name: "Registration", currentStoplightQueryParams: [:]),
        .init(id: "upload", pathTemplate: "/files/upload", httpMethod: .post, tag: "files", name: "Uploading", currentStoplightQueryParams: [:])
    ], 
    environments: [devEnv, intEnv, relEnv], 
    config: .init(env: devEnv)
)
```

## Usage
```swift
if let url = try? Pathfinder.shared.buildUrl(id: "auth", pathParameters: [:], queryParameters: [:]) {
    // Make URLRequest...
} else {
    // Error Handling...
}
```

## Author

Medvedev Semyon, 61358874+Simon-developer@users.noreply.github.com

## License

Pathfinder is available under the MIT license. See the LICENSE file for more info.
