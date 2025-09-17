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
    @Published var selectedFilter: FilterOption? = nil
    @Published var selectedCategory: CategoryOption? = nil

    enum FilterOption: String, CaseIterable {
        case noFilter
        case priceHigh
        case priceLow
        
        var priceDescending: Bool? {
            switch self {
            case .noFilter: return nil
            case .priceHigh: return true
            case .priceLow: return false
            }
        }
    }
    
    func filterSelected(option: FilterOption) async throws {
        self.selectedFilter = option
        self.getProducts()
    }
    
    enum CategoryOption: String, CaseIterable {
        case noCategory
        case beauty
        case fragrances
        case furniture
        case groceries
        
        var categoryKey: String? {
            if self == .noCategory {
                return nil
            }
            return self.rawValue
        }
    }
    
    func categorySelected(option: CategoryOption) async throws {
        self.selectedCategory = option
        self.getProducts()
    }
    
    func getProducts() {
        Task {
            self.products = try await ProductsManager.shared.getAllProductsByPrice(priceDescending: selectedFilter?.priceDescending, forCategory: selectedCategory?.categoryKey)
        }
    }
}

struct ProductsView: View {
    
    @StateObject private var viewModel = ProductsViewModel()
    
    var body: some View {
        List {
            Button("FETCH MORE OBJECTS") {
                
            }
            
            ForEach(viewModel.products) { product in
                ProductCellView(product: product)
            }
        }
        .navigationTitle("Products")
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Menu("Filter: \(viewModel.selectedFilter?.rawValue ?? "NONE")") {
                    ForEach(ProductsViewModel.FilterOption.allCases, id: \.self) { option in
                        Button(option.rawValue) {
                            Task {
                                try? await viewModel.filterSelected(option: option)
                            }
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Menu("Filter: \(viewModel.selectedCategory?.rawValue ?? "NONE")") {
                    ForEach(ProductsViewModel.CategoryOption.allCases, id: \.self) { option in
                        Button(option.rawValue) {
                            Task {
                                try? await viewModel.categorySelected(option: option)
                            }
                        }
                    }
                }
            }
        })
        .onAppear {
//            viewModel.getProducts()
            Task {
//                try? await FirestoreMigration.addAverageRatingToAllProducts()
            }

        }
    }
}

#Preview {
    NavigationStack {
        ProductsView()
    }
}
