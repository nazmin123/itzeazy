//
//  MockServiceHomeRepository.swift
//  Itzeazy
//
//  Created by Nazmin Parween on 28/04/26.
//



// Swap this mock with a live API-backed repository when backend integration is ready.
struct MockServiceHomeRepository: ServiceHomeRepository {
    func fetchHomeContent() async throws -> ServiceHomeContent {
        ServiceHomeContent(
            brandName: "itzeazy",
            locationName: "New Delhi",
            searchPlaceholder: "Search for RTO, Passport, PAN...",
            services: [
                ServiceItem(title: "RTO Services", systemImageName: "car.fill"),
                ServiceItem(title: "Passport", systemImageName: "book.closed"),
                ServiceItem(title: "PAN Card", systemImageName: "creditcard"),
                ServiceItem(title: "Birth Certificate", systemImageName: "checkmark.seal"),
                ServiceItem(title: "Marriage Reg.", systemImageName: "heart"),
                ServiceItem(title: "Visa", systemImageName: "airplane.departure"),
                ServiceItem(title: "Income Tax", systemImageName: "indianrupeesign.circle"),
                ServiceItem(title: "Attestation", systemImageName: "doc.text")
            ],
            featuredOffer: FeaturedOffer(
                badgeTitle: "HOTTEST CHOICE",
                title: "Driving License\nRenewal",
                description: "Skip the queues at the RTO.\n100% online process with\ndoorstep delivery.",
                actionTitle: "Start Now"
            ),
            quickOffer: QuickOffer(
                title: "International Driving\nPermit",
                description: "Planning a road trip abroad? Get\nyour IDP processed in just 48\nhours.",
                priceLabel: "FEE\nSTARTING\nAT",
                price: "₹2,499",
                systemImageName: "medal"
            )
        )
    }
}
