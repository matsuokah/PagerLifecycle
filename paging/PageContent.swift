//
//  PageContent.swift
//  paging
//
//  Created by 松岡 秀樹 on 2017/09/28.
//  Copyright © 2017年 matsuokah. All rights reserved.
//

import Foundation
import UIKit

final class PageContentView: UIView, PageDelegate {
	var targetPageView: UIView {
		return self
	}
	
	var isVisiblePage: Bool = false
	
	func viewDidAppear() {
		NSLog("viewDidAppear, tag: \(self.tag)")
	}

	func viewDidDisappear() {
		NSLog("viewDidDisappear, tag: \(self.tag)")
	}
}
