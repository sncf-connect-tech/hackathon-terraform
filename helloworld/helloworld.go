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
	port := "8080"
	if (len(os.Args) > 1) {
		port = os.Args[1]
	}
	fmt.Printf("listen to %s\n", port)
	http.HandleFunc("/ping", ping)
	http.HandleFunc("/", index)
	http.ListenAndServe(fmt.Sprintf(":%s", port), nil)
	fmt.Println("server started")
}
