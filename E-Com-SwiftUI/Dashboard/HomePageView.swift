import SwiftUI

// Initialize view model
let viewModel = HomeScreenViewModel()

struct HomePageView: View {
    @ObservedObject var viewModel = HomeScreenViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Spacer to push the content below the safe area
            HeaderView()

            // Scroll View for the content
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    VStack {
                        ForEach(viewModel.sections, id: \.id) { section in
                            switch section.type {
                            case "banner_slider":
                                BannerSliderView(banner: section.contents ?? [])
                            case "products":
                                ProductsSectionView(title: section.title ?? "", products: section.contents ?? [])
                            case "catagories":
                                CategoriesSectionView(categories: section.contents ?? [])
                            case "banner_single":
                                    SingleBannerView(imageUrl: section.contents?.first?.image_url ?? "")
                            default:
                                EmptyView()
                            }
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top) // Ignore the top safe area to make header fill the top edge
        .onAppear {
            viewModel.fetchDataAndStoreOffline()
        }
    }
}

struct HeaderView: View {
    @State private var searchText = ""

    var body: some View {
        VStack(spacing: 0) {
            Color.green // Background color for the header (visible behind the icons and text field)
                .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top) // Height to match the safe area

            HStack {
                // Bell icon on the left
                Button(action: {
                    // Handle bell action
                }) {
                    Image(systemName: "cart")
                        .resizable()
                        .scaledToFit() // Ensures the icon scales to fit its frame
                        .frame(width: 25, height: 25) // Increase size of the bell icon
                        .foregroundColor(.white)
                        .padding()
                }

                Spacer()

                // Search TextField in the center
                TextField("Search...", text: $searchText)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)

                Spacer()

                // Cart icon on the right
                Button(action: {
                    // Handle cart action
                }) {
                    Image(systemName: "bell")
                        .resizable()
                        .scaledToFit() // Ensures the icon scales to fit its frame
                        .frame(width: 25, height: 25) // Increase size of the cart icon
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .padding()
            .background(Color.green) // Green background for the header
        }
        .background(Color.green)
    }
}




// Custom PageControl to handle the colors of the dots
struct PageControl: UIViewRepresentable {
    @Binding var currentPage: Int
    var numberOfPages: Int

    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .darkGray // Current page color
        pageControl.pageIndicatorTintColor = .lightGray // Other pages color
        pageControl.addTarget(context.coordinator, action: #selector(Coordinator.didChangePage(_:)), for: .valueChanged)
        return pageControl
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
        uiView.numberOfPages = numberOfPages
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var control: PageControl

        init(_ control: PageControl) {
            self.control = control
        }

        @objc func didChangePage(_ sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

