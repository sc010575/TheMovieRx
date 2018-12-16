import Foundation
import RxSwift
import RxCocoa

protocol Serialize {
    associatedtype model
    static func parse(data: Data) -> model?
}

final class ParseJson<T:Codable>: Serialize {

    typealias model = T
    class func parse(data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
}


class ApiController: ApiResource {

    init() {
        Logging.URLRequests = { request in
            return true
        }
    }

    func loadFor(_ movieRequestType: MovieQueryType) -> Observable<Movie> {
        if let request = self.buildRequest(requestType: movieRequestType) {
            return URLSession.shared.rx.movie(request: request)
        }else {
            return Observable.empty()
        }
    }
}
