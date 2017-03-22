package main

import (
	"fmt"
	"net/http"
)

func index(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hackathon 2017.\n\nnHello: %s!", r.URL.Path[1:])
}

func ping(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "pong!")
}

func main() {
	http.HandleFunc("/ping", ping)
	http.HandleFunc("/", index)
	http.ListenAndServe(":8080", nil)
}