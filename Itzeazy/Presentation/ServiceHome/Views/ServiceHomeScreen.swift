//
//  ServiceHomeScreen.swift
//  Itzeazy
//
//  Created by Nazmin Parween on 28/04/26.
//

import SwiftUI

struct ServiceHomeScreen: View {
    @StateObject private var viewModel: ServiceHomeViewModel

    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    init(viewModel: ServiceHomeViewModel = AppContainer.shared.makeServiceHomeViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                header
                searchBar
                servicesSection
                popularSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 14)
            .padding(.bottom, 28)
        }
        .background(Color.screenBackground.ignoresSafeArea())
        .task {
            viewModel.loadIfNeeded()
        }
    }

    private var header: some View {
        HStack {
            HStack(spacing: 12) {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.menuIconTint)

                Text(viewModel.brandName)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(Color("AccentColor"))
            }

            Spacer()

            HStack(spacing: 6) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color("AccentColor"))

                Text(viewModel.locationName)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.locationText)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.04), radius: 8, y: 3)
        }
    }

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.searchPlaceholder)

            TextField(viewModel.searchPlaceholder, text: $viewModel.searchText)
                .font(.system(size: 14, weight: .medium))
                .textFieldStyle(.plain)
        }
        .padding(.horizontal, 14)
        .frame(height: 48)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.searchBorder, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private var servicesSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("Services")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Color.primaryText)

                Spacer()

                Text("VIEW ALL")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(Color("AccentColor"))
            }

            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 32)
            } else if let errorMessage = viewModel.errorMessage {
                ErrorStateView(message: errorMessage) {
                    viewModel.retry()
                }
            } else {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.filteredServices) { service in
                        ServiceCard(item: service)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var popularSection: some View {
        if let featuredOffer = viewModel.featuredOffer,
           let quickOffer = viewModel.quickOffer {
            VStack(alignment: .leading, spacing: 18) {
                Text("Popular Right Now")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Color.primaryText)

                HeroPromotionCard(offer: featuredOffer)
                SecondaryPromotionCard(offer: quickOffer)
            }
        }
    }
}

private struct ServiceCard: View {
    let item: ServiceItem

    var body: some View {
        VStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.softAccentBackground)
                    .frame(width: 44, height: 44)

                Image(systemName: item.systemImageName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color("AccentColor"))
            }

            Text(item.title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color.serviceLabel)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.85)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 136)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: .black.opacity(0.035), radius: 14, y: 6)
    }
}

private struct HeroPromotionCard: View {
    let offer: FeaturedOffer

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.heroGradientTop,
                            Color.heroGradientBottom
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay(alignment: .topLeading) {
                    RoadGlow()
                        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                }

            LinearGradient(
                colors: [
                    Color.black.opacity(0.02),
                    Color.black.opacity(0.5),
                    Color.black.opacity(0.78)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))

            VStack(alignment: .leading, spacing: 12) {
                Text(offer.badgeTitle)
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1.5)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(Color("AccentColor"))
                    .clipShape(Capsule())

                Text(offer.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.white)

                Text(offer.description)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.82))
                    .lineSpacing(2)

                Button(action: {}) {
                    Text(offer.actionTitle)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Color.heroButtonText)
                        .frame(width: 122, height: 46)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.top, 2)
            }
            .padding(24)
        }
        .frame(height: 290)
        .shadow(color: Color.primaryText.opacity(0.14), radius: 16, y: 8)
    }
}

private struct SecondaryPromotionCard: View {
    let offer: QuickOffer

    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            VStack(alignment: .leading, spacing: 16) {
                ZStack {
                    Circle()
                        .fill(Color.softAccentBackground)
                        .frame(width: 42, height: 42)

                    Image(systemName: offer.systemImageName)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Color("AccentColor"))
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text(offer.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(Color.primaryText)

                    Text(offer.description)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.secondaryText)
                        .lineSpacing(2)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(offer.priceLabel)
                        .font(.system(size: 9, weight: .bold))
                        .tracking(1.2)
                        .foregroundStyle(Color.priceCaption)

                    Text(offer.price)
                        .font(.system(size: 34, weight: .heavy))
                        .foregroundStyle(Color("AccentColor"))
                        .minimumScaleFactor(0.75)
                }
            }

            Spacer(minLength: 0)

            Button(action: {}) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color.chevronForeground)
                    .frame(width: 38, height: 38)
                    .background(Color.chevronBackground)
                    .clipShape(Circle())
            }
            .padding(.bottom, 10)
        }
        .padding(24)
        .frame(maxWidth: .infinity, minHeight: 255, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: .black.opacity(0.04), radius: 14, y: 8)
    }
}

private struct ErrorStateView: View {
    let message: String
    let retry: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            Text(message)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.secondaryText)

            Button("Try Again", action: retry)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(Color("AccentColor"))
                .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
    }
}

private struct RoadGlow: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.12))
                .blur(radius: 80)
                .offset(x: -80, y: -80)

            Circle()
                .fill(Color.roadGlow.opacity(0.45))
                .blur(radius: 60)
                .offset(x: 90, y: -110)

            Path { path in
                path.move(to: CGPoint(x: 10, y: 225))
                path.addCurve(
                    to: CGPoint(x: 360, y: 205),
                    control1: CGPoint(x: 120, y: 165),
                    control2: CGPoint(x: 245, y: 265)
                )
            }
            .stroke(Color.white.opacity(0.12), style: StrokeStyle(lineWidth: 42, lineCap: .round))
            .blur(radius: 2)
        }
    }
}

#Preview {
    ServiceHomeScreen(viewModel: AppContainer.shared.makeServiceHomeViewModel())
}
