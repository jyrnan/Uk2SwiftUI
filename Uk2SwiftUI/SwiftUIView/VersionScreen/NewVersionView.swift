//
//  NewVersionView.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/18.
//

import SwiftUI

struct TextHeightKey: PreferenceKey {
  static var defaultValue: CGFloat = 0
  
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = value + nextValue()
  }
}

struct NewVersionView: View {
  @ObservedObject var vm: VersionCheckViewModel
  @Environment(\.openURL) private var openURL // 引入环境值
  
  @State var textHeight: CGFloat = 0
  
  ///依据文字高度来设置外部ScrollView的高度
  ///最低不低于44
  ///最高不超过110，大约显示5行
  var scrollViewHeight: CGFloat {
    if textHeight < 44 { return 44 }
    if textHeight > 110 { return 110 }
    return textHeight
  }

  @Binding var newVersionViewHeight: CGFloat
  
  @State var borderColor: Color = .clear
  
  var text: String {
    guard let text = vm.newVersionInfo?.releaseNotes else {
      return "Bug fixed"
    }
    return text
  }

  var body: some View {
    ZStack(alignment: .top) {
      Rectangle()
        .foregroundColor(.white)
        .ignoresSafeArea()
        
      VStack(spacing: 0) {
        Image("searchNewVersion")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 89, height: 89)
          .padding(.top, 33)
          
        Text("发现新版本")
          .font(.custom("PingFangSC-Regular", size: 18))
          .fontWeight(.semibold)
          .foregroundColor(.init("TextColor1"))
          .padding(.top, 6)
          
        Text("V" + (vm.newVersionInfo?.version ?? "1.0.0"))
          .font(.custom("PingFangSC-Regular", size: 14))
          .foregroundColor(.init("TextColor1"))
          .padding(.top, 1)
          
        ScrollView(showsIndicators: false) {
          Text(text)
            .font(.custom("PingFangSC-Regular", size: 16))
            .foregroundColor(.init("TextColor2"))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(GeometryReader {
              Color.clear
                .preference(key: TextHeightKey.self,
                            value: $0.frame(in: .local).size.height)
            })
        }
        .frame(height: scrollViewHeight)
        .onPreferenceChange(TextHeightKey.self) {
          textHeight = $0
          ///整个窗口的高度是ScrollView的高度加上上部空间188和下部空间108
          ///这个高度会返回到上层View来决定偏移动画数值
          newVersionViewHeight = 188 + scrollViewHeight + 108
        }
        .border(borderColor)
        .padding(.horizontal, 12) // 文字在VStack锁进基础上再缩进12
        .padding(.top, 14)
        

        // MARK: - 底部按钮
          
        HStack(spacing: 11) {
          if !vm.isForceUpdateVersion {
            Button {
              vm.showNewVersionView = false
            } label: {
              Text("暂不处理")
                .font(.system(size: 16))
                .foregroundColor(.init("TextColor1"))
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(Color("BgColor4"))
                .clipShape(Capsule())
            }
          }
            
          Button {
            if let url = URL(string: "https://apps.apple.com/us/app/%E6%98%93%E4%BA%92%E5%8A%A8/id1523021399") {
              openURL(url) { accepted in //  通过设置 completion 闭包，可以检查是否已完成 URL 的开启。状态由 OpenURLAction 提供
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
    .frame(height: newVersionViewHeight)
    .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
    .border(borderColor)
  }
}

struct NewVersionView_Previews: PreviewProvider {
  static var previews: some View {
    NewVersionView(vm: VersionCheckViewModel(), newVersionViewHeight: .constant(370))
  }
}


