import SwiftUI

struct AddQuestionView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = ForumViewModel()

    @State private var title = ""
    @State private var bodyText = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Savollaringiz")
                .font(.largeTitle)
                .bold()

            TextField("Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextEditor(text: $bodyText)
                .frame(height: 150)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))

            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            Button("Savollarni e'lon qilish") {
                guard !title.isEmpty, !bodyText.isEmpty else {
                    errorMessage = "Iltimos, barcha maydonlarni toʻldiring"
                    return
                }

                if let user = authVM.user {
                    vm.addQuestion(userID: user.uid, title: title, body: bodyText) { error in
                        if let error = error {
                            self.errorMessage = error.localizedDescription
                        } else {
                            dismiss()
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
    }
}
