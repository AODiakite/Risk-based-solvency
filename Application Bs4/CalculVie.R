# Proba de survie -----
tPx <- function(x,TD = TD_88_90){
  tryCatch(
    ifelse(x+2 > 111 | TD[[2]][x+1] == 0,
           0,
           TD[[2]][x+2]/TD[[2]][x+1]),
    error = function(e){
     return(0)
    }
  )

}

# Proba de Deces -----
tQx <- function(x,TD = TD_88_90){
  1 - tPx(x,TD)
}

