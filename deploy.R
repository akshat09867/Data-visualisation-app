library(rsconnect)
   rsconnect::deployApp(
  appDir        = ".",
  appPrimaryDoc = "MyShinyapp.R"
)
