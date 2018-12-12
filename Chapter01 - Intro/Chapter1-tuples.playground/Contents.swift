import Foundation

let origin = (0.0, 0.0)
let point = (x: 10.0, y: 10.0)

let size = (width: 200, height: 400)
let (w, h) = size
let (width, _) = size

func distance(_ a: (Double, Double), _ b: (Double, Double)) -> Double {
    return sqrt(pow(b.0 - a.0, 2) + pow(b.1 - a.1, 2))
}
distance(point, origin) == 5.0

func slope(_ a: (x: Double, y: Double),_ b: (x: Double, y: Double)) ->
    Double {
        return (b.y - a.y) / (b.x - a.x)
}
slope((10, 10), (x: 1, y: 1)) == 1
