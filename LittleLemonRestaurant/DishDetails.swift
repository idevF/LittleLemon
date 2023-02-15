//
//  DishDetails.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 15.02.2023.
//

import SwiftUI

struct DishDetails: View {
    @ObservedObject private var dish: Dish
    
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {
        ZStack {
            Color("highlightOne")
            
            ScrollView {
                VStack(spacing: 30) {
                    Spacer()
                    Image("littleLemon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 45)
                    
                    Text(dish.title ?? "")
                        .font(.custom("Karla-Bold", size: 40))
                        .foregroundColor(Color("highlightTwo"))
                    
                    Text(dish.explanation ?? "")
                        .font(.custom("Karla-Medium", size: 20))
                        .foregroundColor(Color("primaryOne"))
                        .lineSpacing(10)
                        .padding(.horizontal, 30)
                        
                    
                    Image(dish.image ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

struct DishDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        DishDetails()
//    }
    static let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    static var previews: some View {
        DishDetails(oneDish())
    }
    static func oneDish() -> Dish {
        let dish = Dish(context: context)
        dish.title = "Lemon Dessert"
        dish.image = "Lemon dessert"
        dish.explanation = "Traditional homemade Italian Lemon Ricotta Cake."
        return dish
    }
}
