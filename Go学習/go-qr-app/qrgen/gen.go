package qrgen

import (
	"bytes"
	"image"
	"image/png"

	"github.com/boombuler/barcode"
	"github.com/boombuler/barcode/qr"
)

// @param [byte]
// @return [Image, err]
// @note バーコードのpng
func CreateImage(b []byte) (image.Image, error) {
	return png.Decode(bytes.NewReader(b))
}

// @param [String] url
// @return [Barcode, err]
// @note バーコードのオブジェクトを返す
func GenQRCode(url string) (barcode.Barcode, error) {
	qrCode, err := qr.Encode(url, qr.M, qr.Auto)
	if err != nil {
		return nil, err
	}

	return barcode.Scale(qrCode, 200, 200)
}
