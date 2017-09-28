//
//  ViewController.swift
//  paging
//
//  Created by 松岡 秀樹 on 2017/09/27.
//  Copyright © 2017年 matsuokah. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {

	var disposeBag = DisposeBag()
	
	@IBOutlet weak var scrollView: UIScrollView!
	
	@IBOutlet weak var pagerDelegateContainerView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		setupPagerScrollView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}

extension ViewController: PagerScrollViewControllerProtocol {
	var pager: UIScrollView {
		return scrollView
	}
	
	var pagerDelegateViews: [PageDelegate] {
		return pagerDelegateContainerView.subviews.filter { $0 is PageDelegate }.map { $0 as! PageDelegate }
	}
}
