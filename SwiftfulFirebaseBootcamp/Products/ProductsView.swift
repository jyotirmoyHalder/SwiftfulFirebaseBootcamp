//
//  ProductsView.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by jyotirmoy_halder on 15/9/25.
//

import SwiftUI

@MainActor
final class ProductsViewModel: ObservableObject {
    
    @Published private(set) var products: [Product] = []
    
    func getAllProducts() async throws {
        self.products = try await ProductsManager.shared.getallProducts()
    }

}

struct ProductsView: View {
    
    @StateObject private var viewModel = ProductsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.products) { product in
                ProductCellView(product: product)
            }
        }
        .navigationTitle("Products")
        .task {
            try? await viewModel.getAllProducts()
        }
    }
}

#Preview {
    NavigationStack {
        ProductsView()
    }
}
