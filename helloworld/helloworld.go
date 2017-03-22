package main

import (
	"fmt"
	"net/http"
	"os"
	"io/ioutil"
	"html/template"
)

type Page struct {
	Title    string
	Body     []byte
	Hostname string
}

func index(w http.ResponseWriter, r *http.Request) {
	filename := r.URL.Path[1:]
	fmt.Println(fmt.Sprintf("%s", filename))
	hostname, _ := os.Hostname()
	t, _ := template.ParseFiles("index.html")
	page := &Page{
		Title:    "hackathon 2017",
		Hostname: hostname,
	}
	t.Execute(w, page)
	//fmt.Fprintf(w, "Hackathon 2017.\n\nnHello: %s!\nhostname %s", r.URL.Path[1:], hostname)

}

func ping(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "pong!")
}

func readfile(w http.ResponseWriter, path string) {
	content, _ := ioutil.ReadFile(path)
	fmt.Fprint(w, string(content))
	fmt.Printf("read file %s on %s\n", path, w)
}

func voyages(w http.ResponseWriter, r *http.Request) {
	filename := r.URL.Path[1:]
	fmt.Println(fmt.Sprintf("%s", filename))
	readfile(w, fmt.Sprintf("%s", filename))
}

func images(w http.ResponseWriter, r *http.Request) {
	filename := r.URL.Path[1:]
	fmt.Println(fmt.Sprintf("%s", filename))
	readfile(w, fmt.Sprintf("%s", filename))
}

func main() {
	port := "8080"
	if (len(os.Args) > 1) {
		port = os.Args[1]
	}
	fmt.Printf("listen to %s\n", port)
	http.HandleFunc("/ping", ping)
	http.HandleFunc("/img/", images)
	http.HandleFunc("/", index)
	//http.HandleFunc("/", index)
	http.ListenAndServe(fmt.Sprintf(":%s", port), nil)
	fmt.Println("server started")
}
