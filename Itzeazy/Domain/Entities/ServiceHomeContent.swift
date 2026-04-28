//
//  ServiceHomeContent.swift
//  Itzeazy
//
//  Created by Nazmin Parween on 28/04/26.
//

import Foundation

struct ServiceItem: Identifiable, Hashable {
    let id: UUID
    let title: String
    let systemImageName: String

    init(id: UUID = UUID(), title: String, systemImageName: String) {
        self.id = id
        self.title = title
        self.systemImageName = systemImageName
    }
}

struct FeaturedOffer: Hashable {
    let badgeTitle: String
    let title: String
    let description: String
    let actionTitle: String
}

struct QuickOffer: Hashable {
    let title: String
    let description: String
    let priceLabel: String
    let price: String
    let systemImageName: String
}

struct ServiceHomeContent: Hashable {
    let brandName: String
    let locationName: String
    let searchPlaceholder: String
    let services: [ServiceItem]
    let featuredOffer: FeaturedOffer
    let quickOffer: QuickOffer
}
