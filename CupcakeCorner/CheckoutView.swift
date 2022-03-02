//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Samet Karakurt on 2.03.2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: OrderClass
    
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),scale: 3){ image in
                    image
                        .resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.orderStruct.cost, format: .currency(code: "USD"))")
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
                .alert("\(alertTitle)", isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(alertMessage)
                }
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func placeOrder() async{
        guard let encoded = try? JSONEncoder().encode(order.orderStruct) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(OrderStruct.self, from: data)
            alertTitle = "Thank You!"
            alertMessage = "Your order for \(decodedOrder.quantity)x \(OrderStruct.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingAlert = true
        } catch {
            alertTitle = "Warning"
            alertMessage = "Unknown Error!"
            showingAlert = true    }
    }
    

}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: OrderClass())
    }
}
