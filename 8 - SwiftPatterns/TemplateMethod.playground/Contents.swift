import Cocoa

var str = "Hello, playground"

protocol RecommendationEngine {
    associatedtype Model
    var models: [Model] { get }
    func filter(elements: [Model]) -> [Model]
    func sort(elements: [Model]) -> [Model]
}

extension RecommendationEngine {
    func match() -> Model? {
        // If we only have 0 or 1 models, no need to do the algorithm
        guard models.count > 1 else { return models.first }

        return sort(elements: filter(elements: models)).first
    }
}

struct Restaurant {
    var name: String
    var beenThere: Bool
    var score: Double
}

extension RecommendationEngine where Model == Restaurant {
    func sort(elements: [Model]) -> [Model] {
        return elements.sorted { $0.score > $1.score }
    }
}

struct FavoriteEngine: RecommendationEngine {
    var models: [Restaurant]

    func filter(elements: [Restaurant]) -> [Restaurant] {
        return elements.filter { $0.beenThere }
    }
}

let restaurants = [
    Restaurant(name: "Tony's Pizza", beenThere: true, score: 2.0),
    Restaurant(name: "Krusty's", beenThere: true, score: 3.0),
    Restaurant(name: "Bob's burger", beenThere: false, score: 2.0)]

let engine = FavoriteEngine(models: restaurants)
let match = engine.match()

struct BestEngine: RecommendationEngine {
    var models: [Restaurant]

    func filter(elements: [Restaurant]) -> [Restaurant] {
        return elements.filter { !$0.beenThere }
    }
}

let dpref = BestEngine(models: restaurants)
dpref.match()
dpref.match()?.name == "Bob's burger"
