//
//  AppContainer.swift
//  Itzeazy
//
//  Created by Nazmin Parween on 28/04/26.
//

import Foundation

// Central place to assemble feature dependencies.
final class AppContainer {
    static let shared = AppContainer()

    private init() {}

    func makeServiceHomeViewModel() -> ServiceHomeViewModel {
        let repository = MockServiceHomeRepository()
        let useCase = GetServiceHomeContentUseCase(repository: repository)
        return ServiceHomeViewModel(getServiceHomeContentUseCase: useCase)
    }
}
