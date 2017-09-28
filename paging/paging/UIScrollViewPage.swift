//
//  UIScrollViewPage.swift
//  paging
//
//  Created by 松岡 秀樹 on 2017/09/28.
//  Copyright © 2017年 matsuokah. All rights reserved.
//

import Foundation

/// UIScrollViewの世界でのページを表現する構造体です
/// 初期ページは0です
struct UIScrollViewPage {
	let vertical: Int
	let horizontal: Int
}

extension UIScrollViewPage: Equatable {
	public static func ==(lhs: UIScrollViewPage, rhs: UIScrollViewPage) -> Bool {
		return lhs.vertical == rhs.vertical && lhs.horizontal == rhs.horizontal
	}
}
