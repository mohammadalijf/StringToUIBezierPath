# String To UIBezierPath

create UIBezierPath from swift String

## example

following code

```swift
let helloWorldString = "hello world!"
let path = helloWorldString.bezierPath(withFont: UIFont.systemFont(ofSize: 64))
let shapeLayer = CAShapeLayer(layer: holderView.layer)
shapeLayer.path = path.cgPath
shapeLayer.fillColor = fillColor
shapeLayer.strokeColor = lineColor
shapeLayer.lineWidth = 2
holderView.layer.addSublayer(shapeLayer)
```

results this

![alt text](https://github.com/mohammadalijf/StringToUIBezierPath/raw/master/Tests/hello.png "Hello world!")
