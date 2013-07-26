package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
)

var addr = flag.String("addr", ":8000", "http service address")

func main() {
  flag.Parse()

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		_, err := http.Get("http://example.com/")

		if err == nil {
			fmt.Fprintf(w, "Canary sings")
		} else {
			panic("Canary croaked")
		}
	})

	log.Fatal(http.ListenAndServe(*addr, nil))
}
