//
//  AboutView.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/18.
//

import SwiftUI

struct AboutView: View {
  @ObservedObject var vm: VersionCheckViewModel
  @Environment(\.openURL) private var openURL // 引入环境值
  
  @State var showWeb: Bool = false
  @State var url: String?
  
  var hasNewVersion: Bool { vm.newVersionInfo != nil }
  
  
  var body: some View {
    VStack(spacing: 0) {
      VStack(spacing: 0) {
        Image("ios图标切图_70＊70")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 70, height: 70)
          
        Image("易投屏")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 64, height: 22)
          .padding(.vertical, 1)
          .padding(.horizontal, 4)
          .padding(.top, 10)
          
        Text("版本V" + vm.currentVersion)
          .font(.system(size: 14))
          .foregroundColor(.init("TextColor2"))
          .padding(.top, 1)
      }
      .padding(.top, 55)
    
      /// 版本更新
      Button {
        if hasNewVersion {
          vm.showNewVersionView = true
        } else {
          vm.checkNewVersion()
        }
      } label: {
        HStack(spacing: 0) {
          Text("版本更新")
            .font(.system(size: 16))
            .foregroundColor(.init("TextColor1"))
            .frame(maxWidth: .infinity, alignment: .leading)
          
          if hasNewVersion {
            HStack {
              Circle()
                .fill(.red)
                .frame(width: 7, height: 7)
              
              Text("发现新版本")
                .font(.system(size: 16))
                .foregroundColor(.init("TextColor3"))
            
              Image("10个人中心_ic_Arrow")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 18, height: 18)
            }
          } else {
            Text(vm.isCheckingVersion ? "检查中..." : "已是最新版本")
              .font(.system(size: 16))
              .foregroundColor(.init("TextColor3"))
          }
        }
        .padding(.vertical, 19)
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
        .background(
          RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
            .fill(Color.white))
        .padding(.horizontal)
      }
      .padding(.top, 46)
        
      /// 底部按钮
      VStack(spacing: 0) {
        HStack(spacing: 0) {
          Button {
            url = "https://www.konka.com"
          } label: {
            Text("官方网站")
              .font(.system(size: 12))
              .foregroundColor(.init("BrandColor1"))
              .fixedSize()
              .padding(.trailing, 13)
              .frame(maxWidth: .infinity, alignment: .trailing)
          }
            
          Divider()
            .frame(height: 15)
            
          Button {
            url = "https://www.apple.com"
          } label: {
            Text("隐私协议")
              .font(.system(size: 12))
              .foregroundColor(.init("BrandColor1"))
              .fixedSize()
              .padding(.leading, 13)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
        }
          
        Text("康佳电子科技有限公司  版权所有")
          .font(.system(size: 12))
          .padding(.top, 6)
          .foregroundColor(.init("TextColor4"))
            
        Text("Rights Reserved")
          .font(.system(size: 12))
          .padding(.top, 5)
          .foregroundColor(.init("TextColor4"))
      }
      .font(.system(size: 15))
      .padding(.bottom, 49)
      .frame(maxHeight: .infinity, alignment: .bottom)
    }
    .navigationTitle("关于")
    .navigationBarTitleDisplayMode(.inline)
    .fullScreenCover(item: $url, content: { url in
      if let url = URL(string: url) {
        SafariView(url: url)
          .ignoresSafeArea()
      }
      
    })
    .background(Color("BgColor1")).ignoresSafeArea(edges: [.bottom])
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      AboutView(vm: VersionCheckViewModel())
    }
  }
}

extension String: Identifiable {
  public var id: String {
    self
  }
}
