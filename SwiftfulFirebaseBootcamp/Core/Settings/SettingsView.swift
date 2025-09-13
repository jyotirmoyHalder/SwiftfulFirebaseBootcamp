//
//  SettingsView.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by jyotirmoy_halder on 9/9/25.
//

import SwiftUI



struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Log out")
            }
            
            Button(role: .destructive) {
                Task {
                    do {
                        try await viewModel.deleteAccount()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Delete account")
            }

            
            if viewModel.authProviders.contains(.email) {
                emailSection
            }
            
            if viewModel.authUser?.isAnonymous == true {
                annonymousSection
            }
        }
        .onAppear() {
            viewModel.loadAuthProviders()
            viewModel.loadAuthUser()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}


extension SettingsView {
   private var emailSection: some View {
        Section {
            Button {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("PASSWORD RESET")
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Reset password")
            }
            
            Button {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("PASSWORD UPDATED")
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Update password")
            }
            
            Button {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("EMAIL UPDATED")
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Update Email")
            }
        } header: {
            Text("Email functions")
        }
    }
    
    private var annonymousSection: some View {
         Section {
             Button {
                 Task {
                     do {
                         try await viewModel.linkGoogleAccount()
                         print("GOOGLE LINKED")
                     } catch {
                         print(error)
                     }
                 }
             } label: {
                 Text("Link Google Account")
             }
             
             Button {
                 Task {
                     do {
                         try await viewModel.linkAppleAccount()
                         print("APPLE LINKED")
                     } catch {
                         print(error)
                     }
                 }
             } label: {
                 Text("Link Apple Account")
             }
             
             Button {
                 Task {
                     do {
                         try await viewModel.linkEmailAccount()
                         print("EMAIL LINKED")
                     } catch {
                         print(error)
                     }
                 }
             } label: {
                 Text("Link Email Account")
             }
         } header: {
             Text("Create Account")
         }
     }
}
