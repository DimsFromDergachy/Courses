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
	t, _ := time.Parse(time.RFC3339, text)
	fmt.Println(t.Format(time.UnixDate))
}