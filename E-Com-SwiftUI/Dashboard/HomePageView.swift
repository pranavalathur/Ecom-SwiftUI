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
                                BannerSliderView(banners: section.contents ?? [])
                            case "products":
                                ProductsSectionView(title: section.title ?? "", products: section.contents ?? [])
                            case "catagories":
                                CategoriesSectionView(categories: section.contents ?? [])
                            case "banner_single":
                                if let imageUrl = section.contents?.first?.image_url {
                                    SingleBannerView(imageUrl: imageUrl)
                                }
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
                    Image(systemName: "bell")
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
                    Image(systemName: "cart")
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


struct BannerSliderView: View {
    let banners: [Content]
    @State private var currentPage = 0 // State variable to track the current page

    var body: some View {
        VStack {
            TabView(selection: $currentPage) { // Bind currentPage to TabView
                ForEach(banners.indices, id: \.self) { index in
                    if let imageUrl = banners[index].image_url {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Image("banner-image-ph") // Placeholder from assets
                                .resizable()
                                .scaledToFit()
                        }
                        .tag(index) // Tag each view with its index
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Disable default page indicator
            .frame(height: 200)
            
            // Custom Page Control
            PageControl(currentPage: $currentPage, numberOfPages: banners.count)
                .frame(width: CGFloat(banners.count * 15)) // Adjust width based on number of pages
        }
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






struct ProductsSectionView: View {
    let title: String
    let products: [Content]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(products) { product in
                        VStack {
                            if let imageUrl = product.product_image {
                                AsyncImage(url: URL(string: imageUrl)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    Image("product-ph") // Placeholder from assets
                                        .resizable()
                                        .scaledToFit()
                                }
                                .frame(width: 100, height: 100)
                            }
                            Text(product.product_name ?? "")
                                .font(.caption)
                                .lineLimit(2)
                            Text(product.offer_price ?? "")
                                .font(.headline)
                        }
                        .frame(width: 150)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct SingleBannerView: View {
    let imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Image("single-banner-ph") // Placeholder from assets
                .resizable()
                .scaledToFit()
        }
        .frame(height: 150)
        .padding(.horizontal)
    }
}


struct CategoriesSectionView: View {
    let categories: [Content]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Top Categories")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(categories) { category in
                        VStack {
                            if let imageUrl = category.image_url {
                                AsyncImage(url: URL(string: imageUrl)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    Image("product-ph") // Placeholder from assets
                                        .resizable()
                                        .scaledToFit()
                                }
                                .frame(width: 50, height: 50)
                            }
                            Text(category.title ?? "")
                                .font(.caption)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}



struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

// Fetch terms and conditions
//func fetchTermsAndConditions() {
//    viewModel.fetchHomeScreenDetails()
//    viewModel.homeScreenDataFetchSuccess = {
//        print("Success")
//        homeScreenDetails = viewModel.homeScreenRes
//    }
//    viewModel.errorMessageAlert = {
//        // Handle error
//    }
//    viewModel.loadingStatus = {
//        if viewModel.isLoading {
//            // Show loading indicator
//        } else {
//            // Hide loading indicator
//        }
//    }
//}

