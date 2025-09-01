//
//  Organism.swift
//  INC FINAL SWIFT
//
//  Created by Lauren Ng Sze Min on 28/8/25.
import SwiftUI

struct Organism: View {
    @State private var showingSheet = false
    @State private var Password = ["hound", "restless maw"]
    @State private var newtitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("""
                 Accursed ____, whose hunger knows no close, with ______  ______, devours both bread and bone.
                 """)
                
                .fontWeight(.bold)
                .font(.title3)
                
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        
                        Button{
                            showingSheet = true
                        } label: {
                            Text("Enter")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                    }
                }
                

                .sheet(isPresented: $showingSheet) {
                    VStack(spacing: 20) { Text("Enter the word")
                            .font(.title2)
                            .bold()
                        Form{
                            TextField("Enter the word", text: $newtitle)
                        }
                    }
                }
            }
        }
    }
    
    struct Organism_Previews: PreviewProvider {
        static var previews: some View {
            Organism()
        }
    }
}
