package main

import (
	"net/http"
	"os"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {

	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/", func(c echo.Context) error {
		return c.HTML(http.StatusOK, "Hello, Golang!")
	})


	httpPort := os.Getenv("HTTP_PORT")
	if httpPort == "" {
		httpPort = "8003"
	}

	e.Logger.Fatal(e.Start(":" + httpPort))
}