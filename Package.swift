// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "metronome",
  platforms: [
    .iOS("16.1")
  ],
  products: [
    .library(name: "AppFeature", targets: ["AppFeature"]),
    .library(name: "MetronomeClient", targets: ["MetronomeClient"]),
    .library(name: "AudioSessionClient", targets: ["AudioSessionClient"]),
    .library(name: "Design", targets: ["Design"]),
    .library(name: "Helpers", targets: ["Helpers"]),
    .library(name: "UserDefaultsExtensions", targets: ["UserDefaultsExtensions"]),
    .library(name: "WidgetFeature", targets: ["WidgetFeature"]),
    .library(name: "MetronomeModels", targets: ["MetronomeModels"]),
    .library(name: "WidgetCenterClient", targets: ["WidgetCenterClient"]),
    .library(name: "AppRouting", targets: ["AppRouting"]),
    .library(name: "WidgetActivityAttributes", targets: ["WidgetActivityAttributes"]),
    .library(name: "WidgetLiveActivityFeature", targets: ["WidgetLiveActivityFeature"]),
    .library(name: "ActivityClient", targets: ["ActivityClient"]),
    .library(name: "WidgetLiveActivityClient", targets: ["WidgetLiveActivityClient"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.2.0"),
    .package(url: "https://github.com/tgrapperon/swift-dependencies-additions", from: "1.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-url-routing", exact: "0.6.0"),
  ],
  targets: [
    .target(
      name: "AppFeature",
      dependencies: [
        "MetronomeClient",
        "AudioSessionClient",
        "Design",
        "UserDefaultsExtensions",
        "MetronomeModels",
        "WidgetCenterClient",
        "AppRouting",
        "WidgetLiveActivityClient",
        "ActivityClient",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ],
      resources: [
        .process("Resources")
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .target(
      name: "MetronomeClient",
      dependencies: [
        "MetronomeModels",
        .product(name: "DependenciesAdditions", package: "swift-dependencies-additions"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .target(
      name: "AudioSessionClient",
      dependencies: [
        "Helpers",
        .product(name: "DependenciesAdditions", package: "swift-dependencies-additions"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .target(
      name: "Design",
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .target(
      name: "Helpers",
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .target(
      name: "UserDefaultsExtensions",
      dependencies: [
        "MetronomeModels",
        .product(name: "DependenciesAdditions", package: "swift-dependencies-additions"),
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .target(
      name: "WidgetFeature",
      dependencies: [
        "MetronomeModels",
        "UserDefaultsExtensions",
        "Design",
        "Helpers",
        "AppRouting",
        .product(name: "DependenciesAdditions", package: "swift-dependencies-additions"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .target(
      name: "MetronomeModels",
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .target(
      name: "WidgetCenterClient",
      dependencies: [
        .product(name: "DependenciesAdditions", package: "swift-dependencies-additions"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .target(
      name: "AppRouting",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "URLRouting", package: "swift-url-routing"),
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .testTarget(
      name: "AppRoutingTests",
      dependencies: [
        "AppRouting"
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .target(
      name: "WidgetActivityAttributes",
      dependencies: [
        "MetronomeModels"
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .target(
      name: "WidgetLiveActivityFeature",
      dependencies: [
        "Design",
        "Helpers",
        "AppRouting",
        "WidgetActivityAttributes",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .target(
      name: "ActivityClient",
      dependencies: [
        .product(name: "DependenciesAdditions", package: "swift-dependencies-additions"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .target(
      name: "WidgetLiveActivityClient",
      dependencies: [
        "ActivityClient",
        "WidgetActivityAttributes",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .testTarget(
      name: "HelpersTests",
      dependencies: [
        "Helpers",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    .testTarget(
      name: "AppFeatureTests",
      dependencies: [
        "AppFeature",
        "MetronomeModels",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
  ]
)
