//
//  ThirdView.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import SwiftUI

//public struct ScrollableView<Content: View>: UIViewControllerRepresentable {
//   @Binding var offset: CGPoint
//
//   var content: () -> Content
//
//   public init(_ offset: Binding<CGPoint>, @ViewBuilder content: @escaping () -> Content) {
//       self._offset = offset
//       self.content = content
//   }
//
//   public func makeUIViewController(context: Context) -> UIScrollViewViewController {
//       let vc = UIScrollViewViewController()
//       vc.hostingController.rootView = AnyView(self.content())
//       vc.scrollView.setContentOffset(offset, animated: false)
//       vc.delegate = context.coordinator
//       return vc
//   }
//
//
//   public func updateUIViewController(_ viewController: UIScrollViewViewController, context: Context) {
//       viewController.hostingController.rootView = AnyView(self.content())
//
//       // Allow for deaceleration to be done by the scrollView
//       if !viewController.scrollView.isDecelerating {
//           viewController.scrollView.setContentOffset(offset, animated: false)
//       }
//   }
//
//   public func makeCoordinator() -> Coordinator {
//       Coordinator(contentOffset: _offset)
//   }
//
//   public class Coordinator: NSObject, UIScrollViewDelegate {
//       let contentOffset: Binding<CGPoint>
//
//       init(contentOffset: Binding<CGPoint>) {
//           self.contentOffset = contentOffset
//       }
//
//       public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//           contentOffset.wrappedValue = scrollView.contentOffset
//       }
//   }
//}
//
//
//public class UIScrollViewViewController: UIViewController {
//   lazy var scrollView: UIScrollView = UIScrollView()
//
//   var hostingController: UIHostingController<AnyView> = UIHostingController(rootView: AnyView(EmptyView()))
//
//   weak var delegate: UIScrollViewDelegate?
//
//   public override func viewDidLoad() {
//       super.viewDidLoad()
//       self.scrollView.delegate = delegate
//       self.view.addSubview(self.scrollView)
//       self.pinEdges(of: self.scrollView, to: self.view)
//       self.hostingController.willMove(toParent: self)
//       self.scrollView.addSubview(self.hostingController.view)
//       self.pinEdges(of: self.hostingController.view, to: self.scrollView)
//       self.hostingController.didMove(toParent: self)
//   }
//
//   func pinEdges(of viewA: UIView, to viewB: UIView) {
//       viewA.translatesAutoresizingMaskIntoConstraints = false
//       viewB.addConstraints([
//           viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor),
//           viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor),
//           viewA.topAnchor.constraint(equalTo: viewB.topAnchor),
//           viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor),
//       ])
//   }
//}



struct ThirdView: View {
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(1..<21) { index in
                            Text("Left \(index)")
                                .frame(width: 50, height: 50)
                                .background(Color.blue)
                        }
                    }
                    .padding()
                    .frame(width: geometry.size.width)
                    .offset(x: scrollOffset)
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                        .onChanged({value in
                            scrollOffset += value.translation.width / 5
                            print(scrollOffset)}
                                  )
                            .onEnded({value in
                                scrollOffset = min(scrollOffset, 0)
                            })
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                Spacer()
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(1..<21) { index in
                            Text("Right \(index)")
                                .frame(width: 50, height: 50)
                                .background(Color.green)
                        }
                    }
                    .padding()
                    .frame(width: geometry.size.width)
                    .offset(x: scrollOffset)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}
