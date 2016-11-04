library(RSelenium)
startServer()
rd <- remoteDriver(remoteServerAddr = "localhost",
                   port = 4444,
                   browserName="firefox")
rd$open()
url <- "http://vak.ed.gov.ru/dis-list"
rd$navigate(url)

page_from_browser <- rd$getPageSource()[[1]] # содержимое страницы из браузера

library(rvest)

path <- ".//*[@id='filter_def']/div[2]"      # путь к списку объявлений

# Структура из страницы, сохранённой в браузере
hdoc1 <- read_html(page_from_browser) %>% html_node(xpath = path)
from_browser <- capture.output(html_structure(hdoc1))

# Структура из страницы, сохранённой по HTTP-запросу
hdoc2 <- read_html(url) %>% html_node(xpath = path)
from_scraper <- capture.output(html_structure(hdoc2))
