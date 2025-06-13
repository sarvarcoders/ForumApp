import SwiftUI

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLogin = true

    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text(isLogin ? "Kirish" : "Ro'yxatdan o'tish")
                .font(.largeTitle)
                .bold()

            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Parol", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            if let error = authVM.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            Button(action: {
                if isLogin {
                    authVM.signIn(email: email, password: password)
                } else {
                    authVM.signUp(email: email, password: password)
                }
            }) {
                Text(authVM.isLoading ? "Yuklanmoqda..." : (isLogin ? "Kirish" : "Ro'yxatdan o'tish"))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(authVM.isLoading)

            Button(isLogin ? "Hisobingiz yo'qmi? Ro'yxatdan o'tish" : "Hisobingiz bormi? Kirish") {
                isLogin.toggle()
            }
            .padding(.top)

            Spacer()
        }
        .padding()
    }
}
