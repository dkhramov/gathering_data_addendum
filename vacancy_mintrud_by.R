library(httr)
res <- GET("http://vacancy.mintrud.by/",
            path = "/ru/applicant/search-jobs",
            query = list(profession="бухгалтер",at_page=312))
res$url # проверим URL составленного запроса
page <- content(res, as = "text", encoding = "UTF-8")

library(rvest)
hdoc <- read_html(page)

df <- hdoc %>% html_table() %>% .[[1]] # таблица всего одна и она первая в списке
df <- df[,-1]                          # удалим ненужный первый столбец
