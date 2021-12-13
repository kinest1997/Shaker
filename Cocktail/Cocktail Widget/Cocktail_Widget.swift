//
//  Cocktail_Widget.swift
//  Cocktail Widget
//
//  Created by 강희성 on 2021/11/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (CocktailEntry) -> Void) {
        let configuration = Cocktail(name: "Martini".localized, craft: .blending, glass: .saucer, recipe: ["손으로 막휘젓기"], ingredients: [.baileys], base: .assets, alcohol: .high, color: .blue, mytip: "없습니다", drinkType: .longDrink, myRecipe: false, wishList: false, imageURL: "", id: nil)
        let entry = CocktailEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    func placeholder(in context: Context) -> CocktailEntry {
        let configuration = Cocktail(name: "Martini".localized, craft: .blending, glass: .saucer, recipe: ["손으로 막휘젓기"], ingredients: [.baileys], base: .assets, alcohol: .high, color: .blue, mytip: "없습니다", drinkType: .longDrink, myRecipe: false, wishList: false, imageURL: "",id: nil)
        return CocktailEntry(date: Date(), configuration: configuration)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<CocktailEntry>) -> Void) {
//        let configuration = getWidgetRecipe().randomElement() ?? Cocktail(name: "Martini".localized, craft: .blending, glass: .cocktail, recipe: "손으로 막휘젓기", ingredients: [.baileys], base: .assets, alcohol: .high, color: .blue, mytip: "없습니다", drinkType: .longDrink, myRecipe: false, wishList: false)
//        print(configuration)
//        let entry = CocktailEntry(date: Date(), configuration: configuration)
//        let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())
//        let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate!))
//        completion(timeline)
    }
}

struct CocktailEntry: TimelineEntry {
    let date: Date
    let configuration: Cocktail
}

struct Cocktail_WidgetEntryView : View {
    @Environment(\.widgetFamily) var widgeFamily
    var entry: Provider.Entry
    
    var body: some View {
        if widgeFamily == .systemSmall {
            VStack  {
                Image(uiImage: UIImage(named: entry.configuration.name) ?? UIImage(systemName: "circle")!)
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                Spacer()
                Text(entry.configuration.name)
                    .foregroundColor(.blue)
                Text(entry.configuration.alcohol.rawValue)
                    .foregroundColor(.gray)
            }
        } else {
            HStack {
                Image(uiImage: UIImage(named: entry.configuration.name) ?? UIImage(systemName: "circle")!)
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                Spacer()
                VStack {
                    Text(entry.configuration.name)
                    Text(entry.configuration.alcohol.rawValue)
                }
            }
        }
    }
}

@main
struct Cocktail_Widget: Widget {
    let kind: String = "Cocktail_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Cocktail_WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium, .systemSmall, .systemLarge])
        .configurationDisplayName("Cocktail")
        .description("RandomRecipe")
    }
}
