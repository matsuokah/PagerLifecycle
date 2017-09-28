//
//  PagerScrollViewControllerProtocol.swift
//  paging
//
//  Created by 松岡 秀樹 on 2017/09/28.
//  Copyright © 2017年 matsuokah. All rights reserved.
//

import Foundation
import UIKit

import RxSwift

protocol PagerScrollViewControllerProtocol: class {
	func setupPagerScrollView()
	var pager: UIScrollView { get }
	var pagerDelegateViews: [PageDelegate] { get }
	var disposeBag: DisposeBag { get }
}

extension PagerScrollViewControllerProtocol where Self: UIViewController {
	/// ページ選択を検出するためのセットアップを行います
	/// ターゲットとなるScrollViewのイベントのバインディング
	/// 選択ステータスの初期化
	func setupPagerScrollView() {
		pager.rx.didSelectedPage
			.distinctUntilChanged()
			.subscribe(onNext: { [weak self] page in
				guard let `self` = self else { return }
				self.applyAppearPage()
			}).disposed(by: disposeBag)
		
		// initialise for state
		applyAppearPage()
	}
	
	private func applyAppearPage() {
		let offset = pager.contentOffset
		let pagerSize = pager.frame.size
		let visibleArea = CGRect(x: offset.x, y: offset.y, width: pagerSize.width, height: pagerSize.height)
		
		pagerDelegateViews
			// 表示View, 非表示Viewの振り分け
			.reduce(into: Dictionary<Bool, Array<PageDelegate>>()) { base, content in
				let isVisisble = visibleArea.intersects(content.targetPageView.frame)
				base[isVisisble, default: []].append(content)
			}
			.forEach { (isVisisble, views) in
				if isVisisble {
					// 表示されていなかったViewがページ切り替えによって表示になった
					views
						.filter { page in
							return !page.isVisiblePage
						}
						.forEach { page in
							page.viewDidAppear()
							page.isVisiblePage = true
					}
				} else {
					// 表示されていたViewがページ切り替えによって非表示になった
					views.filter { page in
						return page.isVisiblePage
						}
						.forEach { page in
							page.viewDidDisappear()
							page.isVisiblePage = false
					}
				}
		}
	}
}
