//: Playground - noun: a place where people can play

class Point {
    var x: Double
    var y: Double
    init(x: Double, y: Double) {
        self.x = x
        self.y = y }
}

func translate(point : Point, dx : Double, dy : Double) {
    point.x += dx
    point.y += dy
}

let point = Point(x: 0.0, y: 0.0)
translate(point: point, dx: 1.0, dy: 1.0)
point.x == 1.0
point.y == 1.0
