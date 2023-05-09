//
//  PersonalCenterQuestionsView.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/13.
//

import SwiftUI

/// 修改NavigationTitle底色的modifier，来自现成代码
struct NavigationBarModifier: ViewModifier {
  var backgroundColor: UIColor?
  var titleColor: UIColor?

  init(backgroundColor: Color, titleColor: UIColor?) {
    self.backgroundColor = UIColor(backgroundColor)

    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithTransparentBackground()
    coloredAppearance.backgroundColor = .clear // The key is here. Change the actual bar to clear.
    coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
    coloredAppearance.shadowColor = .clear

    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    UINavigationBar.appearance().tintColor = titleColor

    print(#line, #function, "NavigationBar changed")
  }

  func body(content: Content) -> some View {
    ZStack {
      content
      VStack {
        GeometryReader { geometry in
          Color(self.backgroundColor ?? .clear)
            .frame(height: geometry.safeAreaInsets.top)
            .edgesIgnoringSafeArea(.top)
          Spacer()
        }
      }
    }
  }
}

extension View {
  func navigationBarColor(backgroundColor: Color, titleColor: UIColor?) -> some View {
    self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
  }
}

struct PersonalCenterQuestionsView: View {
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        ForEach(qATexts) { qaText in
          CellView(qaText: qaText)
            .border(.clear)
        }
      }
    }
    .background(Color("BgColor1")
      .ignoresSafeArea(edges: .bottom)) // 影响到NavigationBar背景色，没有覆盖上部安全区域，会露出底部View的本色，从而NavigationBar部分会显示显示出来。
    .navigationTitle("常见问题")
    .navigationBarTitleDisplayMode(.inline)
    /// 从目前效果来看，其实并不需要这个modifier
    /// 该modifier的作用是在NavigationBar区域创建一个新的视图来填充NavigationBar区域
    /// 从而挡住底层的View背景
    /// 实现充当NavigationBar的背景
//    .navigationBarColor(backgroundColor: .red, titleColor: .blue) //
  }
}

struct PersonalCenterView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      PersonalCenterQuestionsView()
        .navigationTitle("常见问题")
        .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct CellView: View {
  var qaText: QAText
  @State var showContent: Bool = false
  @State var isHover: Bool = false

  @State var borderClor: Color = .clear

  var body: some View {
    VStack(spacing: 0) {
      HStack(spacing: 0) {
        Button {
          withAnimation { showContent.toggle() }
        } label: {
          Text(qaText.question)
            .font(.custom("PingFangSC-Regular", size: 16))
            .foregroundColor(.init("TextColor1"))
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .padding(.trailing, 16)
        }
        .buttonStyle(ScrollViewGestureButtonStyle(pressAction: {
          withAnimation {
            isHover.toggle()
          }
        }))

        Image("10个人中心_ic_Arrow")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 18, height: 18)
          .rotationEffect(.degrees(showContent ? 270 : 90))
      }
      .padding(.horizontal, 18)
      .padding(.top, 20)
      .padding(.bottom, showContent ? 12 : 20) // 展开和收起时候距离下边沿的高度不同

      if showContent {
        VStack(alignment: .leading, spacing: 0) {
          Divider()
            .foregroundColor(.init("LineColor1"))
            .padding(.horizontal, 0)

          Text(qaText.answer)
            .foregroundColor(.init("TextColor3"))
            .font(.custom("PingFangSC-Regular", size: 14))
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 8)
            .padding(.leading, 18)
            .padding(.trailing, 30)
            .padding(.bottom, 20)
        }
        .transition(.asymmetric(insertion: .opacity.animation(.default.delay(0.3)), removal: .opacity))
      }
    }
    .frame(maxWidth: .infinity)
    .background(
      RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
        .fill(isHover ? .init("BgColor3") : Color.white)
    )
    .padding(.horizontal, 16)
    .padding(.top, 10)
  }
}

/// 解决按钮悬停状态下的底色问题
/// 其实就是按下适合执行action
struct ScrollViewGestureButtonStyle: ButtonStyle {
  init(
    pressAction: @escaping () -> Void
  ) {
    self.pressAction = pressAction
  }

  private var pressAction: () -> Void

  func makeBody(configuration: Configuration) -> some View {
    // Insert magic here
    configuration.label
      .onChange(of: configuration.isPressed) { _ in
        pressAction()
      }
  }
}

struct QAText: Identifiable {
  var id: UUID = .init()
  var question: String
  var answer: String
}

extension PersonalCenterQuestionsView {
  var qATexts: [QAText] {
    [
      .init(question: "如何连接设备？",
            answer: "将手机与设备连接同一个WiFi/局域网；点击上方的【连接设备】，即可搜索同一WiFi下的设备，点击具体设备即可连接"),

      .init(question: "如何检查手机与设备的网络连接是否正常？",
            answer: "（1）检查手机与设备的IP地址前三部分，若相同，则说明已在同一局域网下（如：192.168.1.xxx），若不同，请重新连接同一网络，或者检查网络设置。\n（2）在【遥控】界面，点击下方侧边按钮，可切换“遥控模式”、“鼠标模式”，还可以切换控制面板的位置。"),

      .init(question: "如何操控设备？",
            answer: "（1）连接设备成功后，点击下方的【遥控】按钮，即可进行设备操控。\n（2）在【遥控】界面，点击下方侧边按钮，可切换“遥控模式”、“鼠标模式”，还可以切换控制面板的位置。"),

      .init(question: "如何将设备画面投屏到手机上？",
            answer: "手机连接设备成功后，点击【传屏到手机】功能，即可将设备画面传屏到手机上，并在手机上进行设备操控。"),

      .init(question: "使用【镜像投屏】时，设备怎么没声音？",
            answer: "（1）Android 10及以上开启录音权限即可录制手机系统声音\n（2）Android 10以下，由于大部分手机系统权限限制，导致在手机镜像时，不支持手机声音在设备上播放。"),

      .init(question: "投屏时黑屏是为什么？",
            answer: "部分内容因版权保护，不支持投屏"),
    ]
  }
}
