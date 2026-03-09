
import SwiftUI

// MARK: - 🔹 Компонент кнопки социальной сети
struct SocialLoginButton: View {
    let icon: Image
    let title: String
    let bgColor: Color
    let fgColor: Color
    let iconLeadingPadding: CGFloat
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                // 🔹 Иконка с констрайнтами: width: 24; height: 24; opacity: 1
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)   // ✅ width: 24; height: 24
                    .rotationEffect(.degrees(0))     // ✅ angle: 0 deg
                    .opacity(1)                      // ✅ opacity: 1
                    .padding(.leading, iconLeadingPadding) // ✅ left: 21px
                    .padding(.vertical, 18)          // ✅ Центрирование по Y (60-24)/2 = 18
                    .foregroundColor(fgColor)
                
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(fgColor)
            }
            .frame(width: 343, height: 60)
            .background(bgColor)
            .cornerRadius(14)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - 🔹 Компонент стилизованного TextField
struct StyledTextField: View {
    let placeholder: String
    let icon: String?
    @Binding var text: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: UITextAutocapitalizationType = .none
    
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(.secondary)
                    .frame(width: 20)
            }
            
            if isSecure {
                if isPasswordVisible {
                    TextField(placeholder, text: $text)
                        .textFieldStyle(.plain)
                } else {
                    SecureField(placeholder, text: $text)
                        .textFieldStyle(.plain)
                }
                Button(action: { isPasswordVisible.toggle() }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.secondary)
                }
            } else {
                TextField(placeholder, text: $text)
                    .textFieldStyle(.plain)
                    .keyboardType(keyboardType)
                    .autocapitalization(autocapitalization)
            }
        }
        .padding(.horizontal, 16)
        .frame(width: 343, height: 60)
        .background(Color(.systemGray6))
        .cornerRadius(14)
    }
}

// MARK: - 🔹 Расширение для шрифта с fallback
extension Font {
    static func poppinsMedium(size: CGFloat) -> Font {
        UIFont(name: "Poppins-Medium", size: size) != nil
            ? .custom("Poppins", size: size)
            : .system(size: size, weight: .medium)
    }
}

// MARK: - 🔹 Основной экран
struct SignupView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isAgreed: Bool = false
    
    // 🔹 AttributedString для кликабельных ссылок в тексте
    private var footerText: AttributedString {
        var result = AttributedString("By signing in, I agree with ")
        result.font = .poppinsMedium(size: 13)
        result.foregroundColor = .secondary
        
        // Terms of Use
        var terms = AttributedString("Terms of Use")
        terms.font = .poppinsMedium(size: 13)
        terms.foregroundColor = .blue
        terms.link = URL(string: "app://terms")
        result.append(terms)
        
        result.append(AttributedString(" and "))
        
        // Privacy Policy
        var privacy = AttributedString("Privacy Policy")
        privacy.font = .poppinsMedium(size: 13)
        privacy.foregroundColor = .blue
        privacy.link = URL(string: "app://privacy")
        result.append(privacy)
        
        return result
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                
                // 🔹 Кнопка "Назад"
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 28))
                        .foregroundColor(.black)
                }
                
                // 🔹 Заголовок
                VStack(spacing: 8) {
                    Text("Let's start here")
                        .font(.system(size: 34, weight: .bold))
                        .frame(width: 264, height: 51)
                    
                    Text("Fill in your details to begin")
                        .font(.system(size: 17, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
                .frame(width: 264, height: 77)
                
                // 🔹 Поля ввода
                VStack(spacing: 22) {
                    StyledTextField(placeholder: "Name", icon: "person", text: $name, autocapitalization: .words)
                    StyledTextField(placeholder: "Email", icon: "envelope", text: $email, keyboardType: .emailAddress, autocapitalization: .none)
                    StyledTextField(placeholder: "Password", icon: "lock", text: $password, isSecure: true)
                }
                
                // 🔹 Кнопка Sign Up
                Button(action: {
                    // Регистрация
                }) {
                    Text("Sign Up")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 343, height: 60)
                        .background(Color.orange)
                        .cornerRadius(14)
                }
                
                // 🔹 Стэк: divider + соц. кнопки (gap: 10px)
                VStack(spacing: 10) {
                    
                    // Divider "or"
                    HStack(spacing: 12) {
                        Rectangle().frame(height: 1).foregroundColor(.secondary.opacity(0.3))
                        Text("or").font(.system(size: 14, weight: .medium)).foregroundColor(.secondary)
                        Rectangle().frame(height: 1).foregroundColor(.secondary.opacity(0.3))
                    }
                    .padding(.vertical, 4)
                    
                    // 🔹 Кнопка Facebook (иконка: 24×24, left: 21px)
                    SocialLoginButton(
                        icon: Image("facebook-icon"),  // ✅ Добавить в Assets.xcassets
                        title: "Connect with Facebook",
                        bgColor: Color(red: 0.12, green: 0.47, blue: 0.96),
                        fgColor: .white,
                        iconLeadingPadding: 21         // ✅ left: 21px
                    ) {
                        print("Facebook login tapped")
                    }
                    
                    // 🔹 Кнопка Google (иконка: 24×24, left: 21px)
                    SocialLoginButton(
                        icon: Image("google-icon"),    // ✅ Добавить в Assets.xcassets
                        title: "Connect with Google",
                        bgColor: .white,
                        fgColor: .black,
                        iconLeadingPadding: 21         // ✅ left: 21px
                    ) {
                        print("Google login tapped")
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                    )
                    
                }
                .frame(width: 343)
                .padding(.top, 8)
                
                // 🔹 Footer текст с кликабельными ссылками
                Text(footerText)
                    .font(.poppinsMedium(size: 13))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)   // ✅ Центрирование multiline
                    .kerning(-0.05)                    // ✅ letter-spacing: -0.41%
                    .padding(.top, 16)
                    .frame(maxWidth: 329)              // ✅ maxWidth: 329
                    .frame(maxWidth: .infinity, alignment: .center) // ✅ Центрируем контейнер
                    .padding(.horizontal, 16)          // ✅ Отступы для адаптивности
                    .onOpenURL { url in                // ✅ Обработка кликов по ссылкам
                        if url.scheme == "app" {
                            if url.host == "terms" {
                                print("Terms of Use tapped")
                                // Открыть экран Terms
                            } else if url.host == "privacy" {
                                print("Privacy Policy tapped")
                                // Открыть экран Privacy
                            }
                        }
                    }
                
            } // ✅ Закрываем главный VStack
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
            .padding(.top, 45)
            .padding(.bottom, 30)
        } // ✅ Закрываем ScrollView
        .background(Color.white)
    } // ✅ Закрываем body
} // ✅ Закрываем SignupView

#Preview {
    SignupView()
}
