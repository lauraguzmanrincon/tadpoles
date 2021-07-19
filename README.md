# Tadpoles

R function to produce tadpoles.

Requires: `ggplot2`.

## Code
To reproduce the example below, run `main.R` or run:

```
library(data.table)
library(ggplot2)
source("FunctionstadpoleFn.R")

load("Data/DataForTadpole.RData")
tadpoleFn(dataSource = dataExample, dayToPlot = 14, sizePole = 14, dotFill = "IMD")
```

## Example
<div style="text-align:center"><img width="700" alt="tadpole example" src="https://github.com/lauraguzmanrincon/tadpoles/blob/main/Images/Example_tadpole.png">
