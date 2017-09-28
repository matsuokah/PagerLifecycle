//
//  PageDelegate.swift
//  paging
//
//  Created by 松岡 秀樹 on 2017/09/28.
//  Copyright © 2017年 matsuokah. All rights reserved.
//

import Foundation
import UIKit

protocol UIPageViewProtocol: class {
	var targetPageView: UIView { get }
}

protocol PageState: class {
	var isVisiblePage: Bool { get set }
}

protocol PageDelegate: PageState, UIPageViewProtocol {
	func viewDidAppear()
	func viewDidDisappear()
}
