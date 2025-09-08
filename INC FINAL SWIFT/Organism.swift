import SwiftUI

struct Organism: View {
    @Binding var completed: Int
    @State private var showingSheet = false
    @State private var enteredWord = ""
    @State private var playerStage = 0

    // Each stage’s answers in order; indexes map to placeholders {0}, {1}, ...
    @State private var answers: [[String]] = [
        ["hound", "restless maw"],
        ["steals"],
        ["coin", "feed the beast whose yearning"],
        ["hungriest dog", "expend"]
    ]

    // Use indexed placeholders per stage
    @State private var messages: [String] = [
        "Accursed {0}, whose hunger knows no close, with {1}, devours both bread and bone.",
        "So dire his craving, wealth to hunger goes -- his master {0}, and conscience is o’erthrown.",
        "For every {0}, his master bends and breaks, To {1} hath no end.",
        "All honor lost, each wretched choice he makes, For the {0}, his soul must now {1}."
    ]

    @State private var fullMessage = """
    Accursed hound, whose hunger knows no close, With restless maw, devours both bread and bone.
    So dire his craving, wealth to hunger goes — His master steals, and conscience is o’erthrown.
    For every coin, his master bends and breaks, To feed the beast whose yearning hath no end.
    All honor lost, each wretched choice he makes, For the hungriest dog, his soul must now expend.
    """

    // Track which indices are filled at this stage
    @State private var filledIndices: Set<Int> = []

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if playerStage < messages.count {
                    Text(getStageMessage())
                        .fontWeight(.bold)
                        .font(.title3)
                        .padding()

                    Text("Blanks remaining: \(answers[playerStage].count - filledIndices.count)")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                } else {
                    Text(fullMessage)
                        .fontWeight(.bold)
                        .font(.title3)
                        .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Enter") { showingSheet = true }
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            .sheet(isPresented: $showingSheet) {
                SheetEntry(
                    onSubmit: {
                        handleSubmission()
                    },
                    text: $enteredWord
                )
                .padding()
            }
        }
    }

    // Build stage message by replacing {index} tokens deterministically
    private func getStageMessage() -> String {
        guard playerStage < messages.count else { return fullMessage }
        var msg = messages[playerStage]
        let stageAnswers = answers[playerStage]

        for i in 0..<stageAnswers.count {
            let token = "{\(i)}"
            if filledIndices.contains(i) {
                msg = msg.replacingOccurrences(of: token, with: stageAnswers[i])
            } else {
                msg = msg.replacingOccurrences(of: token, with: "____")
            }
        }
        return msg
    }

    private func normalized(_ s: String) -> String {
        // Lowercase, trim, collapse internal whitespace to a single space
        let trimmed = s.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let collapsed = trimmed.replacingOccurrences(
            of: "\\s+",
            with: " ",
            options: .regularExpression
        )
        return collapsed
    }

    private func handleSubmission() {
        guard playerStage < answers.count else {
            enteredWord = ""
            showingSheet = false
            return
        }

        let currentAnswers = answers[playerStage].map(normalized)
        let guess = normalized(enteredWord)

        // Find the first not-yet-filled index that matches the guess
        if let idx = currentAnswers.indices.first(where: { i in
            !filledIndices.contains(i) && currentAnswers[i] == guess
        }) {
            filledIndices.insert(idx)
        }

        // Advance when all blanks for this stage are filled
        if filledIndices.count == currentAnswers.count {
            playerStage += 1
            filledIndices.removeAll()
            if playerStage == answers.count {
                completed += 1
            }
        }

        enteredWord = ""
        showingSheet = false
    }
}

// Separate sheet view with dismiss + onSubmit UX
private struct SheetEntry: View {
    @Environment(\.dismiss) private var dismiss
    var onSubmit: () -> Void
    @Binding var text: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter the missing word")
                .font(.title2)
                .bold()

            TextField("Type here", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .submitLabel(.done)
                .onSubmit {
                    onSubmit()
                    dismiss()
                }

            Button("Submit") {
                onSubmit()
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}


struct Organism_Previews: PreviewProvider {
    static var previews: some View {
        Organism(completed: .constant(0))
    }
}
