//
//  Part1.swift
//  INC FINAL SWIFT
//
//  Created by Lauren Ng Sze Min on 27/8/25.
//
import SwiftUI

struct Part1: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Completion of game")
                    .fontWeight(.bold)
                    .foregroundStyle(.teal)
                    .font(.headline)
                ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                List{
                    NavigationLink(destination: Organism() ) {
                        Text("1. House")
                            .font(.title)
                    }
                    Text("Your first clue (This one is free :D)")
                }
            }
        }
        
    }
}
