import SwiftUI

struct QuestionDetailView: View {
    let question: Question

    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var vm = ForumViewModel()

    @State private var newAnswer = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(question.title)
                .font(.title2)
                .bold()

            Text(question.body)
                .font(.body)

            HStack {
                Text("Vaqt : \(question.timestamp.formatted())")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Text("👍 \(question.likedBy.count)")
                    .font(.caption)
            }

            Divider()

            Text("Javoblar")
                .font(.headline)

            // 🔁 Answer list (mock for now)
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(vm.answers, id: \.id) { answer in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(answer.body)
                            Text("- \(answer.userEmail)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                }
            }

            Divider()

            VStack(spacing: 12) {
                TextEditor(text: $newAnswer)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.4)))

                Button("Javobni yuborish") {
                    guard !newAnswer.trimmingCharacters(in: .whitespaces).isEmpty else {
                        errorMessage = "Javob bo'sh bo'lishi mumkin emas"
                        return
                    }

                    if let user = authVM.user {
                        vm.addAnswer(to: question, userID: user.uid, email: user.email ?? "unknown", body: newAnswer) { error in
                            if let error = error {
                                errorMessage = error.localizedDescription
                            } else {
                                newAnswer = ""
                                errorMessage = nil
                            }
                        }
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Savollar")
        .onAppear {
            vm.loadAnswers(for: question)
        }
    }
}
