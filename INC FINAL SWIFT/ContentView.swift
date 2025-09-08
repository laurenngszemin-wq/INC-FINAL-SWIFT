//
//  ContentView.swift
//  INC FINAL SWIFT
//
//  Created by Lauren Ng Sze Min on 27/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            // Tab 1: Current menu / tasks
            NavigationView {
                VStack {
                    Text("The INCoin Heist test")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding()
                    
                    List {
                        NavigationLink(destination: Part1()) {
                            Text("Tasks")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
                    .font(.largeTitle)
            }
            
            Culprits()
                .tabItem {
                    Image(systemName: "person.fill.questionmark")
                    Text("Culprits")
                        .font(.largeTitle)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

