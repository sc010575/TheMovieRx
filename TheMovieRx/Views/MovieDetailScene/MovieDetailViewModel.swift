import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel {
    
    let apiController:ApiController!
    let movieId:Int!
    let disposaple = SingleAssignmentDisposable()
    
    let publishDetails = PublishSubject<MovieDetail>()
    
    init(_ id:Int, apiController:ApiController = ApiController()) {
        self.movieId = id
        self.apiController = apiController
    }
    
    func loadMovieDetail() {
        let s = apiController.loadFor(movieId).asObservable()
        .observeOn(MainScheduler.instance)
            .subscribe(onNext: { movieDetail in
                self.publishDetails.onNext(movieDetail)
                self.publishDetails.onCompleted()
            }, onError: { error in
                //Print error
            })
        disposaple.setDisposable(s)
    }
}
