//
//  UIScrollView+Rx.swift
//  paging
//
//  Created by 松岡 秀樹 on 2017/09/28.
//  Copyright © 2017年 matsuokah. All rights reserved.
//

import Foundation
import UIKit

import RxSwift

extension Reactive where Base: UIScrollView {
	/// ページが切り替わった場合に選択されたページを流すイベント発行します
	/// 慣性スクロールなしのスクロール停止 or 慣性スクロールが停止した場合にPageが選択されたと検出しています
	var didSelectedPage: Observable<UIScrollViewPage> {
		return Observable.merge(didEndDragging.asObservable().filter { return !$0 },
		                        didEndDecelerating.asObservable().map { _ in return true })
			.map { _ in
				// 1以下(0)で割るとページが異常値になることがありうるのでフレームサイズが1以下のときは強制的に0ページ扱いにする
				let verticalPage = Int(self.base.frame.height < 1 ? 0 : self.base.contentOffset.y / self.base.frame.height)
				let horizontalPage = Int(self.base.frame.width < 1 ? 0 : (self.base.contentOffset.x / self.base.frame.width))
				return UIScrollViewPage(vertical: verticalPage, horizontal: horizontalPage)
		}
	}
}
