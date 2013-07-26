package main

import (
  "flag"
  "fmt"
  "log"
  "net/http"
)

var domain = flag.String("domain", "cfapps.io", "base domain")
var addr = flag.String("addr", ":8000", "http service address")
var count = flag.Int("count", 0, "number of canaries to check")

func main() {
  flag.Parse()

  http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
    for i := 1; i <= *count; i += 1 {
      res, err := http.Get(fmt.Sprintf("http://zero-downtime-canary%d.%s", i, *domain))
      if err != nil || res.StatusCode != 200 {
        panic(fmt.Sprintf("Zero Downtime Canary %d croaked", i))
      }
    }

    fmt.Fprintf(w, "Canary sings")
  })

  log.Fatal(http.ListenAndServe(*addr, nil))
}
