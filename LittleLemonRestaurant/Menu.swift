//
//  Menu.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 10.02.2023.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    
    var body: some View {
        VStack {
            Header()
            
            Hero()
                .overlay(alignment: .bottom) {
                    TextField("Search menu", text: $searchText)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
  
            MenuBreakdown()
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text(dish.title ?? "")
                            Text(dish.price ?? "")
                            
                            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                 image
                                    .resizable()
                                    //.aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 80, height: 80)
                        }
                    }
                }
            }
            
        }
        .onAppear {
            getMenuData()
        }
    }
    
    private func getMenuData() {
        PersistenceController.shared.clear()

        let menuAddress = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: menuAddress)!
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let string = String(data: data, encoding: .utf8) {
                print(string)
                let decoder = JSONDecoder()
                let fullMenu = try? decoder.decode(MenuList.self, from: data)
                //print(fullMenu?.menu)
                for menuItem in fullMenu!.menu {
                    let newDish = Dish(context: viewContext)
                    newDish.title = menuItem.title
                    newDish.image = menuItem.image
                    newDish.category = menuItem.category
                    newDish.explanation = menuItem.explanation
                    newDish.price = menuItem.price
                }
                try? viewContext.save()
            }
        }
        task.resume()
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
       return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    private func buildPredicate() -> NSPredicate {
        return searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
