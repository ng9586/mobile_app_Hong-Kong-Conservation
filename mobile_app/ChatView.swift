import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatGPTViewModel()

    var body: some View {
        VStack {
            ScrollViewReader { scrollProxy in
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.messagesList.indices, id: \.self) { index in
                            let message = viewModel.messagesList[index]
                            Text(verbatim: message)
                                .padding()
                                .background(message.starts(with: "User") ? Color.blue.opacity(0.2) : Color.green.opacity(0.2))
                                .cornerRadius(8)
                                .padding(.horizontal)
                                .id(index)
                        }
                    }
                    .onChange(of: viewModel.messagesList.count) { _ in
                        if let lastIndex = viewModel.messagesList.indices.last {
                            scrollProxy.scrollTo(lastIndex, anchor: .bottom)
                        }
                    }
                }
            }

            HStack {
                TextField("Type your message...", text: $viewModel.inputMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Send") {
                    viewModel.sendMessage()
                }
                .padding()
                .disabled(viewModel.inputMessage.isEmpty)
            }
        }
        .padding()
    }
}
