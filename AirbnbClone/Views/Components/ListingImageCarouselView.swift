//
//  ListingImageCarouseView.swift
//  AirbnbClone
//
//  Created by Henry on 3/14/25.
//

import SwiftUI

struct ListingImageCarouselView: View {

    let listing: Listing

    var body: some View {
        VStack(spacing: 8) {
            // images
            TabView {
                ForEach(listing.imageUrls, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .scaledToFill()
                }
            }
            .tabViewStyle(.page)
        }
    }
}

#Preview {
    ListingImageCarouselView(listing: DeveloperPreview.shared.listings[0])
}
