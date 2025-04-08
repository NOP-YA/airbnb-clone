import SwiftUI
import Inject

struct ListingItemView: View {
    @ObserveInjection var inject

    let listing: Listing

    var body: some View {
        VStack(spacing: 8) {
            // images

            ListingImageCarouselView(listing: listing)
                .frame(height: 320)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            // listing details
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("\(listing.city), \(listing.state)")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text("\(listing.numberOfGuests) guests")
                        .foregroundStyle(.gray)
                    
                    Text(" 8 nights")
                        .foregroundStyle(.gray)

                    HStack (spacing: 4) {
                        Text("$\(listing.pricePerNight)")
                            .fontWeight(.semibold)
                        Text("night")
                    }
                    .foregroundStyle(.black)
                }

                Spacer()

                // rating
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                    Text(String(format: "%.2f", listing.rating))
                }
                .foregroundStyle(.black)
            }
            .font(.footnote)
        }
        .padding()
        .enableInjection()
    }
} 
