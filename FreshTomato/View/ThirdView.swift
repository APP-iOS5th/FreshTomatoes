//
//  ThirdView.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import SwiftUI
//import SwiftUI
//
//struct ThirdView: View {
//    @StateObject var vm: ThirdViewModel = ThirdViewModel()
//    @State private var searchText = ""
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("검색", text: $searchText, onCommit: {
//                    vm.fetchSearchResults(query: searchText)
//                })
//                .padding(7)
//                .background(Color(.systemGray6))
//                .cornerRadius(10)
//                .padding(.horizontal, 10)
//
//                if vm.searchMovies.isEmpty {
//                    if searchText.isEmpty {
//                        Spacer()
//                        Text("영화를 검색해주세요.")
//                            .foregroundColor(.gray)
//                            .font(.headline)
//                        Spacer()
//                    } else {
//                        Spacer()
//                        Text("검색 결과가 없습니다.")
//                            .foregroundColor(.gray)
//                            .font(.headline)
//                        Spacer()
//                    }
//                } else {
//                    GeometryReader { geometry in
//                        ViewAllCardView(movies: vm.searchMovies, imageWidth: geometry.size.width * 0.27, imageHeight: geometry.size.height * 0.21, detailViewWidth: geometry.size.width, detailViewHeight: geometry.size.height * 0.4)
//                    }
//                }
//
//                Spacer()
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationTitle("영화 검색")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        // 이 버튼에 뒤로 가기 기능 구현
//                    }) {
//                        Image(systemName: "arrow.backward")
//                    }
//                }
//            }
//        }
//    }
//}

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
    @StateObject var vm: ThirdViewModel = ThirdViewModel()
    @State private var searchText = ""

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack {
                    TextField("검색", text: $searchText, onCommit: {
                        vm.fetchSearchResults(query: searchText)
                    })
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 10)

                    // 조건부 뷰 로직으로 결과에 따라 다른 뷰를 표시
                    if vm.searchMovies.isEmpty {
                        if searchText.isEmpty {
                            // 초기 상태 메시지
                            Spacer()
                            Text("영화를 검색해주세요.")
                                .foregroundColor(.gray)
                                .font(.headline)
                            Spacer()
                        } else {
                            // 검색 결과가 없는 경우 메시지
                            Spacer()
                            Text("검색 결과가 없습니다.")
                                .foregroundColor(.gray)
                                .font(.headline)
                            Spacer()
                        }
                    } else {
                        // 검색 결과가 있는 경우 카드 뷰 표시
                        GeometryReader { geometry in
                            ViewAllCardView(movies: vm.searchMovies, imageWidth: geometry.size.width * 0.27, imageHeight: geometry.size.height * 0.21, detailViewWidth: geometry.size.width, detailViewHeight: geometry.size.height * 0.4)
                        }
                    }

                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("영화 검색")
            }
        }
    }
}

