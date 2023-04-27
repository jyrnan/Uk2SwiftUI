//
//  PrivacyAgreementView.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/11.
//

import SwiftUI

struct PrivacyAgreementView: View {
  // MARK: - 属性
  
  @State var text: String = "欢迎您使用康佳智能家居应用软件服务。\n为使用康佳智能家居应用软件（以下简称\"本软件\"）及服务，您应当阅读并遵守《康佳智能家居用户使用协议》（以下简称\"本协议\"）。请您务必审慎阅读、充分理解各条款内容，特别是免除或者限制责任的条款，以及开通或使用某项服务的单独协议，并选择接受或不接受。限制、免责条款可能以加粗形式提示您注意。除非您已阅读 \n\n "
  
  @State var isChecked: Bool = false
  @State var showBubbleView: Bool = false
  
  // MARK: - 测试边框颜色

  @State var borderColor = Color.clear
  
  // MARK: - 传入的回调闭包
  
  /// 同意按钮action
  var agreeClosure: () -> Void
  
  /// 退出按钮action
  var cancelClosure: () -> Void
  
  /// 用户协议及隐私跳转action
  var lisenceClosure: () -> Void
  
  init(agreeClosure: @escaping () -> Void, cancelClosure: @escaping () -> Void, lisenceClosure: @escaping () -> Void) {
    self.agreeClosure = agreeClosure
    self.cancelClosure = cancelClosure
    self.lisenceClosure = lisenceClosure
    UITextView.appearance().backgroundColor = .red
  }
 
  var body: some View {
    VStack(spacing: 0) {
      /// 标题 OK
      Text("使用说明")
        .foregroundColor(.init("TextColor1"))
        .font(.custom("PingFangSC-Regular", size: 18))
        .padding(.top, 23)
        .border(borderColor)
      
      /// 协议内容
      ZStack {
        ScrollView {
          Text(text)
            .font(.custom("PingFangSC-Regular", size: 15))
            .fontWeight(.regular)
            .lineSpacing(3)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .foregroundColor(.init("TextColor3"))
            .padding(.trailing, 10)
            .border(borderColor)
        }
        .padding(.horizontal, 0)
        .onAppear {
          for family: String in UIFont.familyNames {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family) {
              print("== \(names)")
            }
          }
        }
        
        LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0.01)]), startPoint: .bottom, endPoint: .top)
          .frame(height: 24)
          .border(borderColor)
          .frame(maxHeight: .infinity, alignment: .bottom)
      }
      
      .frame(height: 176)
      .border(borderColor)
      .padding(.top, 16)
      .padding(.trailing, -9)
      
      /// 阅读同意
      ZStack(alignment: .top) {
        /// 请先勾选气泡图
        ZStack() {
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
          .offset(y: -3)
        }
        .opacity((!showBubbleView || isChecked) ? 0 : 1)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .offset(x: -9, y: -34)
        
        HStack(spacing: 0) {
          Button {
            withAnimation {
              isChecked.toggle()
            }
          } label: {
            Image(systemName: isChecked ? "checkmark.circle.fill" : "checkmark.circle")
              .foregroundColor(isChecked ? .accentColor : .gray)
          }
          
          Text("已阅读并同意: ")
            .foregroundColor(.init("TextColor1"))
            .font(.custom("PingFangSC-Regular", size: 15))
            .fixedSize()
            .padding(.leading, 7)
            
          Button {
            lisenceClosure()
          } label: {
            Text("《用户协议及隐私政策》")
              .font(.custom("PingFangSC-Regular", size: 15))
              .foregroundColor(.init("BrandColor1"))
              .lineLimit(1)
//              .fixedSize()
              .frame(maxWidth: .infinity, alignment: .leading)
          }
        }
        .border(borderColor)
      }
      .border(borderColor)
      .padding(.top, 4)
      .padding(.trailing, -5) //增加一点空间提供给文字防止空间不够折叠内容
      
      /// 同意按钮
      ZStack {
        Button {
          agreeClosure()
        } label: {
          Text("同意")
            .foregroundColor(.white)
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(Color("BrandColor1"))
            .clipShape(Capsule())
        }
        .disabled(!isChecked)
        .border(borderColor)
        .padding(.top, 2) // 这里因为上一个ZStackView下部有约14的空间，所以只偏移2，实际效果是16
        .padding(.horizontal, 4)
        
        /// 上层用来触摸显示气泡视图
        Text("同意")
          .foregroundColor(.white)
          .frame(height: 44)
          .frame(maxWidth: .infinity)
          .background(Color("BrandColor1"))
          .clipShape(Capsule())
          .padding(.top, 2) // 这里因为上一个ZStackView下部有约14的空间，所以只偏移2，实际效果是16
          .padding(.horizontal, 4)
          .opacity(showBubbleView ? 0 : 1)
          .onTapGesture {
            withAnimation {
              showBubbleView = true
            }
          }
      }
      
      /// 退出按钮
      Button {
        cancelClosure()
      } label: {
        Text("退出")
          .foregroundColor(.init("TextColor1"))
          .frame(height: 44)
          .frame(maxWidth: .infinity)
          .background(Color("BgColor4"))
          .clipShape(Capsule())
      }.border(borderColor)
        .padding(.top, 12)
        .padding(.horizontal, 4)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .padding(.horizontal, 35)
    .background(Color.white)
    .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
    .ignoresSafeArea()
  }
}

struct PrivacyAgreementView_Previews: PreviewProvider {
  static var previews: some View {
    PrivacyAgreementView(agreeClosure: {}, cancelClosure: {}, lisenceClosure: {})
  }
}

/// 实现自定义圆角的形状，可以用来做View的裁切
struct CustomCorner: Shape {
  var corners: UIRectCorner
  var radius: CGFloat
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    
    return Path(path.cgPath)
  }
}
