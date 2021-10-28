//
//  RefreshableScrollView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/28.
//

import SwiftUI

struct RefreshableScrollView<Content: View>: UIViewRepresentable {
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    
    var onRefresh: (UIRefreshControl) -> ()
    var content: Content
    
    init(onRefresh: @escaping (UIRefreshControl) -> (), @ViewBuilder content: @escaping () -> Content) {
        self.onRefresh = onRefresh
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        
        refreshControl.addTarget(context.coordinator, action: #selector(context.coordinator.onRefresh), for: .valueChanged)
        setUpView(scrollView)
        scrollView.refreshControl = refreshControl
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        setUpView(uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func setUpView(_ scrollView: UIScrollView) {
        let hostView = UIHostingController(rootView: content.frame(maxHeight: .infinity, alignment: .top))
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            hostView.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            hostView.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            hostView.view.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, constant: 1)
        ]
        
        scrollView.subviews.last?.removeFromSuperview()
        scrollView.addSubview(hostView.view)
        scrollView.addConstraints(constraints)
    }
    
    class Coordinator: NSObject {
        var parent: RefreshableScrollView
        
        init(_ parent: RefreshableScrollView) {
            self.parent = parent
        }
        
        @objc func onRefresh() {
            parent.onRefresh(parent.refreshControl)
        }
    }
}
