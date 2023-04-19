//
//  NewVersionView.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/18.
//

import SwiftUI

struct NewVersionView: View {
  @ObservedObject var vm: VersionCheckViewModel
  @Environment(\.openURL) private var openURL // 引入环境值

  /// <#Description#>
    var body: some View {
      ZStack(alignment: .top) {
      
        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
          .foregroundColor(.white)
          .ignoresSafeArea()
        
        VStack(spacing: 0) {
          Image("10个人中心_ic_发现新版本")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 89, height: 89)
            .padding(.top, 33)
          
          Text("发现新版本")
            .font(.system(size: 18))
            .foregroundColor(.init("TextColor1"))
            .padding(.top, 6)
          
          Text(vm.newVersionInfo?.version ?? "1.0.0")
            .font(.system(size: 14))
            .foregroundColor(.init("TextColor1"))
            .padding(.top, 1)
          
          ScrollView(showsIndicators: false) {
            Text(vm.newVersionInfo?.releaseNotes ?? "Bug fixed")
              .font(.system(size: 16))
              .foregroundColor(.init("TextColor2"))
              .padding(.horizontal, 12) // 文字在VStack锁进基础上再缩进12
            .frame(maxWidth: .infinity, alignment: .leading)
          }
          .padding(.top, 14)
          //MARK: - 底部按钮
          
          HStack(spacing: 11){
            
            Button {
              vm.showNewVersionView = false
            } label: {
              Text("取消")
                .font(.system(size: 16))
                .foregroundColor(.init("TextColor1"))
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(Color("BgColor4"))
                .clipShape(Capsule())
            }
            
            Button {
              if let url = URL(string: "https://apps.apple.com/us/app/%E6%98%93%E4%BA%92%E5%8A%A8/id547912909") {
                            openURL(url) { accepted in  //  通过设置 completion 闭包，可以检查是否已完成 URL 的开启。状态由 OpenURLAction 提供
                              print(accepted ? "Success" : "Failure")
                            }
                          }
            } label: {
              Text("立即更新")
                .font(.system(size: 16))
                .foregroundColor(.white)
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(Color("BrandColor1"))
                .clipShape(Capsule())
            }
          }
          .padding(.top, 36)
          .padding(.bottom, 36)
        }
        .padding(.horizontal, 30)
      }
    }
}

struct NewVersionView_Previews: PreviewProvider {
    static var previews: some View {
      NewVersionView(vm: VersionCheckViewModel())
        
    }
}

