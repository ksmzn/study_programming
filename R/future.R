setwd("~")
install.packages("future")
library(future)

v <- {
  cat("Resolving...\n")
  3.14
}
class(v)
v

future::plan(multiprocess)
v %<-% {
  cat("Resolving...\n")
  3.14
}
class(v)
v

a %<-% {
  cat("Resolving 'a'...")
  Sys.sleep(5)
  print("Done!\n")
  cat("Done!\n")
  Sys.getpid()
}
cat("Waiting for 'a' to be resolved ...\n")
f <- futureOf(a)
f
a
# Sys.sleep(2)
count <- 1
while (!resolved(f)) {
    cat(count, "\n")
    Sys.sleep(0.2)
    count <- count + 1
}
count

sta <- Sys.time()
cat("Start future -------------")
saikoro <- runif(1, min = 1, max = 6) 
a %<-% {
  cat("Resolving 'a'...")
  Sys.sleep(5)
  cat("Done!\n")
  saikoro + 10
}
Sys.sleep(2)
cat("saikoro", saikoro)
cat("saikoro + 10", a)
end <- Sys.time()

sta2 <- Sys.time()
cat("Start No future -------------")
saikoro <- runif(1, min = 1, max = 6) 
a <- {
  cat("Resolving 'a'...")
  Sys.sleep(5)
  cat("Done!\n")
  saikoro + 10
}
Sys.sleep(2)
cat("saikoro", saikoro)
cat("saikoro + 10", a)
end2 <- Sys.time()

plan("eager")
sta3 <- Sys.time()
cat("Start eager future -------------")
saikoro <- runif(1, min = 1, max = 6) 
a %<-% {
  cat("Resolving 'a'...")
  Sys.sleep(5)
  cat("Done!\n")
  saikoro + 10
}
Sys.sleep(2)
cat("saikoro", saikoro)
cat("saikoro + 10", a)
end3 <- Sys.time()

plan("lazy")
sta4 <- Sys.time()
cat("Start lazy future -------------")
saikoro <- runif(1, min = 1, max = 6) 
a %<-% {
  cat("Resolving 'a'...")
  Sys.sleep(5)
  cat("Done!\n")
  saikoro + 10
}
Sys.sleep(2)
cat("saikoro", saikoro)
cat("saikoro + 10", a)
end4 <- Sys.time()

cat(end - sta)
cat(end2 - sta2)
cat(end3 - sta3)
cat(end4 - sta4)
