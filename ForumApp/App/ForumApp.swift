import SwiftUI
import FirebaseCore

// 🔥 Firebase ni ishga tushurish uchun AppDelegate
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ForumApp: App {
    // AppDelegate ni SwiftUI ilovasiga ulaymiz
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // 👤 AuthViewModel ni umumiy holatda yaratamiz
    @StateObject var authVM = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                // 🔐 Foydalanuvchi login qilganmi yoki yo‘qmi?
                if authVM.user != nil {
                    ForumView()
                } else {
                    AuthView()
                }
            }
            .environmentObject(authVM)
        }
    }
}

