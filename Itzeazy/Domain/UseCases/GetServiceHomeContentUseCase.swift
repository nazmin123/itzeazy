//
//  GetServiceHomeContentUseCase.swift
//  Itzeazy
//
//  Created by Nazmin Parween on 28/04/26.
//




// Keeps the presentation layer unaware of how data is fetched.
struct GetServiceHomeContentUseCase {
    private let repository: ServiceHomeRepository

    init(repository: ServiceHomeRepository) {
        self.repository = repository
    }

    func execute() async throws -> ServiceHomeContent {
        try await repository.fetchHomeContent()
    }
}
