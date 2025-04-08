//
//  ListingDetailView.swift
//  AirbnbClone
//
//  Created by Henry on 3/14/25.
//

import SwiftUI
import Inject
import MapKit

struct ListingDetailView: View {
    @ObserveInjection var inject
    @Environment(\.dismiss) var dismiss
    let listing: Listing
    @State private var cameraPosition: MapCameraPosition

    init(listing: Listing) {
        self.listing = listing

        let region = MKCoordinateRegion(
            center: listing.city == "Los Angeles" ? .losAngels : .miami,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
        self._cameraPosition = State(initialValue: .region(region))
    } 

    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                ListingImageCarouselView(listing: listing)
                    .frame(height: 320)

                Button {

                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .background {
                            Circle()
                                .fill(.white)
                                .frame(width: 32, height: 32)
                        }
                        .padding(32)
                        .padding(.top, 20)
                }
                    .buttonStyle(.plain)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(listing.title)
                    .font(.title)
                    .fontWeight(.semibold)

                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")

                        Text("\(listing.rating)")

                        Text("-")

                        Text(" 28 reviews")
                            .underline()
                            .fontWeight(.semibold)
                    }
                    .font(.caption)
                    .foregroundStyle(.black)

                Text("\(listing.city), \(listing.state)")
                    .font(.caption)
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)

            Divider()

            // Host info View
            HStack {
                VStack(alignment: .leading) {
                    Text("Entire \(listing.type.description) hosted by\n\(listing.ownerName)")
                        .font(.headline) 

                    HStack(spacing: 2) {
                        Text("\(listing.numberOfGuests) guests -")
                        Text("\(listing.numberOfBedrooms) bedrooms -")
                        Text("\(listing.numberOfBeds) beds -")
                        Text("\(listing.numberOfBathrooms) baths")
                    }
                    .font(.caption) 
                }
                .frame(width: 300, alignment: .leading)

                Image(listing.ownerImageUrl)
                    .resizable() 
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
            }
            .padding()
            
            Divider()

            // listing feature

            VStack(alignment: .leading, spacing: 16) {
                ForEach(listing.features) { feature in
                    HStack {
                        Image(systemName: feature.imageName)
                        
                        VStack(alignment: .leading) {
                            Text(feature.title)
                                .font(.footnote)
                                .fontWeight(.semibold)

                            Text(feature.description)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                    }
                }
            }
            .padding()

            Divider()

            VStack(alignment: .leading) {
                Text("What you'll sleep")
                    .font(.headline)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(1..<listing.numberOfBedrooms, id: \.self) { bedroom in
                            VStack { 
                                Image(systemName: "bed.double")
                                    .offset(x: -30)
                                Text("Bedroom \(bedroom)")
                            }
                            .frame(width: 132, height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                        }
                    }
                }
                    .scrollTargetBehavior(.paging)
            }
            .padding()


            Divider()

            // listing amenities
            VStack(alignment:.leading, spacing: 16) {
                Text("What this place offers")
                    .font(.headline)

                ForEach(listing.amenities) { amenity in 
                    HStack {
                        Image(systemName: amenity.imageName)
                            .frame(width: 32)
                        Text(amenity.title)
                            .font(.footnote)
                        
                        Spacer()
                    }
                }
            }
            .padding()
            
            Divider()
            // location map
            VStack(alignment: .leading, spacing: 16) {
                Text("Where you'll be")
                    .font(.headline)


                Map(position: $cameraPosition)
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

            }
            .padding()    
        }
        .ignoresSafeArea()
        .padding(.bottom, 64)
        .overlay(alignment: .bottom) {
            VStack {
                Divider()
                    .padding(.bottom)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("$\(listing.pricePerNight)")
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Text("Total before taxes")
                            .font(.footnote)

                        Text("Oct 15 - 20")
                            .font(.footnote)
                            .underline()
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()

                    Button {

                    } label: {
                        Text("Reserve")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 140, height: 40)
                            .background(.pink)  
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(.horizontal, 32)
            }
            .background(.white)
        }
        .toolbar(.hidden, for: .tabBar)
        .enableInjection()
    }
}

#Preview {
    ListingDetailView(listing: DeveloperPreview.shared.listings[0])
}
