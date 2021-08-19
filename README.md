# Pathfinder

### Pathfinder - lightweight library that allows you to easily resolve URL's, depending on whatever environment, path parameters, query paramteres are currently chosen. Our library also provides you the abilities of toggling between you Dev or Production servers or mocking responses conveniently through the UI.


## Pathfinder for other platforms
Android link, Web link

## Example
- Clone the Repo

- Go to the `Example` folder

- Run `pod install`

- Open `Pathfinder-Swift.xcworkspace` file

## Requirements
**Swift 4.0 +**

**iOS 9.0 +**

## Usage examples
<img src="https://git.appkode.ru/dev-department/pathfinder-ios/-/raw/master/Simulator_Screen_Shot_-_iPhone_12_Pro_Max_-_2021-07-19_at_16.53.04.png" width="200" height="450">
<img src="https://git.appkode.ru/dev-department/pathfinder-ios/-/raw/master/Simulator_Screen_Shot_-_iPhone_12_Pro_Max_-_2021-07-19_at_16.53.10.png" width="200" height="450">

## Installation

Pathfinder is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Pathfinder-Swift'
```

## Import Pathfinder to your project
```swift
import Pathfinder_Swift
```

## Configure Pathfinder
Pathfinder configuration requires you to make only 3 following steps: 
#### First step
Firstly. to configure Pathfinder, you need to list all URL's you are going to use and possible parameters in the appropriate format - `UrlSpec`:
```swift
let urlSpec1 = UrlSpec(
    id: "auth",
    pathTemplate: "/auth/login",
    httpMethod: .get,
    tag: "auth",
    name: "Authentication",
    currentStoplightQueryParams: [:]
)
```
#### Second step
Describe all environments (servers) you are going to use in your project in appropriate format - `PFEnvironment`:
```swift
let devEnv = PFEnvironment(
    id: UUID(),
    name: "DEV",
    baseUrl: "dev.ru",
    queryParams: ["__code", "__example"]
)
```

#### Third step
The last but not least is to configure shared instance of Pathfinder, simply by calling `configure()` and passing in everything we've just defined.
```swift
Pathfinder.shared.configure(
    config: .init(
        specs: urlSpecs,
        environments: environments,
        initialEnvironmentIndex: 0
    )
)
```

## Usage
#### Building URLs
To build URL string you need to call `buildUrl()` method, passing in:
- The required UrlSpec's Id

- Path parameters (dictionary, which key is path parameter that could be found in endPoint (ex.: {sessionId} in auth/login/{sessionId}))

- QueryParameters - dictionary, which values will be placed like GET params 
```swift
if let url = try? Pathfinder.shared.buildUrl(id: "auth", pathParameters: [:], queryParameters: [:]) {
    // Make URLRequest...
} else {
    // Error Handling...
}
```

#### Changing parameters with UI
To get UIViewController with Pathfinder interface, you just need to call `makeController()`
```swift
Pathfinder.shared.makeController()
```

#### Receiving changes
To receive current Pathfinder configuration state at any time changes are made by the user, make your class conform to the `PathfinderStateDelegate` protocol. Then implement `pathfinder(didReceiveUpdatedState state: PFState)` function.
```swift
extension ViewController: PathfinderStateDelegate {
    func pathfinder(didReceiveUpdatedState state: PFState) {
        print("Pathfinder State received!")
        print("Current environment base url is: \(String(describing: state.currentEnvironment?.baseUrl))\n")
    }
}
```

## TODO
Fill in our plans

## Author
##### KODE slurm@kode.ru

If you have any questions about this library, please contact: 

*Medvedev Semyon, sm@kode.ru*

*Stepan Boychenko, bs@kode.ru*

## License

Pathfinder is available under the MIT license. See the LICENSE file for more info.

