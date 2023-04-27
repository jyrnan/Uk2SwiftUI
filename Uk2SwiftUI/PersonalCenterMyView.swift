//
//  PersonalCenterMyView.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/13.
//

import SwiftUI

struct BackButton: View {
  @Environment(\.presentationMode) var presentationMode
  var body: some View {
    Button(action: {
    self.presentationMode.wrappedValue.dismiss()
  }) {
    HStack {
      Image(systemName: "chevron.backward") // set image here
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.init("TextColor1"))
    }
  }
  }
}

struct PersonalCenterMyView: View {
  
  var toQuestionView: () -> Void
  var toAboutView: () -> Void
  
  @State var selection: Int? = nil
  
  @State var isHoverQuestionButton: Bool = false
  @State var isHoverAboutButton: Bool = false
  
  var body: some View {
    ZStack {
      Image("Main_backGroundImg")
        .resizable()
        .ignoresSafeArea()
      
      Color.white
        .opacity(0.5)
        .ignoresSafeArea()
      
      ScrollView {
        VStack(spacing: 10) {
 
          Button{
            selection = 1
          } label: {
            HStack {
              Image("10个人中心_ic_常见问题")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
              Text("常见问题")
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
                .fill(isHoverQuestionButton ? .init("BgColor3")  : Color.white)
                .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 8))
            .padding(.horizontal)
          }.buttonStyle(ScrollViewGestureButtonStyle(pressAction: {
            withAnimation {
              isHoverQuestionButton.toggle()
            }
          }))
          
          Button{
            selection = 2
          } label: {
            HStack {
              Image("10个人中心_ic_关于")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
              Text("关于")
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
          }.buttonStyle(ScrollViewGestureButtonStyle(pressAction: {
            withAnimation {
              isHoverAboutButton.toggle()
            }
          }))
          
          NavigationLink(destination: PersonalCenterQuestionsView(), tag: 1, selection: $selection, label: {
            EmptyView()
          })
          
          NavigationLink(destination: VersionContainerView(), tag: 2, selection: $selection, label: {
            EmptyView().border(.red)
          })
         
        }.padding(.top, 14)
      }
    }
    .navigationBarBackButtonHidden()
  }
  
}

struct PersonalCenterMyView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      PersonalCenterMyView(toQuestionView: {}, toAboutView: {})
    }
  }
}

