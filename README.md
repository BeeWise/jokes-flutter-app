# Jokes - Flutter app

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/BeeWise/jokes-flutter-app/blob/master/LICENSE) [![Flutter](https://img.shields.io/badge/-Flutter-blue)](https://flutter.dev)

**Jokes** is a Flutter application designed to exemplify the powerful architecture called ***VIP*** (View - Interactor - Presenter), inspired from [Clean Swift](https://clean-swift.com). It supports *dynamic type*, two *localizations* (English and Romanian) and *configurations* for both development and production. The app fetches and displays jokes from [iGlume](https://iglume.ro).

## Main Scene

### Jokes

<img src="https://user-images.githubusercontent.com/6670019/233549420-0afdefc8-1151-4f67-85e5-cc3488126544.png" width="34%"></img>

## The VIP Architecture

When it comes to building mobile apps, one of the biggest challenges developers face is managing complexity. As an app grows in size and complexity, it becomes harder to maintain and scale. This is where architecture comes in - by separating concerns into distinct layers, developers can create apps that are easier to maintain, test, and scale.

One architecture that has gained popularity in recent years is the VIP (View-Interactor-Presenter) architecture. The VIP architecture is a design pattern that separates the concerns of an application into distinct layers, each with a specific responsibility. Let's take a closer look at each of the layers in the VIP architecture and how they work together.

### View

The view layer is responsible for displaying the user interface to the user and capturing user interactions. This layer is typically implemented using a view controller in mobile development. The view controller's role is to manage the view's lifecycle and respond to user input. It is important to note that the view should not contain any business logic or knowledge of the data model - this responsibility is delegated to the other layers in the architecture.

### Interactor

The interactor layer contains the business logic of the application. It is responsible for fetching and processing data, as well as performing any other operations required by the app. The interactor layer should be designed to be independent of the presentation layer and should not contain any references to the view or presenter.

### Presenter

The presenter layer is responsible for formatting the data obtained from the interactor and preparing it for display on the view. The presenter layer receives data from the interactor and applies any necessary formatting or transformations to prepare it for display on the view. The presenter should not contain any business logic or data manipulation code - this is the responsibility of the interactor layer.

### Flow of Control

The flow of control in the VIP architecture follows a unidirectional pattern. When a user interacts with the view, the view controller triggers a use case in the interactor. The interactor performs the necessary business logic and then invokes the presenter to format the result. Finally, the presenter invokes the view controller to display the results on the screen.

## Contributing

[Issues and pull requests are welcome!](https://github.com/BeeWise/jokes-flutter-app/issues)

## License

**Jokes Flutter App** is released under the MIT license. See [LICENSE](https://github.com/BeeWise/jokes-flutter-app/blob/master/LICENSE) for details.