# swift-Number
swift 中的Number 可以Codable
struct Model:Codable {
    var age:Number?
    var name:Number?
}


let dict = ["age":154.2,"name":123]
let data = try! JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
do {
    let model = try JSONDecoder().decode(XYModel.self, from: data)

    print(model)
} catch  {
    print(error)
}
