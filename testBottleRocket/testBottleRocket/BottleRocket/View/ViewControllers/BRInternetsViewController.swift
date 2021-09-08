//
//  BRInternetsViewController.swift
//  testBottleRocket
//
//  Created by roreyesl on 08/09/21.
//

import UIKit
import WebKit

class BRInternetsViewController: UIViewController {
    // MARK: - Properties
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.height - 180), configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTopView()
        createWebView()
    }
    // MARK: - Functions
    
    func createTopView(){
        ProgressView.showHUDAddedToWindow()
        let vwTop = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
        vwTop.backgroundColor = UIColor.rgb(red: 67, green: 232, blue: 149)
        
        let btnReturn = UIButton(frame: CGRect(x: 10, y: 50, width: 20, height: 30))
        btnReturn.setImage(UIImage(named: "imgReturn"), for: .normal)
        btnReturn.backgroundColor = UIColor.clear
        btnReturn.addTarget(self, action: #selector(btnReturnAction), for: .touchUpInside)
        vwTop.addSubview(btnReturn)
        
        let btnRefresh = UIButton(frame: CGRect(x: 50, y: 50, width: 30, height: 30))
        btnRefresh.setImage(UIImage(named: "imgRefresh"), for: .normal)
        btnRefresh.backgroundColor = UIColor.clear
        btnRefresh.addTarget(self, action: #selector(btnRefreshAction), for: .touchUpInside)
        vwTop.addSubview(btnRefresh)
        
        let btnNext = UIButton(frame: CGRect(x: 100, y: 50, width: 20, height: 30))
        btnNext.setImage(UIImage(named: "imgNext"), for: .normal)
        btnNext.backgroundColor = UIColor.clear
        btnNext.addTarget(self, action: #selector(btnNextAction), for: .touchUpInside)
        vwTop.addSubview(btnNext)
        
        self.view.addSubview(vwTop)
    }
    
    func createWebView(){
        self.view.backgroundColor = .white
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        if let myURL = URL(string: "https://www.bottlerocketstudios.com") {
            let myRequest = URLRequest(url: myURL)
            webView.load(myRequest)
        }else{
            self.present(AlertGeneric.simpleWith(message: "No se ha podido cargar la pagina. \n\n Intentalo más tarde.", actionTitle: "Aceptar", actionHandler: { error in
                ProgressView.hideHUDAddedToWindow()
            }), animated: true, completion: nil)
        }
        
    }
    
    // MARK: - IBActions
    
    @objc func btnReturnAction(sender: UIButton!) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func btnRefreshAction(sender: UIButton!) {
        ProgressView.showHUDAddedToWindow()
        webView.reload()
    }
    
    @objc func btnNextAction(sender: UIButton!) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    
}
// MARK: - Extensions

extension BRInternetsViewController: WKUIDelegate,WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressView.hideHUDAddedToWindow()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ProgressView.hideHUDAddedToWindow()
    }
}
