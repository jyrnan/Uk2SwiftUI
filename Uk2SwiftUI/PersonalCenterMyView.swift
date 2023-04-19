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
  
  var body: some View {
    ZStack {
      Image("Bg_主页背景")
        .resizable()
        .ignoresSafeArea()
      ScrollView {
        VStack(spacing: 10) {
          /// 常见问题
//          Button {
//            toQuestionView()
//          } label: {
//            HStack {
//              Image("10个人中心_ic_常见问题")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 30, height: 30)
//              Text("常见问题")
//                .font(.system(size: 20))
//                .foregroundColor(.init("TextColor1"))
//                .frame(maxWidth: .infinity, alignment: .leading)
//              Image("10个人中心_ic_Arrow")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 18, height: 18)
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .frame(height: 60)
//            .background(
//              RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
//                .fill(Color.white)
//                .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 8))
//            .padding(.horizontal)
//          }
            
          /// 关于
//          Button {
////            toAboutView()
//
//          } label: {
//            HStack {
//              Image("10个人中心_ic_关于")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 30, height: 30)
//              Text("关于")
//                .font(.system(size: 20))
//                .foregroundColor(.init("TextColor1"))
//                .frame(maxWidth: .infinity, alignment: .leading)
//              Image("10个人中心_ic_Arrow")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 18, height: 18)
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .frame(height: 60)
//            .background(
//              RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
//                .fill(Color.white)
//                .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 8))
//            .padding(.horizontal)
//          }
          
          NavigationLink {
            PersonalCenterQuestionsView()
          } label: {
            HStack {
              Image("10个人中心_ic_常见问题")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
              Text("常见问题")
                .font(.system(size: 20))
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
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 8))
            .padding(.horizontal)
          }
          
          NavigationLink {
            VersionContainerView()
          } label: {
           
              HStack {
                Image("10个人中心_ic_关于")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 30, height: 30)
                Text("关于")
                  .font(.system(size: 20))
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
                  .fill(Color.white)
                  .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 8))
              .padding(.horizontal)
            
          }


        }.padding(.top, 14)
      }
    }
  }
}

struct PersonalCenterMyView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      PersonalCenterMyView(toQuestionView: {}, toAboutView: {})
    }
  }
}

extension PersonalCenterMyView {
  func customNavigationBar() {}
}
