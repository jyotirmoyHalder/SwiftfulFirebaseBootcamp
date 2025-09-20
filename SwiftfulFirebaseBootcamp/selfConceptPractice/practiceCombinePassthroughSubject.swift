//
//  practiceCombinePassthroughSubject.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by jyotirmoy_halder on 20/9/25.
//

import Combine
import SwiftUI

class MyViewModel: ObservableObject {
    // Published property for UI binding
    @Published var counter = 0
    
    // Subject to broadcast button taps
    let buttonTapped = PassthroughSubject<Void, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // React to button taps
        buttonTapped
            .sink { [weak self] in
                self?.counter += 1
                print("Button tapped! Counter = \(self?.counter ?? 0)")
            }
            .store(in: &cancellables)
    }
}

struct practiceCombinePassthroughSubject: View {
    @StateObject private var viewModel = MyViewModel()
        
        var body: some View {
            VStack(spacing: 20) {
                Text("Button tapped: \(viewModel.counter) times")
                    .font(.title)
                
                Button("Tap Me") {
                    // Send event into PassthroughSubject
                    viewModel.buttonTapped.send()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
}

#Preview {
    practiceCombinePassthroughSubject()
}
