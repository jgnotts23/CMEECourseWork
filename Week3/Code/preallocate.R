first <- function(a){
    a <- NA
    for (i in 1:100000) {
    a <- c(a, i)
    }
    print(a)
}

print(system.time(first(a)))


second <- function(b){
    b <- rep(NA, 10000000)

    for (i in 1:10000000) {
        b[i] <- i
    }
    print(b)
}

print(system.time(second(b)))