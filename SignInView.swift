//
//  SignInView.swift
//  Dog Walk
//
//  Created by MacBook on 15.03.2026.
//
import SwiftUI


//  Экран: Вход только после регистрации
struct SignInView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "lock.fill")
                .font(.system(size: 60))
                .foregroundColor(.orange)
                .padding(.top, 40)
            
            Text("Вход доступен только после регистрации")
                .font(.custom("Poppins-Bold", size: 20))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            Text("Сначала создай аккаунт, чтобы получить доступ ко всем функциям приложения")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
 
            Button("Вернуться") {
                dismiss()
            }
            .font(.system(size: 19))
            .foregroundColor(.white.opacity(0.7))
            .padding(.bottom,25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .ignoresSafeArea()
    }
    
}
#Preview {
    SignInView()
}
