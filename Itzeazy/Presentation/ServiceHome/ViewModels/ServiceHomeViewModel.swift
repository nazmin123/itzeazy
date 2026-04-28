//
//  ServiceHomeViewModel.swift
//  Itzeazy
//
//  Created by Nazmin Parween on 28/04/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class ServiceHomeViewModel: ObservableObject {
    @Published var searchText = ""
    @Published private(set) var brandName = "Itzeazy"
    @Published private(set) var locationName = "New Delhi"
    @Published private(set) var searchPlaceholder = "Search for RTO, Passport, PAN..."
    @Published private(set) var featuredOffer: FeaturedOffer?
    @Published private(set) var quickOffer: QuickOffer?
    @Published private(set) var services: [ServiceItem] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let getServiceHomeContentUseCase: GetServiceHomeContentUseCase
    private var hasLoaded = false

    init(getServiceHomeContentUseCase: GetServiceHomeContentUseCase) {
        self.getServiceHomeContentUseCase = getServiceHomeContentUseCase
    }

    // UI-only filtering stays in the view model so the view remains declarative.
    var filteredServices: [ServiceItem] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return services }

        return services.filter {
            $0.title.localizedCaseInsensitiveContains(query)
        }
    }
    
    // Prevents duplicate loads when SwiftUI re-renders the screen.
    func loadIfNeeded() {
        guard !hasLoaded else { return }
        hasLoaded = true

        Task {
            await loadContent()
        }
    }

    func retry() {
        hasLoaded = false
        loadIfNeeded()
    }
    
    // Maps domain content into view-ready state.
    private func loadContent() async {
        isLoading = true
        errorMessage = nil

        do {
            let content = try await getServiceHomeContentUseCase.execute()
            brandName = content.brandName
            locationName = content.locationName
            searchPlaceholder = content.searchPlaceholder
            services = content.services
            featuredOffer = content.featuredOffer
            quickOffer = content.quickOffer
            isLoading = false
        } catch {
            errorMessage = "Unable to load services right now."
            isLoading = false
        }
    }
}
