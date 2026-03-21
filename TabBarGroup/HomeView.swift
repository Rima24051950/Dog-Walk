//
//  HomeView.swift
//  Dog Walk
//
//  Created by MacBook on 17.03.2026.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var showNextScreen = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack  (alignment: .leading){
                
                HStack(spacing:10) {
                    
                    
                    VStack(spacing: 8) {
                        Text("Home")
                            .font(.system(size: 34,weight: .bold))
                            .frame(width: 119,height: 51)
                            .opacity(1)
                            .foregroundColor(.black)
                        
                        Text ("Explore dog walkers")
                            .font(.system(size: 16,weight: .medium))
                            .frame(width: 180,height: 26)
                            .opacity(1)
                            .foregroundStyle(.gray)
                    }
                    
                    .frame(width: 180, height: 77)
                    .opacity(1)
                    
                    
                    Button(action: {
                        showNextScreen = true
                    }) {
                        Text ("Войти")
                            .font(.system(size: 14,weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .frame(width: 104,height: 41)
                    .padding(.top,13)
                    .padding(.trailing,15)
                    .padding(.bottom,13)
                    .padding(.leading,15)
                    .background(Color.orange)        // ← Цвет фона
                    .cornerRadius(10)                // ← border-radius: 10px
                    .opacity(1)
                    
                }
                .padding(.top, 18)    // ← top: 18px
                                .padding(.leading, 16) // ← left: 16px (или 239px от правого края)
                                
                    
                    HStack (spacing:9){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                        
                        // ← 1. Открыли VStack
                        TextField("", text: $searchText)
                            .textFieldStyle(.plain)
                            .font(.system(size: 16))
                        
                        if searchText.isEmpty {
                            Button( action:{searchText = ""}){
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    .padding(9)
                    .background(.gray.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.top, 20)
                    
                    Spacer()
                }
            .fullScreenCover(isPresented: $showNextScreen) {
                        MomentsView()  // ← Экран для перехода
                    }
                }
            }
                
            }
            //  Закрыли body
        
    

#Preview {
    HomeView()
}
