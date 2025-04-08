//
//  WishlistView.swift
//  AirbnbClone
//
//  Created by Henry on 4/6/25.
//

import SwiftUI
import Inject

struct WishlistView: View {
    @ObserveInjection var inject

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 32)  {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Log in to View your wishlists")
                        .font(.headline)

                    Text("You can create, view or edit wishlists once you've\n logged in")
                        .font(.footnote)
                        .padding(.bottom)
                }
                    .padding()
                
                Button {
                    print("Log in")
                } label: {
                    Text("Log in")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 360, height: 48)
                        .background(.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                Spacer()

            }
            .padding()
            .navigationTitle("Wishlists")
        }
        .enableInjection()
    }
}

#Preview {
    WishlistView()
}
