//
//  ProfileView.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by jyotirmoy_halder on 13/9/25.
//

import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: AuthDataResultModel? = nil
    
    func loadCurrentuser() throws {
        self.user = try AuthenticationManager.shared.getAuthenticatedUser()
    }
    
}

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("UserId: \(user.uid)")
            }
        }
        .onAppear(perform: {
            try? viewModel.loadCurrentuser()
        })
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }

                
                Image(systemName: "gear")
                    .font(.headline)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(true))
    }
}
