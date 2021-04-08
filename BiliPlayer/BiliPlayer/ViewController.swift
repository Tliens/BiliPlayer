//
//  ViewController.swift
//  BiliPlayer
//
//  Created by 2020 on 2021/3/19.
//

import UIKit

class ViewController: UIViewController {

    let danmakuView = DanmukuContentView()
    
    var timer : Timer?
    var point : CGPoint = .zero
    var up = false
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let iv = UIImageView(frame: view.bounds)
        iv.image = UIImage(named: "download")
        iv.contentMode = .scaleAspectFill
        view.addSubview(iv)
        danmakuView.frame = view.bounds
        view.addSubview(danmakuView)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        point = view.center
        simulatePeopleMove()
        danmakuView.generate(number:15)
    }
    
    func simulatePeopleMove() {
        
        timer = Timer(timeInterval: 0.05, repeats: true, block: { [weak self](_) in
            guard let self = self else{return}
            self.point = CGPoint(x: self.point.x, y: self.point.y+(self.up ? 5: -5))
            /// 关键点限制
            self.point.y = min(self.view.bounds.height-100, self.point.y)
            self.point.y = max(100, self.point.y)
            
            if self.point.y == self.view.bounds.height-100 {
                self.up = false
            }
            if self.point.y == 100{
                self.up = true
            }
            // 更新弹幕位置
            self.danmakuView.update()
            self.danmakuView.addManualMask(center: self.point, radius: 100)
        })
        timer?.fire()
        RunLoop.current.add(timer!, forMode: .common)
    }
}

class DanmukuContentView:UIView{
    var maskLayer = CAShapeLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    func setupUI(){
        backgroundColor = .white
    }
    func addManualMask(center:CGPoint,radius:CGFloat){
        let path = UIBezierPath.init(rect: self.bounds)
        let cirlce = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: .pi*2, clockwise: false)
        path.append(cirlce)
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    func generate(number:Int){
        for _ in 0..<number{
            let lb = UILabel()
            lb.text = "跟着熊大学说话，\"我的好大儿\""
            lb.textColor = .black
            
            lb.frame = CGRect(x: Int(bounds.width), y: Int(arc4random())%15*50 + 50, width: 200, height: 20)
            addSubview(lb)
        }
    }
    func update(){
        for v in subviews{
            if arc4random()%2 == 0{
                v.frame.origin.x = max(-200, v.frame.origin.x-5)
                if v.frame.origin.x == -200{
                    v.removeFromSuperview()
                    generate(number: 1)
                }
            }
        }
    }
}

