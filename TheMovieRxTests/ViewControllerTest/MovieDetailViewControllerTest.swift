import Nimble
import Quick
@testable import TheMovieRx

class MovieDetailViewControllerTest: QuickSpec {
    
    override func spec() {
        describe("MovieDetailViewController Test") {
            
            var viewController: MovieDetailViewController?
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            beforeEach {
                viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
            }
            context("When movie details initiated") {
                it("Contain movie name in the title and year of release"){
                    let title = "Aquaman"
                    let release = "2018"
                    
                    viewController?.movieTitle = "\(title)(\(release))"
                    viewController?.preloadView()
                    let (wnd, tearDown) = (viewController?.appearInWindowTearDown())!
                    defer { tearDown() }
                    expect(viewController?.title).to(contain(title))
                    expect(viewController?.title).to(contain(release))
                }
            }
        }
    }
}
