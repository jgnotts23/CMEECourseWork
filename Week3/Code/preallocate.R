first <- function(a){
    a <- 1
    for (i in 1:10) {
        a[i] = 10
    }
}

print(system.time(first(a)))


second <- function(b){
    b <- rep(NA, 10)

    for (i in 1:10) {
        b[i] = 10
    }
}

print(system.time(second(b)))