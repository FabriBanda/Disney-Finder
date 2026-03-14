//
//  AlertError.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 14/03/26.
//

import SwiftUI

struct TestView: View {
    @State private var showError: Bool = false
    @State private var autoDismissTask: Task<Void, Never>?

    var body: some View {
        VStack {
            Button {
                self.presentError()
            } label: {
                Text("Show Error")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) {
            if showError {
                AlertError(messageError: "No internet connection") {
                    self.dismissError()
                }
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .offset(y:-300)))
            }
        }
        .animation(.bouncy, value: self.showError)
        .onDisappear {
            self.autoDismissTask?.cancel()
        }
    }

    private func presentError() {
        self.autoDismissTask?.cancel()
        self.showError = true

        self.autoDismissTask = Task {
            try? await Task.sleep(for: .seconds(3))
            guard !Task.isCancelled else { return }
            self.dismissError()
        }
    }

    private func dismissError() {
        self.autoDismissTask?.cancel()
        self.autoDismissTask = nil
        self.showError = false
    }
}

struct AlertError: View {
    let messageError: String
    let onDismiss: () -> Void

    @State private var dragOffset: CGSize = .zero

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                        .bold()
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.red)

                    Text("Ups")
                        .font(.headline)
                }

                Text(self.messageError)
                    .multilineTextAlignment(.leading)
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding()
        .background(Color.red.opacity(0.1), in: RoundedRectangle(cornerRadius: 25))
        .overlay {
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.red, lineWidth: 1)
        }
        .padding()
        .offset(y: min(self.dragOffset.height, 0))
        .gesture(
            DragGesture()
                .onChanged { value in
                    guard value.translation.height < 0 else { return }
                    self.dragOffset = value.translation
                }
                .onEnded { value in
                    if value.translation.height < -60 {
                        self.onDismiss()
                    } else {
                        self.dragOffset = .zero
                    }
                }
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: self.dragOffset)
    }
}

#Preview {
    TestView()
}
