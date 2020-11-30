package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
	"time"
)

func main() {
	template := "02.01.2006 15:04:05"

	text, _ := bufio.NewReader(os.Stdin).ReadString('\n')
	text = strings.TrimSpace(text)
	dates := strings.Split(text, ",")

	t1, _ := time.Parse(template, dates[0])
	t2, _ := time.Parse(template, dates[1])

	var diff time.Duration

	if t1.After(t2) {
		diff = t1.Sub(t2)
	} else {
		diff = t2.Sub(t1)
	}
	fmt.Println(diff)
}
