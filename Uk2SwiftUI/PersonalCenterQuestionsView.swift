//
//  PersonalCenterQuestionsView.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/13.
//

import SwiftUI

struct PersonalCenterQuestionsView: View {
  
  var body: some View {
    ScrollView {
      VStack (spacing: 0){
        ForEach(qATexts) { qaText in
          CellView(qaText: qaText)
            .border(.clear)
        }
      }
    }
    .navigationTitle("常见问题")
      .navigationBarTitleDisplayMode(.inline)
      .background(Color("BgColor1").ignoresSafeArea(edges: .bottom))
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
  @GestureState var press: Bool = false
  @State var isHover: Bool = false
  var body: some View {
    VStack {
      HStack {

        Button {
          withAnimation{showContent.toggle()}
        } label: {
          Text(qaText.question)
            .font(.body)
            .foregroundColor(.init("TextColor1"))
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
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

      if showContent {
        VStack(alignment: .leading) {
          Divider().padding(.horizontal, 0)

          Text(qaText.answer)
            .foregroundColor(.init("TextColor3"))
            .font(.callout)
        }
        .transition(.asymmetric(insertion: .opacity.animation(.default.delay(0.3)), removal: .opacity))
      }
    }
    .padding()
    .frame(maxWidth: .infinity)
    .background(
      RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
        .fill(isHover ? .init("BgColor3") : Color.white)
      .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 8))
    .padding(.horizontal)
    .padding(.top, 10)
  }
}


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
        .onChange(of: configuration.isPressed) { newValue in
          pressAction()
        }
    }
}

struct QAText: Identifiable {
  var id:UUID = UUID()
  var question: String
  var answer: String
}

extension PersonalCenterQuestionsView {
  var qATexts: [QAText] {
    [
      .init(question: "如何连接设备？",
            answer: "将手机与设备连接同一个WiFi/局域网；点击上方的【连接设备】，即可搜索同一WiFi下的设备，点击具体设备即可连接"),
      
        .init(question: "如何检查手机与设备的网络连接是否正常？",
            answer: "（1）检查手机与设备的IP地址前三部分，若相同，则说明已在同一局域网下（如：192.168.1.xxx），若不同，请重新连接同一网络，或者检查网络设置。\n\n（2）在【遥控】界面，点击下方侧边按钮，可切换“遥控模式”、“鼠标模式”，还可以切换控制面板的位置。"),
      
        .init(question: "如何操控设备？",
            answer: "（1）连接设备成功后，点击下方的【遥控】按钮，即可进行设备操控。\n\n（2）在【遥控】界面，点击下方侧边按钮，可切换“遥控模式”、“鼠标模式”，还可以切换控制面板的位置。"),
      
        .init(question: "如何将设备画面投屏到手机上？",
            answer: "手机连接设备成功后，点击【传屏到手机】功能，即可将设备画面传屏到手机上，并在手机上进行设备操控。"),
      
        .init(question: "使用【镜像投屏】时，设备怎么没声音？",
            answer: "（1）Android 10及以上开启录音权限即可录制手机系统声音\n\n（2）Android 10以下，由于大部分手机系统权限限制，导致在手机镜像时，不支持手机声音在设备上播放。"),
      
        .init(question: "投屏时黑屏是为什么？",
            answer: "部分内容因版权保护，不支持投屏"),
    ]
  }
  
}

