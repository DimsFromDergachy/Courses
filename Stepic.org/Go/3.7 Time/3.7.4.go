package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
	"time"
)

func main() {
	text, _ := bufio.NewReader(os.Stdin).ReadString('\n')
	text = strings.TrimSpace(text)
	template := "2006-01-02 15:04:05"
	t, _ := time.Parse(template, text)
	if t.Hour() >= 13 {
		t = t.Add(24 * time.Hour)
	}
	fmt.Println(t.Format(template))
}
