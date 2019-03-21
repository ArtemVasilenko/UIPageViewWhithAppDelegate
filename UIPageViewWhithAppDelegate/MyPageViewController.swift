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
    let myDefault = UserDefaults.standard
    
    private (set) lazy var vcs = {
       return [
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RedVC"),
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BlueVC"),
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YellowVC")
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let first = vcs.first{
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
            self.dataSource = self
        
        
//        if myDefault.object(forKey: "IndexVC") != nil {
//            self.indexVC = myDefault.integer(forKey: "IndexVC")
//        } else {
//            self.myDefault.set(0, forKey: "IndexVC")
//        }

    }
}


extension MyPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = vcs.firstIndex(of: viewController) else { return nil }
        let previusIndex = vcIndex - 1
        
       
        guard previusIndex >= 0 else { return nil }
        guard vcs.count > previusIndex else {return nil}
        self.indexVC = previusIndex
        myDefault.set(self.indexVC ?? 0, forKey: "IndexVC")

        return vcs[previusIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = vcs.index(of: viewController) else { return nil }
        let nextIndex = vcIndex + 1
        //guard vcs.count != nextIndex else { return nil }
        guard vcs.count > nextIndex else { return nil }
        self.indexVC = nextIndex
        myDefault.set(self.indexVC ?? 0, forKey: "IndexVC")

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
