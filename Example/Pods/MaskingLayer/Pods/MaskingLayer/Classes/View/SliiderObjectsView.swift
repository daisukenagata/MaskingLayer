//
//  SliiderObjectsView.swift
//  MaskMatte
//
//  Created by 永田大祐 on 2019/11/05.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

class SliiderObjectsView: UIView, UIGestureRecognizerDelegate {

    @IBOutlet weak var sliderImageView: UIImageView!

    @IBOutlet weak var sliderView: UIStackView!

    @IBOutlet weak var sliderInputRVector: UISlider!{
        didSet {
            sliderInputRVector.value = 1.0
        }
    }
    @IBOutlet weak var sliderInputGVector: UISlider!{
        didSet {
            sliderInputGVector.value = 1.0
        }
    }
    @IBOutlet weak var sliderInputBVector: UISlider!{
        didSet {
            sliderInputBVector.value = 1.0
        }
    }
    @IBOutlet weak var sliderInputAVector: UISlider!{
        didSet {
            sliderInputAVector.value = 1.0
        }
    }

    private var panGesture = UIPanGestureRecognizer()
    private var longTapGesture = UILongPressGestureRecognizer()

    private var height: CGFloat = 50

    init(frameHight: CGFloat) {
        super.init(frame: .zero)

        loadNib()
        pGesture()
        height = frameHight
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func loadNib() {
        let bundle = Bundle(for: SliiderObjectsView.self)
        let view = bundle.loadNibNamed("SliiderObjectsView", owner: self, options: nil)?.first as? UIView
        view?.frame = UIScreen.main.bounds
        self.addSubview(view ?? UIView())
        self.subviews[0].backgroundColor = .black
    }

    func returnAnimation() {
        sliderImageView.frame.origin.y -= self.frame.height/2 - height
        sliderImageView.transform = sliderImageView.transform.scaledBy(x: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.4) {
            self.sliderImageView.transform = .identity
            self.sliderImageView.frame.origin.y += self.frame.height/2 - self.height
            self.subviews[0].bringSubviewToFront(self.sliderImageView)
        }
    }

    private func pGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action:#selector(panTapped(sender:)))
        panGesture.delegate = self
        self.addGestureRecognizer(panGesture)

        longTapGesture = UILongPressGestureRecognizer(target: self, action:#selector(longTapped(sender:)))
        longTapGesture.delegate = self
        self.addGestureRecognizer(longTapGesture)
    }

    @objc private func longTapped(sender: UILongPressGestureRecognizer) {
        subviews[0].subviews[0] == sliderImageView ? returnAnimation() : nil
    }

    @objc private func panTapped(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .ended:
            if subviews[0].subviews[0] == sliderView {
                self.sliderImageView.transform = self.sliderImageView.transform.scaledBy(x: 0.9, y: 0.9)
                self.sliderImageView.frame.origin.y = 0
                self.subviews[0].bringSubviewToFront(self.sliderView)
            }
            break
        case .possible: break
        case .began: subviews[0].subviews[0] == sliderView ? self.sliderImageView.frame.origin.y -= self.frame.height/2 - self.height: nil
        case .changed: break
        case .cancelled: break
        case .failed: break
        @unknown default: break
        }
    }

    @IBAction func sliderInputRVector(_ sender: UISlider) { sliderInputRVector.value = sender.value }

    @IBAction func sliderInputGVector(_ sender: UISlider) { sliderInputGVector.value = sender.value }

    @IBAction func sliderInputBVector(_ sender: UISlider) { sliderInputBVector.value = sender.value }

    @IBAction func sliderInputAVector(_ sender: UISlider) { sliderInputAVector.value = sender.value }

}
