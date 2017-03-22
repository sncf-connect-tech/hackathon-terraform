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
	hostname, _ := os.Hostname()
	t, _ := template.ParseFiles(fmt.Sprintf("%s/index.html", path))
	page := &Page{
		Title:    "hackathon 2017",
		Hostname: hostname,
	}
	t.Execute(w, page)
}

func ping(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "pong!")
}

func readfile(w http.ResponseWriter, path string) {
	content, _ := ioutil.ReadFile(path)
	fmt.Fprint(w, string(content))
	fmt.Printf("read file %s on %s\n", path, w)
}

func images(w http.ResponseWriter, r *http.Request) {
	filename := r.URL.Path[1:]
	fmt.Println(fmt.Sprintf("%s/%s", path, filename))
	readfile(w, fmt.Sprintf("%s/%s", path, filename))
}

var (
	path = "./"
)

func main() {
	if (len(os.Args) > 1) {
		path = os.Args[1]
	}
	fmt.Printf("listen to 8080, static path are in %s\n", path)
	http.HandleFunc("/ping", ping)
	http.HandleFunc("/img/", images)
	http.HandleFunc("/", index)
	//http.HandleFunc("/", index)
	http.ListenAndServe(":8080", nil)
	fmt.Println("server started")
}
