//
//  ContentView.swift
//  BudgetsApp
//
//  Created by Anket Kohak on 07/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var isPresented:Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults:FetchedResults<BudgetCategory>
    var total: Double {
        budgetCategoryResults.reduce(0) { result, budgetCategory in
            return result + budgetCategory.total
        }
    }
    var body: some View {
        NavigationStack{
            VStack {
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .fontWeight(.bold)

                BudgetListView(budgetCategoryResults: budgetCategoryResults)
            }.sheet(isPresented: $isPresented, content: {
                AddBugetCategoryView()
            })
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Add Category"){
                        isPresented = true
                    }
                }
            }.padding()
            
        }
    }
}

#Preview {
    ContentView()
}
