//
//  Order.swift
//  CupcakeCorner
//
//  Created by Samet Karakurt on 2.03.2022.
//

import Foundation


struct OrderStruct: Codable {
    static let types = ["Vanilla","Strawberry","Chocolate","Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequesEnabled = false {
        didSet {
            if specialRequesEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        
        if name.isEmpty || name == " " || streetAddress.isEmpty || streetAddress == " " || city.isEmpty || city == " " || zip.isEmpty || zip == " " {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1 for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50 for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
}
