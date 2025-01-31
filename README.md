# rha

A new Flutter project.

## Getting Started

This project is the codebase for the RHA_TALLY ride hailing applicatiom.

To start this application, run the following commands:

- flutter clean
- flutter pub get
- flutter run


The GetX state management was used for this.

The architecture used for this application is the clean architecture:

- config (which handles - routes, colors, images, config, theme)
- presentation (contains widgets, screens, controllers)
- domain (dto, models,impl)
- data (dto, models,impl)