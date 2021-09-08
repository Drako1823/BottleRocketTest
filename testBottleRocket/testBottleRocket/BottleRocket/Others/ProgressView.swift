//
//  ProgressView.swift
//  testBottleRocket
//
//  Created by roreyesl on 08/09/21.
//

import UIKit

public class ProgressView: UIView {
    // MARK: - Properties
    
    static let iTagHUD = 999999
    private lazy var spinner = UIActivityIndicatorView(style: .large)
    
    //MARK: - LifeCycle
    required convenience init(window:UIWindow) {
        self.init(view: window)
    }
    
    required convenience init(view:UIView) {
        self.init(frame: view.bounds)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin]
        self.isOpaque = false
        self.backgroundColor = UIColor.clear
        self.alpha = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Functions
    
    public override func draw(_ rect: CGRect) {
        let boxRect : CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.fillRoundedRect(rect: boxRect, context: UIGraphicsGetCurrentContext())
    }
    
    public static func showHUDAddedToWindow() {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            let hud : ProgressView = ProgressView.init(window: window)
            hud.tag = 999999
            hud.updateIndicators()
            window.addSubview(hud)
            window.bringSubviewToFront(hud)
        }
    }
    
    public static func hideHUDAddedToWindow() {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            for view in window.subviews{
                if view.tag == 999999{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                        view.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    //MARK: - Private
    
    private func removeFromSuperViewActivity() {
        spinner.removeFromSuperview()
    }
    
    @objc private func updateIndicators() {
        self.removeFromSuperViewActivity()
        spinner.contentMode = .center
        spinner.frame = CGRect(x: (UIScreen.main.bounds.size.width / 2) - 15, y: (UIScreen.main.bounds.size.height / 2) - 15, width: 30, height: 30)
        spinner.startAnimating()
        spinner.color = .green
        self.addSubview(spinner)
        
    }
    
    private func fillRoundedRect(rect:CGRect, context:CGContext?) {
        if let _ = context {
            context!.beginPath()
            context!.setFillColor(gray: 0.0, alpha: 0.45)
            context!.move(to: CGPoint(x: rect.minX, y: rect.minY))
            context!.addArc(center: CGPoint(x: rect.maxX,y: rect.minY), radius: 0.0, startAngle: CGFloat(3 * Double.pi / 2), endAngle: 0, clockwise: false)
            context!.addArc(center: CGPoint(x: rect.maxX,y: rect.maxY), radius: 0.0, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: false)
            context!.addArc(center: CGPoint(x: rect.minX,y: rect.maxY), radius: 0.0, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi), clockwise: false)
            context!.addArc(center: CGPoint(x: rect.minX,y: rect.minY), radius: 0.0, startAngle: CGFloat(Double.pi), endAngle: CGFloat(3 * Double.pi / 2), clockwise: false)
            context!.closePath()
            context!.fillPath()
        }
    }
}
