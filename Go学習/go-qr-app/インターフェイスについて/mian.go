package main

import "fmt"

type Reporter interface {
	Report() string
}

type WeatherInfo struct {
	temperature int
	weather     string
}

func (w *WeatherInfo) Report() string {
	return fmt.Sprintf("天気: %s, 気温: %v度", w.weather, w.temperature)
}

type StockInfo struct {
	average int
}

func (s *StockInfo) Report() string {
	return fmt.Sprintf("平均株価: %v円", s.average)
}

func PrintNews(r Reporter) {
	fmt.Printf("今日のニュースです。%s\n", r.Report())
}

func main() {
	w := &WeatherInfo{
		temperature: 20,
		weather:     "晴れ",
	}
	PrintNews(w)
	// => 今日のニュースです。 天気: 晴れ, 気温: 20度

	s := &StockInfo{
		average: 30000,
	}
	PrintNews(s)
	// => 今日のニュースです。平均株価: 30000円

	// PrintNews("エラー")
	// 下記のようなコンパイルエラーになる
	// cannot use "エラー" (type string) as type Reporter in argument to PrintNews:
	// string does not implement Reporter (missing Report method)

}
