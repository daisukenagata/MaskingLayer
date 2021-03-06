//
//  CameraViewController.swift
//  MaskingLayer_Example
//
//  Created by 永田大祐 on 2019/11/08.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MaskingLayer

class CameraViewController: UIViewController {

    static func identifier() -> String { return String(describing: ViewController.self) }

    static func viewController() -> ViewController {

        let sb = UIStoryboard(name: "Camera", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! ViewController
        return vc
    }

    private var mVM              : MaskingLayerViewModel? = nil
    private var mBObject         : MaskButtonView? = nil
    private var d: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        d = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        mBObject?.cameraMatte.isHidden = false
        mBObject?.cameraRecord.isHidden = false
        
        mVM = MaskingLayerViewModel()
        mBObject = MaskButtonView(frame: self.tabBarController?.tabBar.frame ?? CGRect())

        self.tabBarController?.tabBar.addSubview(mBObject?.cameraMatte ?? UIButton())
        self.tabBarController?.tabBar.addSubview(mBObject?.cameraRecord ?? UIButton())

        mBObject?.cameraMatte.addTarget(self, action: #selector(btAction), for: .touchUpInside)
        mBObject?.cameraRecord.addTarget(self, action: #selector(cameraAction), for: .touchUpInside)

        view.addSubview(d ?? UIView())
        mVM?.cmareraPreView(d ?? UIView())
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

        mBObject?.cameraMatte.isHidden = true
        mBObject?.cameraRecord.isHidden = true
        d?.removeFromSuperview()
        mVM?.cameraReset(view: d ?? UIView())
        mVM = nil
    }

    // DyeHair Set
    @objc func btAction() { mVM?.btAction(view: d ?? UIView()) }

    // Save photosAlbum
    @objc func cameraAction() { mVM?.cameraAction() }

}
