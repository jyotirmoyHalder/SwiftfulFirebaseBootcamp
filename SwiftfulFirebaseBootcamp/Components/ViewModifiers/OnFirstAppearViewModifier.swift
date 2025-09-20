//
//  OnFirstAppearViewModifier.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by jyotirmoy_halder on 20/9/25.
//

import Foundation
import SwiftUI

struct OnFirstAppearViewModifier: ViewModifier {
    @State private var didAppear: Bool = false
    let perform: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if !didAppear {
                    perform?()
                    didAppear = true
                }
            }
    }
}

extension View {
    func OnFirstAppear(perform: (() -> Void)?) -> some View {
        modifier(OnFirstAppearViewModifier(perform: perform))
    }
}
