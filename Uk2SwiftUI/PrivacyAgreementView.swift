//
//  PrivacyAgreementView.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/11.
//

import SwiftUI

struct PrivacyAgreementView: View {
  // MARK: - 属性
  
  @State var text: String = "欢迎您使用康佳智能家居应用软件服务。\n深圳康佳电子科技有限公司（以下称“我们”或“公司”）深知个人信息安全的重要性，我们将按照法律法规的规定，采用安全保护措施，保护您的个人信息及隐私安全。因此我们制定本《隐私政策》并提醒您：在使用“易投屏”产品及相关服务前，请务必仔细阅读并透彻理解本《隐私政策》，在确认充分理解并同意后方使用“易投屏”产品和服务。如一旦您开始使用“易投屏”产品及其相关服务，则视为您对本隐私政策内容的接受和认可。 我们非常重视用户个人信息的保护，并且将以高度勤勉和审慎的义务对待这些信息。您在通过计算机设备、移动设备或其他设备下载、安装、开启、浏览、登录、使用（以下统称为“使用”）“易投屏”产品及使用相关服务时，我们将按照本隐私政策收集、保存、使用、共享、披露及保护您的信息。我们希望通过本《隐私政策》向您介绍我们对您的信息的处理方式，因此我们再次建议您完整地阅读本《隐私政策》。 如果您不同意本《隐私政策》的内容，将导致“易投屏”产品无法正常运行，我们将无法为您提供服务，同时请您立即停止使用“易投屏”产品及其相关服务。当您使用“易投屏”产品及其相关服务时，则表示您同意且完全理解本《隐私政策》的全部内容。在我们更新本《隐私政策》后（我们会及时在“易投屏”产品平台发布最新版本），您继续使用“易投屏”产品及其相关服务，即意味着您同意本《隐私政策》（含更新版本）内容，并同意我们按照本《隐私政策》收集、保存、使用、共享、披露及保护您的相关信息。 本隐私政策涉及的个人信息是指以电子或者其他方式记录的能够单独或者与其他信息结合识别特定自然人身份或者反映特定自然人活动情况的各种信息，包括您注册“易投屏”帐号时向我们提供的手机号码；您使用产品特定服务时（如支付、购买会员、创建共享、智能推荐等），为满足向您提供产品及相关服务之目的，除注册时提供的信息外，您可能还需要进一步向我们提供您的真实姓名、身份证号码、个人通讯录等信息，您有权拒绝向我们提供这些信息，或者撤回您对这些信息的授权同意。请您了解，拒绝或撤回授权同意，将导致您无法使用相关的特定功能，但不影响您使用“易投屏”的其他功能；我们还可能会记录您在使用我们的产品及其相关服务时提供、形成或留存的信息例如您存储的信息，您的个人常用设备信息（包括硬件型号、设备MAC地址、操作系统类型、软件列表唯一设备识别码，如IMEI/android ID/IDFA/OPENUDID/GUID、SIM卡IMSI卡信息等在内的描述个人常用终端设备基本情况的信息）等。\n\n "
  
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
  var licenseClosure: () -> Void
  
  init(agreeClosure: @escaping () -> Void, cancelClosure: @escaping () -> Void, licenseClosure: @escaping () -> Void) {
    self.agreeClosure = agreeClosure
    self.cancelClosure = cancelClosure
    self.licenseClosure = licenseClosure
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
            Image(isChecked ? "circle_select_YES" : "circle_select_NO")
              .foregroundColor(isChecked ? .accentColor : .gray)
          }
          
          Text("已阅读并同意: ")
            .foregroundColor(.init("TextColor1"))
            .font(.custom("PingFangSC-Regular", size: 15))
            .fixedSize()
            .padding(.leading, 7)
            
          Button {
            licenseClosure()
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
    PrivacyAgreementView(agreeClosure: {}, cancelClosure: {}, licenseClosure: {})
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
