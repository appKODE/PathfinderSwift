import UIKit
import Pathfinder_Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Setup Pathfinder in the beginning of your app's lifecycle

        // List your UrlSpecs
        let urlSpec1 = UrlSpec(
            id: "auth",
            pathTemplate: "/auth/login",
            httpMethod: .get,
            tag: "auth",
            name: "Authentication",
            currentStoplightQueryParams: [:]
        )

        let urlSpec2 = UrlSpec(
            id: "register",
            pathTemplate: "/auth/{sessionId}",
            httpMethod: .post,
            tag: "auth",
            name: "Registration",
            currentStoplightQueryParams: [:]
        )

        let urlSpec3 = UrlSpec(
            id: "upload",
            pathTemplate: "/files/upload",
            httpMethod: .post,
            tag: "files",
            name: "Uploading",
            currentStoplightQueryParams: [:]
        )

        let urlSpecs: [UrlSpec] = [urlSpec1, urlSpec2, urlSpec3]


        // List your environments
        let devEnv = PFEnvironment(id: UUID(), name: "DEV", baseUrl: "dev.ru", queryParams: ["__code", "__example"])
        let intEnv = PFEnvironment(id: UUID(), name: "INT", baseUrl: "int.ru", queryParams: ["__code"])
        let relEnv = PFEnvironment(id: UUID(), name: "REL", baseUrl: "rel.ru", queryParams: [])
        let environments = [devEnv, intEnv, relEnv]

        // Configure Pathfinder
        Pathfinder.shared.configure(
            config: .init(specs: urlSpecs, environments: environments, initialEnvironmentIndex: 0)
        )

        return true
    }
}

