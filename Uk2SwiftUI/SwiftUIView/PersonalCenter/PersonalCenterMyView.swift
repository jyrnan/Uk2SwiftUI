//
//  PersonalCenterMyView.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/13.
//

import SwiftUI

struct PersonalCenterMyView: View {
  
  /// 用于决定Navigation目标视图
  @State var selection: Int? = nil

  var body: some View {
    ZStack(alignment: .top) {
      Image("Main_backGroundImg")
        .resizable()
        .ignoresSafeArea() // 影响到NavigationBar背景色，因为背景会覆盖最底层View的颜色，从而NavigationBar部分就不显示
      
      Color.white
        .opacity(0.5)
        .ignoresSafeArea()
      
        VStack(spacing: 10) {

          HoverButton(image: "10个人中心_ic_常见问题", text: "常见问题") {
            selection = 1
          }
          
          HoverButton(image: "10个人中心_ic_关于", text: "关于") {
            selection = 2
          }
          
          NavigationLink(destination: PersonalCenterQuestionsView(), tag: 1, selection: $selection, label: {
            EmptyView()
          })
          
          NavigationLink(destination: VersionContainerView(), tag: 2, selection: $selection, label: {
            EmptyView().border(.red)
          })
         
        }
        .padding(.top, 14)
    }
//    .navigationBarBackButtonHidden()
    .navigationTitle("我的")
    .navigationBarTitleDisplayMode(.inline)
  }
  
}

struct PersonalCenterMyView_Previews: PreviewProvider {
  static var previews: some View {
//    NavigationView {
      PersonalCenterMyView()
//    }
  }
}


/// 适应于个人中心的具有Hover效果的长条形按钮
struct HoverButton: View {
  @State var isHoverAboutButton: Bool = false
  var image: String
  var text: String
  var action: () -> Void
  
  init(image: String, text: String, action: @escaping () -> Void) {
    self.image = image
    self.text = text
    self.action = action
  }
  
  var body: some View {
    Button {
      action()
    } label: {
      HStack {
        Image(image)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 30, height: 30)
        Text(text)
          .font(.system(size: 16))
          .foregroundColor(.init("TextColor1"))
          .frame(maxWidth: .infinity, alignment: .leading)
        Image("10个人中心_ic_Arrow")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 18, height: 18)
      }
      .padding()
      .frame(maxWidth: .infinity)
      .frame(height: 60)
      .background(
        RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
          .fill(isHoverAboutButton ? .init("BgColor3")  : Color.white)
          .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 8))
      .padding(.horizontal)
    }
    .buttonStyle(ScrollViewGestureButtonStyle(pressAction: {
      withAnimation {
        isHoverAboutButton.toggle()
      }
    }))
  }
  
  
}
