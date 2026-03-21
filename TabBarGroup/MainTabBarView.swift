//
//  MainTabBarView.swift
//  Dog Walk
//
//  Created by MacBook on 17.03.2026.
//
 import SwiftUI

struct MainTabBarView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        TabView {
            HomeView()
            //Color.clear
                .tabItem { Label("", image: "home") }
            Color.clear
                .tabItem { Label("", image: "moments") }
            
            Color.clear
                .tabItem { Label("", image:  "chat") }
            
            Color.clear
                .tabItem { Label("Profile", systemImage: "person.fill") }
        }
        
        }
        
    }



#Preview {
    SignupView()
}
