//
//  MyPageViewController.swift
//  UIPageViewWhithAppDelegate
//
//  Created by Артем on 3/20/19.
//  Copyright © 2019 Артем. All rights reserved.
//

import UIKit

class MyPageViewController: UIPageViewController {
    
    var indexVC: Int?
    
    private (set) lazy var vcs = {
       return [
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RedVC"),
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BlueVC")
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let first = vcs.first{
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
            
            self.dataSource = self
        }

    }
}


extension MyPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = vcs.firstIndex(of: viewController) else { return nil }
        var previusIndex = vcIndex - 1
        
        if previusIndex < 0 { //переход в конец вью
            previusIndex = vcs.count - 1
        }
//        guard previusIndex >= 0 else { return nil }
        guard vcs.count > previusIndex else {return nil}
        self.indexVC = previusIndex
        return vcs[previusIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = vcs.index(of: viewController) else { return nil }
        let nextIndex = vcIndex + 1
        //guard vcs.count != nextIndex else { return nil }
        guard vcs.count > nextIndex else { return nil }
        self.indexVC = nextIndex
        return vcs[nextIndex]
        
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return vcs.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
//        guard let firstvc = vcs.first,
//        let vcIndex = self.vcs.firstIndex(of: firstvc)
//            else { return 0 }
        
        return self.indexVC ?? 0
    }
    
}
