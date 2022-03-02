//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Samet Karakurt on 2.03.2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: OrderClass
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderStruct.name)
                TextField("Street address", text: $order.orderStruct.streetAddress)
                TextField("City", text: $order.orderStruct.city)
                TextField("Zip", text: $order.orderStruct.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.orderStruct.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: OrderClass())
    }
}
