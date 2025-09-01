//
//  ContentView.swift
//  INC FINAL SWIFT
//
//  Created by Lauren Ng Sze Min on 27/8/25.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                Text("The INCoin Heist")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                List {
                    NavigationLink(destination: Part1() ) {
                        Text("1. Steps")
                            .font(.title)
                            .fontWeight(.bold)
                    
                    }
                    }
              
                }
                .listStyle(PlainListStyle())
                .padding()
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
