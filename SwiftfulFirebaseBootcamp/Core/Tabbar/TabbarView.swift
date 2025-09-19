//
//  TabbarView.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by jyotirmoy_halder on 19/9/25.
//

import SwiftUI

struct TabbarView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        TabView {
            Tab("Products", systemImage: "cart") {
                NavigationStack {
                    ProductsView()
                }
            }
            
            Tab("Favorites", systemImage: "star.fill") {
                NavigationStack {
                    Color.red
                }
            }
            
            Tab("Profile", systemImage: "person") {
                NavigationStack {
                    ProfileView(showSignInView: $showSignInView)
                }
            }
            
        }
    }
}

#Preview {
    TabbarView(showSignInView: .constant(false))
}
