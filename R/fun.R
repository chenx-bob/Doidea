fun.test <- function(a, b, method = "add"){
  if(method == "add"){
    res <- a + b
  }
  if(method == "subtract"){
    res <- a - b
  }
  print(res)
  return(res)
}