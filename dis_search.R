# Поиск сообщений о защитах по заданной специальности.

spec_names <- "01.02.04"    # номер специальности
btime <- "01.01.2016"       # начало периода
etime <- "31.12.2016"       # конец периода

library("RSelenium")
startServer()
rd <- remoteDriver(remoteServerAddr = "localhost",
                   port = 4444,
                   browserName="firefox")
rd$open()
rd$setImplicitWaitTimeout(milliseconds = 10000)
rd$navigate("http://vak.ed.gov.ru/dis-list")

spec <- rd$findElement(using = "xpath", ".//*[@id='filter_def']/select[1]")

begin <- rd$findElement(using = "xpath", ".//*[@id='filter_def']/input[1]")
begin$clearElement()
begin$sendKeysToElement( list(btime,"\uE007") )

end <- rd$findElement(using = "xpath", ".//*[@id='filter_def']/input[2]")
end$clearElement()
end$sendKeysToElement( list(etime,"\uE007") )

links <- list()             # список ссылок на страницы с объявлениями о защите

# НАЧАЛО:Сбор данных по одной специальности

spec$sendKeysToElement( list(spec_names,"\uE007") )

repeat {
  
  res <- rd$findElements(using = "xpath", ".//*[@id='filtred']/table//a")
  
  if (length(res) > 0)  {
    cur <- sapply(res, function(x){x$getElementAttribute("href")})
    links <- append(links,cur)
    cur <- list()
  }
  
  next_btn <- rd$findElement(using = "xpath", ".//*[@id='filtred']/button[3]")
  
  if (!next_btn$isElementDisplayed()[[1]]) break
  next_btn$clickElement()
  
  Sys.sleep(1)
  
}

# КОНЕЦ:Сбор данных по одной специальности

