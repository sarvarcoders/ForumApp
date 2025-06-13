import Foundation
import FirebaseAuth
import Combine

final class AuthViewModel: ObservableObject {
    @Published var user: User? = nil         // Firebase foydalanuvchi
    @Published var isLoading = false         // Yozuv vaqtida yuklanish holati
    @Published var errorMessage: String?     // Xatolik matni

    private var handle: AuthStateDidChangeListenerHandle?

    init() {
        observeAuthChanges()
    }

    //  Foydalanuvchi login/logout bo‘lsa, real vaqt kuzatish uchun
    private func observeAuthChanges() {
        handle = Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
        }
    }

    //  Login uchun
    func signIn(email: String, password: String) {
        self.errorMessage = nil
        self.isLoading = true

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.user = result?.user
                }
            }
        }
    }

    //  Sign Up uchun
    func signUp(email: String, password: String) {
        self.errorMessage = nil
        self.isLoading = true

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.user = result?.user
                }
            }
        }
    }

    //  Logout uchun
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }

    deinit {
        //  Listener tozalanadi
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
