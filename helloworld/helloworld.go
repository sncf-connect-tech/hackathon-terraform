package main

import (
	"fmt"
	"net/http"
	"os"
)

func index(w http.ResponseWriter, r *http.Request) {
	hostname, _ := os.Hostname()
	fmt.Fprintf(w, "Hackathon 2017.\n\nnHello: %s!\nhostname %s", r.URL.Path[1:], hostname)
}

func ping(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "pong!")
}

func main() {
	http.HandleFunc("/ping", ping)
	http.HandleFunc("/", index)
	http.ListenAndServe(":8080", nil)
}
