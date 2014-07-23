## SunBurst Chart

See D3 working example [here](http://bl.ocks.org/mbostock/4348373)

### Action in R
Prepare data in R so that it can be fed to the D3 template

One suitable usecase is output of *hclust* tree

We will use *RJSONIO* package to convert the output to required JSON format

### Bridge to D3
Using *whisker* package, data will be combined with the template

### Action in D3
Only changing the incoming JSON file. No chart config is changed. 
Again no help provided here. Get your hands dirty with D3 JS code.

### R Workflow
```R
library(RCurl)
source_https <- function(url, ...) {
  # parse and evaluate each .R script
  sapply(c(url, ...), function(u) {
  eval(parse(text = getURL(u, followlocation = TRUE, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))), envir = .GlobalEnv)
  })
}

#Prepare the data
source_https("https://raw.github.com/gaursrbh/R2D3/master/SunBurst/hcjson.R")
data<-iris
cluster<-hclust(dist(data))
final<-toJSON(hcjson(cluster$merge))
write(final,file="datafile.json")
params<-list(jsonpath="datafile.json")

#Fetch template and pass the parameters
library(whisker)
template<-getURL("https://raw.githubusercontent.com/gaursrbh/R2D3/master/SunBurst/template.html")
write(whisker.render(template, params),file="output.html")
```
### Output
See output [here] (http://saurabhgaur.com/static/d3/sunburst/output.html)
