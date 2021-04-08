# BiliPlayer
弹幕不挡人

## 设置遮罩
```
    func addManualMask(center:CGPoint,radius:CGFloat)
```
## 模拟人物移动

圆圈表示人物移动，即遮罩范围

哔哩哔哩里边用的是人物检测，我们这里手动模拟。

```
    func simulatePeopleMove() 
```

## 修改danmakuView颜色

利于观察

实际场景 danmakuView 颜色为clear
```
   danmakuView.backgroundColor = UIColor.init(white: 1, alpha: 0.1)

```

