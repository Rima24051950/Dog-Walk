//
//  OnboardingView.swift
//  Dog Walk
//
//  Created by MacBook on 17.02.2026.
//
import SwiftUI

// 📄 Модель страницы
struct OnboardingPage: Identifiable {
    let id = UUID()
    let title: String
    let image: String
}

// 🎬 Главный View
struct OnboardingView: View {
    @State private var showSignup = false
    @State private var currentPage = 0
    
    let pages: [OnboardingPage] = [
        OnboardingPage(title: "Too tired to walk your dog? Let us help you!", image: "onboarding"),
        OnboardingPage(title: "Professional walkers for your best friend", image: "onboarding2"),
        OnboardingPage(title: "Track walks and get real-time updates", image: "onboarding3")
    ]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // 🖼 Фон на весь экран
            Image(pages[currentPage].image)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            
            // 🎨 Градиент поверх
            LinearGradient(
                gradient: Gradient(
                    stops: [
                        .init(color: Color(red: 32/255, green: 32/255, blue: 32/255).opacity(0.95), location: 0.0),
                        .init(color: Color(red: 32/255, green: 32/255, blue: 32/255).opacity(0.5), location: 0.3),
                        .init(color: Color.clear, location: 1.0)
                    ]
                ),
                startPoint: .bottom,
                endPoint: .top
            )
            .ignoresSafeArea()
            
            // 🔴 Логотип
            LogoView()
            
            // 📦 ContentStack с нумерацией внутри
            ContentStack(
                page: pages[currentPage],
                currentPage: currentPage,
                totalPages: pages.count,
                onPageSelected: { index in
                    withAnimation {
                        currentPage = index
                    }
                },
                onNext: {
                    if currentPage < pages.count - 1 {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        showSignup = true
                    }
                },
                onSignIn: {
                    showSignup = true
                }
            )
            .frame(maxWidth: .infinity, alignment: .center)
            .offset(x: 21, y: 515)
        }
        .fullScreenCover(isPresented: $showSignup) {
            SignupView()
        }
    }
}

// 🔴 LogoView
struct LogoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 4) {
                Image("logo1")
                    .resizable()
                    .frame(width: 40, height: 40)
                Image("WOODOG")
                    .resizable()
                    .frame(width: 58, height: 36)
            }
            .frame(width: 101, height: 40)
            .padding(.top, 45)
            .padding(.leading, 16)
        }
    }
}

// 🔢 NumberingViewInline — кликабельная нумерация
struct NumberingViewInline: View {
    let currentPage: Int
    let totalPages: Int
    let onPageSelected: (Int) -> Void
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<totalPages, id: \.self) { index in
                Group {
                    Text("\(index + 1)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(index == currentPage ? .black : .white)
                        .frame(width: 30, height: 30)
                        .background(
                            Circle()
                                .fill(index == currentPage ? Color.white : Color.black)
                        )
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(index == currentPage ? 1 : 0.3), lineWidth: 1)
                        )
                        .onTapGesture {
                            onPageSelected(index)
                        }
                    
                    if index < totalPages - 1 {
                        Rectangle()
                            .fill(Color.white.opacity(0.5))
                            .frame(width: 20, height: 2)
                            .cornerRadius(1)
                    }
                }
            }
        }
        .frame(width: 332, height: 30)
    }
}

// 📦 ContentStack — нумерация + текст + кнопка + Sign in
struct ContentStack: View {
    let page: OnboardingPage
    let currentPage: Int
    let totalPages: Int
    let onPageSelected: (Int) -> Void
    let onNext: () -> Void
    let onSignIn: () -> Void
    
    var body: some View {
        VStack(spacing: 22) {
            // 🔢 Нумерация
            NumberingViewInline(
                currentPage: currentPage,
                totalPages: totalPages,
                onPageSelected: onPageSelected
            )
            
            // 📄 Текст
            VStack(spacing: 12) {
                Text(page.title)
                    .font(.custom("Poppins-Bold", size: 22))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(0)
                    .tracking(-0.0041)
                    .baselineOffset(0)
            }
            .frame(width: 332, height: 66)
            
            // 🔘 Кнопка
            Button(action: onNext) {
                Text(currentPage < totalPages - 1 ? "Join our community" : "Join our community")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 324, height: 58)
                    .background(Color.orange)
                    .cornerRadius(14)
            }
            .padding(.top, 16)
            
            // 🔗 Sign in
            HStack(spacing: 4) {
                Text("Already a member?")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.7))
                Button("Sign in", action: onSignIn)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.orange)
            }
        }
        .frame(width: 332, height: 240)
    }
}

// 📝 SignupView
struct SignpView: View {
    var body: some View {
        Text("Signup Screen")
    }
}

#Preview {
    OnboardingView()
}
