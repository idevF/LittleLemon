//
//  Menu.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 10.02.2023.
//
import CoreData
import Foundation
import SwiftUI


struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            Header()
            
            Hero(searchText: $searchText)
  
            MenuBreakdown()
            
            NavigationView {
                FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    List {
                        ForEach(dishes, id: \.self) { dish in
                            NavigationLink(destination: DishDetails(dish)) {
                                HStack(alignment: .center, spacing: 10) {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(dish.title ?? "")
                                            .font(.custom("Karla-Bold", size: 18))
                                            .foregroundColor(Color("highlightTwo"))
                                        Text(dish.explanation ?? "")
                                            .font(.custom("Karla-Regular", size: 16))
                                            .foregroundColor(Color("primaryOne"))
                                            .lineLimit(2)
                                        Text("$\(Double(dish.price ?? "") ?? 0.0, specifier: "%.2f")")
                                            .font(.custom("Karla-Medium", size: 16))
                                            .foregroundColor(Color("primaryOne"))
                                    }
                                    Spacer()

                                    AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                         image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 60, height: 60)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.top, -5)
            // makes the list background invisible, default is gray
            .scrollContentBackground(.hidden)
        }
        .onAppear {
            do {
                try getMenuData()
            }
            catch { print(error) }
        }
    }

    private func getMenuData() throws {
        PersistenceController.shared.clear()
        print(viewContext.hasChanges)
//        PersistenceController.shared.clear()
        // fetch the menu data from the server
        let menuAddress = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let menuURL = URL(string: menuAddress)
        guard let menuURL = menuURL else {
            throw NSError() // if couldn't find menu address url throws error
        }
        
        let request = URLRequest(url: menuURL)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print(responseString)
                // parse the reponse data by using JSON decoder
                let decoder = JSONDecoder()
                let fullMenu = try? decoder.decode(MenuList.self, from: data) // array of MenuItems
                //print(fullMenu?.menu)
                fullMenu?.menu.forEach { menuItem in
                    let newDish = Dish(context: viewContext)
                    newDish.title = menuItem.title
                    newDish.image = menuItem.image
                    newDish.category = menuItem.category
                    newDish.explanation = menuItem.explanation
                    newDish.price = menuItem.price
                }
                if viewContext.hasChanges {
                    print(viewContext.hasChanges)
                    try? viewContext.save()
                }
            }
        }
        task.resume()
    }
    
//    private func getMenuData() {
//        PersistenceController.shared.clear()
//
//        let menuAddress = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
//        let url = URL(string: menuAddress)!
//
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data, let string = String(data: data, encoding: .utf8) {
//                print(string)
//                let decoder = JSONDecoder()
//                let fullMenu = try? decoder.decode(MenuList.self, from: data)
//                //print(fullMenu?.menu)
//                for menuItem in fullMenu!.menu {
//                    let newDish = Dish(context: viewContext)
//                    newDish.title = menuItem.title
//                    newDish.image = menuItem.image
//                    newDish.category = menuItem.category
//                    newDish.explanation = menuItem.explanation
//                    newDish.price = menuItem.price
//                }
//                try? viewContext.save()
//            }
//        }
//        task.resume()
//    }
    
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
