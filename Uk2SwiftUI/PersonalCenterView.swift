//
//  PersonalCenterView.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/13.
//

import SwiftUI

struct PersonalCenterView: View {
  var body: some View {
    ScrollView {
      VStack (spacing: 0){
        ForEach(1..<10) { _ in
          CellView()
            .border(.clear)
        }
      }
    }
    .background(Color("BgColor1"))
  }
}

struct PersonalCenterView_Previews: PreviewProvider {
  static var previews: some View {
    PersonalCenterView()
  }
}

struct CellView: View {
  @State var showContent: Bool = false
  @GestureState var press: Bool = false
  @State var isHover: Bool = false
  var body: some View {
    VStack {
      HStack {

        Button {
          withAnimation{showContent.toggle()}
        } label: {
            Text("多屏互动、多屏助手、易互动、电视遥控是什么?")
            .font(.body)
            .foregroundColor(.primary)
            .multilineTextAlignment(.leading)
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
        VStack {
          Divider().padding(.horizontal, 0)

          Text("1. 易互动(原多屏互动)为康佳电视定制版本，电视控则适用于所有智能电视/盒子。 2. 简单来说: 多屏互动一升级为一易互动 多屏助手一独立为一电视控!")
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
