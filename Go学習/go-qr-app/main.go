package main

import (
	"flag"
	"fmt"
	"image/png"
	"os"

	"go-qr-app/qrgen"
)

func main() {
	outputPath := flag.String("o", "./image.png", "Path to output file")
	flag.Parse()
	url := flag.Arg(0)
	if url == ""{
		fmt.Println("URL is empty")
		return
	}

	// note
	// outputPathが*なのは、上記のflag.Stringの戻り値がポインターだから
	file, err := os.Create(*outputPath)
	if err != nil {
		fmt.Printf("file generation failed: %v\n", err)
		return
	}
	defer file.Close()

	img, err := qrgen.GenQRCode(url)
	if err != nil {
		fmt.Printf("image generation failed: %v\n", err)
		return
	}

	png.Encode(file, img)
}
