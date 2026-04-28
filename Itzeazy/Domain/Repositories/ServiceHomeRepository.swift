//
//  ServiceHomeRepository.swift
//  Itzeazy
//
//  Created by Nazmin Parween on 28/04/26.
//

import Foundation

protocol ServiceHomeRepository {
    func fetchHomeContent() async throws -> ServiceHomeContent
}
