//
//  PrivacyAgreementView.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/11.
//

import SwiftUI

struct PrivacyAgreementView: View {
  
  // MARK: - 属性
  
  @State var text: String = "欢迎您使用康佳智能家居应用软件服务。为使用康佳智能家居应用软件（以下简称\"本软件\"）及服务，您应当阅读并遵守《康佳智能家居用户使用协议》（以下简称\"本协议\"）。请您务必审慎阅读、充分理解各条款内容，特别是免除或者限制责任的条款，以及开通或使用某项服务的单独协议，并选择接受或不接受。限制、免责条款可能以加粗形式提示您注意。除非您已阅读 "
  
  @State var isChecked: Bool = false
  
  // MARK: - 测试边框颜色

  @State var borderColor = Color.clear
  
  // MARK: - 传入的回调闭包
  
  /// 同意按钮action
  var agreeClosure: () -> Void
  
  /// 退出按钮action
  var cancelClosure: () -> Void
  
  /// 用户协议及隐私跳转action
  var lisenceClosure: () -> Void
  
  var body: some View {
    VStack(spacing: 0) {
      /// 标题
      Text("使用说明")
        .foregroundColor(.init("TextColor1"))
        .font(.title2)
        .padding(.top, 23)
      
      /// 协议内容
      ZStack {
        TextEditor(text: $text)
          
          .foregroundColor(.init("TextColor3"))
          .padding(.top, 16)
          
        LinearGradient(gradient: Gradient(colors: [Color.white, Color.clear]), startPoint: .bottom, endPoint: .top)
          .frame(height: 24)
          .frame(maxHeight: .infinity, alignment: .bottom)
      }
      .frame(height: 176)
      .border(borderColor)
      
      /// 阅读同意
      ZStack {
        /// 请先勾选气泡图
        ZStack {
          Image("隐私协议_勾选提示_bg")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 86, height: 36)

          HStack(spacing: 0) {
            Image("隐私协议_ic_勾选提示")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 19, height: 19)

            Text("请先勾选")
              .foregroundColor(.init("BrandColor1"))
              .fixedSize()
              .font(.system(size: 14))
          }
        }
        .opacity(isChecked ? 0 : 1)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .offset(x: -8, y: -32)
        
        HStack {
          Button {
            withAnimation {
              isChecked.toggle()
            }
          } label: {
            Image(systemName: isChecked ? "checkmark.circle.fill" : "checkmark.circle").foregroundColor(isChecked ? .accentColor : .gray)
          }
          
          Text("已阅读并同意")
            .fixedSize()
          
          Button {
            lisenceClosure()
          } label: {
            Text("《用户协议及隐私政策》")
              .foregroundColor(.init("BrandColor1"))
              .fixedSize()
          }
        }
      }
      .padding(.top, 4)
      .border(borderColor)
      
      /// 同意按钮
      Button {
        agreeClosure()
      } label: {
        Text("同意").foregroundColor(.white)
          .frame(height: 44)
          .frame(maxWidth: .infinity)
          .background(Color("BrandColor1"))
          .clipShape(Capsule())
      }
      .disabled(!isChecked)
      .border(borderColor)
      .padding(.top, 16)
      
      /// 退出按钮
      Button {
        cancelClosure()
      } label: {
        Text("退出")
          .foregroundColor(.primary)
          .frame(height: 44)
          .frame(maxWidth: .infinity)
          .background(Color("BgColor4"))
          .clipShape(Capsule())
      }.border(borderColor)
        .padding(.top, 12)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .padding(.horizontal, 35)
    .background(Color.white)
    .cornerRadius(24)
    .ignoresSafeArea()
  }
}

struct PrivacyAgreementView_Previews: PreviewProvider {
  static var previews: some View {
    PrivacyAgreementView(agreeClosure: {}, cancelClosure: {}, lisenceClosure: {})
  }
}
