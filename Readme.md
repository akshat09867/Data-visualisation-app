# Interactive Data Explorer Shiny App

## ➡️ Visit the App
[Visit the Interactive Data Explorer](https://akshat12.shinyapps.io/myshinyapp/)

### Overview
The **Interactive Data Explorer** is a Shiny application designed to facilitate dynamic data visualization and exploration. Built with R and leveraging packages like `shiny`, `plotly`, `shinydashboard`, and `DT`, this app allows users to upload CSV files, visualize data through various interactive plots, and explore dataset summaries and previews. 

### Importance
This Shiny app addresses the need for accessible, user-friendly data exploration tools. Its key benefits include:

- **Ease of Use**: No coding expertise is required. Users can upload a CSV file and interact with the data through a sleek dashboard interface.
- **Dynamic Visualizations**: Supports multiple plot types (Scatter, Histogram, Boxplot, Area, and Sankey) with customizable settings like opacity and color, powered by `plotly` for interactivity.
- **Real-Time Insights**: Provides immediate feedback with data summaries, row/column counts, and a data preview table.
- **Flexibility**: Works with any CSV dataset, allowing users to select columns for visualization and adjust plot parameters on the fly.

### Features
- **Data Upload**: Upload CSV files with a simple file input interface, with validation to ensure only CSV files are accepted.
- **Visualization Options**:
  - **Scatter**: Displays relationships between two variables.
  - **Histogram**: Shows the distribution of a single variable.
  - **Boxplot**: Visualizes data spread and outliers across categories.
  - **Area**: Illustrates cumulative trends over a variable.
  - **Sankey**: Depicts flows between categorical variables (requires at least three columns).
- **Customization**: Adjust plot opacity and color using sliders and a color picker.
- **Dashboard Metrics**: Displays the number of rows, columns, and file upload status in visually appealing value boxes.
- **Data Preview**: Interactive data table with scrolling and pagination for quick dataset inspection.
- **Summary Statistics**: Automatically generates a statistical summary of the dataset.
- **Responsive Design**: Built with `shinydashboard` for a modern, professional look with a customizable blue skin.
