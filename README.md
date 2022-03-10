

![logo](./img/logo.png)

# PrettyAxis
![SwiftPM](https://img.shields.io/badge/SwiftPM-Supported-blue) ![Build](https://img.shields.io/badge/build-passing-green) ![license](https://img.shields.io/badge/license-MIT-blue)

A SwiftUI Framework for drawing charts.

## Fearture

- Support Drawing `Bar Chart` `RadarChart`  `Line Chart`  `Scatter Charts` `Pie Chart`  and `Donut Chart`

## Installation

#### Swift Package Manager

If you use Swift Package Manager, simply add PrettyAxis as a dependency of your package in `Package.swift`:

```swift
.package(url: "https://github.com/RiuHDuo/PrettyAxis.git", from: "main")
```

## Quick Start

Using PrettyAxis is very simple,  you can create view like this:

```swift
AxisView(style: .bar, data: values)
```

Currently  `Style` Support： `bar` `line` `radar` `scatter` `pie` and `doughnut`.

`data` is an array of any type which  implements `Axisable` Protocol.

### Axisable Protocol

The data of chart should implement this protocol. This protocol is generic, different chart style will using different type `axisable`.

`AxisView` will render the char from `Axisable` protocol data. 

For example:

If render `bar` chart, bar chart date should be return string type for `x` value of `Axisable` protocol and double type `y`. If `Axisable` protocol return `group` value, bar chart will render by group.

If render `scatter` , the data must return  string type for `x` value of `Axisable` protocol , double type `y` and double type `z`.

### Modifiers

- #### Enable Legend

  ```swift
   AxisView(style: .bar, data: values)
    .enableLegend(true, style: LegendStyle(labelColor: Color.white))
  ```

- #### Add Reference Line

  ````swift
   AxisView(style: .bar, data: values)
             .referenceLine(style: ReferenceLineStyle())	

- #### Change x-axis label font

  ```swift
  AxisView(style: .line, data: values)
      .xAxisLabelColor(Color.yellow)
      .xAxisLabelFont(.caption)
  ```

- #### Change value spacing

  ```swift
  AxisView(style: .line, data: values)
          .spacing(10)
  ```

More documents will coming soon.

## Preview

### Bar

- Default

<img src="./img/image-20211126155043497.png" alt="image-20211126155043497" style="zoom:50%;" />

- Group

  <img src="./img/image-20211126155328522.png" alt="image-20211126155328522" style="zoom:50%;" />

### Line

- smooth

  <img src="./img/image-20211126155618564.png" alt="image-20211126155618564" style="zoom:50%;" />

- straight

  <img src="./img/image-20211126160009598.png" alt="image-20211126160009598" style="zoom:50%;" />

- step

  <img src="./img/image-20211126160239526.png" alt="image-20211126160239526" style="zoom:50%;" />

### Radar

<img src="./img/image-20211126160446558.png" alt="image-20211126160446558" style="zoom:50%;" />

### Scatter

<img src="./img/image-20211126160735666.png" alt="image-20211126160735666" style="zoom:50%;" />

## License

Distributed under the MIT License.