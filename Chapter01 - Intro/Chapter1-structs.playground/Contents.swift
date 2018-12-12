//: Playground - noun: a place where people can play

struct Point {
    var x: Double
    var y: Double
}

func translate(point: inout Point, dx : Double, dy : Double) {
    point.x += dx
    point.y += dy
}

var point = Point(x: 0.0, y: 0.0)
translate(point: &point, dx: 1.0, dy: 1.0)
point.x == 1.0 // true
point.y == 1.0 // true
