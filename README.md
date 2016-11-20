# Bonobos Engineering Assignment

### Note
Please use the workspace file rather than the project file as cocoapods has been integrated.

### Overview
This project is a small exercise in building a production-ready mobile application for Bonobos. It's limited to a category and sub-category page. Each category is comprised of a banner image, name, description and a collection view that contains entry points to products. The entire structure is built as a single view so categories can be added as independent structures in a scrollview.

### Service Layer
##### CategoriesService
This is the service that handles all network communications with the Bonobos API. It's main method accepts a category name which it appends to the base API path and then deserializes the JSON into Category->Subcategory->Product objects.

##### ImageCacheService
Since the API delivers a lot of images the UI needs to display, I chose to write an image cache that would download images from URLs provided by the API and store them internally. Since the application heavily leans on reusable tableView/CollectionView cells, the cells can reach for the cache and grab their image instantly rather than download from URL every time. There is no mechanism to flush data when we get to a memory footprint threshhold, but that would be a consideration for a production application.

### User Interface
##### LoadingImageView
This utility was created with the intention of gracefully handling image views that are currently on-screen while still downloading their data in the background. A spinner displays while the image is downloading, and when it's finished, the image animates on-screen.

##### Main Category View
There are a variety of tools that were used to form the interface. The main category view is a table view with cells that represent a Category and any Subcategories. The cells have a table view within that is populated by the subcategories. Cells are sized dynamically based on their content sizes.

### Testing
There is a unit test suite for the image cache and a simple UI test for the basic category->subcategory->product flow.

### Libraries used
- Cocoapods
- AFNetworking for network requests
- LLARingSpinnerView for a pretty spinner
- Masonry for programmatic autolayout constraints
