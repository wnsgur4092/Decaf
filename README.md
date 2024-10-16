# Decaf
> Decaf is an iOS app designed to help users track their daily coffee intake and monitor their caffeine consumption. With Decaf, users can record the type of coffee they drink each day and the amount of caffeine they consume. The app also provides a feature to check if the user has exceeded the recommended daily caffeine intake of 400mg.

Development periold: 30.01.2023 ~ 24.02.2023 (Apple Foundation Program)


## About

![decaffeine](https://user-images.githubusercontent.com/43236727/222949690-a570ce1a-c959-4bc2-bd59-40be766ea98f.png)

![Simulator Screen Recording - iPhone 14 Pro - 2023-03-05 at 19 24 23](https://user-images.githubusercontent.com/43236727/222949938-fe7d3b54-8c81-4b13-b5c2-40ba334b224d.gif)

## Update
- Version 1.0.0 : Prototype (24.02.2023)
- Verison 1.0.1 : Refactoring codes(~ on going)

## Develop Environment
- Language : Swift 5.6
- iOS Deployment Target : 14.0
- Xcode : 14.2

## Technical Skills
- UIKit
- SwiftUI
- MVVM
- Combine
- Collaboration using Github

## Libary
- Realm
- Lottie

## Privacy Policy
- [Privacy Policy](https://wnsgur4092.notion.site/Privacy-Policy-19722dcba877400784abd66352623d04)

## 💡Challenge
1. Lottie
- In developing Decaf, we incorporated Lottie animations to create an engaging and visually appealing OnBoardingView. This approach allowed us to present animated content seamlessly, enhancing the user experience by providing a dynamic and interactive introduction to the app.
```swift
struct LottieView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    var filename: String

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {

        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named(filename)
  
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {

    }
    
}
```

2. OnBoarding
- In Decaf, AppStorage was used to manage the onboarding process by storing the user’s onboarding status. This ensures that the OnBoardingView is only displayed the first time the user opens the app. Once the user completes the onboarding by clicking a button, the app will remember this choice and skip the onboarding screen on subsequent launches. AppStorage provides a simple and effective way to persist this preference, offering a smoother user experience by preventing the onboarding view from repeatedly appearing each time the app is opened.

```swift
@main
struct DecaffeineApp: App {
    @AppStorage("isOnboarding") var isOnboarding : Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding == true {
                OnBoardingView()
            } else {
                ContentView()
                    .environmentObject(ShareDataViewModel())
            }
        }

    }
}

struct OnBoardingView: View {
    //MARK: - PROPERTIES
    @AppStorage("isOnboarding") var isOnboarding : Bool?
}

```
