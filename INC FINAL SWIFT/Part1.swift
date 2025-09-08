//
//  Part1.swift
//  INC FINAL SWIFT
//
//  Created by Lauren Ng Sze Min on 27/8/25.
//


import SwiftUI

struct Part1: View {
    @State private var numtask: Int = 7
    @State private var completed: Int = 0
    
    var completionbar: Float {
        Float(completed) / Float(numtask)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Completion of game")
                    .fontWeight(.bold)
                    .foregroundStyle(.teal)
                    .font(.headline)
                
                ProgressView(value: completionbar)
                
                List {
                    NavigationLink(destination: Organism(completed: $completed)) {
                        Text("1. House")
                            .font(.title)
                    }
                }
            }
            .padding()
        }
    }
}

struct Part1_Previews: PreviewProvider {
    static var previews: some View {
        Part1()
    }
}
