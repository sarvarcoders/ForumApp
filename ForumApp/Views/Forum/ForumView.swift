import SwiftUI

struct ForumView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var vm = ForumViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(vm.questions) { question in
                    NavigationLink(destination: QuestionDetailView(question: question)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(question.title)
                                .font(.headline)
                            Text(question.body)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            HStack {
                                Text("👍 \(question.likedBy.count)")
                                    .font(.caption)
                                Spacer()
                                Text(question.timestamp.formatted())
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .navigationTitle("Forum")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Chiqish") {
                        authVM.signOut()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddQuestionView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                vm.loadQuestions()
            }
        }
    }
}
