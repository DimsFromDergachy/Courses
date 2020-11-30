package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
	"time"
)

const now = 1589570165
const templateDuration = "12 мин. 13 сек."
// const templatePrint = ""

func main() {
	text, _ := bufio.NewReader(os.Stdin).ReadString('\n')
	text = strings.TrimSpace(text)
	text = strings.ReplaceAll(text, " мин. ", "m")
	text = strings.ReplaceAll(text, " сек.", "s")

	duration, _ := time.ParseDuration(text)

	fmt.Println(time.Unix(now, 0).Add(duration).UTC().Format(time.UnixDate))
}
