# R intro

Proste materiały pomocnicze wykorzystywane podczas zajęć wprowadzających do środowiska R.

## Początki

Pracę ze środowiskiem R najlepiej rozpocząć od instalacji najnowszej dystrybucji tego narzędzia ze strony [cran](http://cran.r-project.org/) - centralnego repozytorium pakietów R. Warto również rozważyć ściągnięcie graficznego środowiska (IDE), które w znacznym stopniu może usprawnić pracę. Jednym z najbardziej popularnych jest [R Studio](http://www.rstudio.com/), są również inne możliwości takie, jak [StatET](http://www.walware.de/goto/statet), [ESS](http://ess.r-project.org/), [Deducer](http://www.deducer.org/pmwiki/pmwiki.php?n=Main.DeducerManual), [R Commander](http://socserv.mcmaster.ca/jfox/Misc/Rcmdr/) czy też wtyczka do [Sublime Text](http://tomschenkjr.net/using-sublime-text-2-for-r/).

W kolejnym kroku najlepiej przerobić materiał któregoś z dostępnych przewodników po R, jak choćby:

- [kurs datacamp](https://www.datacamp.com/courses/free-introduction-to-r),
- [Advanced R](http://adv-r.had.co.nz/),
- [R Introduction](http://cran.r-project.org/doc/manuals/R-intro.pdf),
- [R Tutorial](http://www.cyclismo.org/tutorial/R/),
- czy też jedną z [dostępnych prezentacji](http://www.slideshare.net/search/slideshow?searchfrom=header&q=R+introduction) pokazujących możliwości języka.

Przydatna może okazać się również "[ściągawka](http://cran.r-project.org/doc/contrib/Baggott-refcard-v2.pdf)" zestawiająca najważniejsze informacje w jednym miejscu.


## Przydatne pakiety
Kod R podzielony jest na pakiety, które instalujemy funkcją `install.packages`.
Po zainstalowaniu, z pakietu można korzystać:
1. importując go komendą `library` lub `require`
```R
library(ggplot2)
ggplot()
```
2. prefiksując wywołanie nazwą pakietu:
```R
ggplot2::ggplot()
```

### Wczytywanie plików CSV

`data.table`
```R
train_df <- data.table::fread('data/train.csv')

# lub 
library(data.table)
train_df <- fread('data/train.csv')
```

`readr`
```R
train_df <- readr::read_csv('data/train.csv')
```

### Przetwarzanie kolekcji
- [plyr](http://www.slideshare.net/hadley/01-intro-1690565) - ułatwia operacje na listach, tablicach i ramkach danych


### Praca z ramkami danych

- [dplyr](http://blog.rstudio.org/2014/01/17/introducing-dplyr/) - wygodne operacje na "ramkach" (data.frame)

```R
library(dplyr)
train_df <- readr::read_csv('data/train.csv')

train_df %>%
  filter(!is.na(Age)) %>%
  group_by(Sex,Pclass) %>%
  summarise(OldestPassanger = max(Age)) %>%
  arrange(desc(OldestPassanger))
```


### Wykresy
- [ggplot2](http://ggplot2.org/) - pakiet do rysowania wykresów bazujący na wygodnej w użyciu gramatyce do tworzenia grafik

```R
library('bigvis'); library('ggplot2')
myd <- condense(bin(diamonds$carat, .1),
                z=diamonds$price, summary="mean")

ggplot(myd, aes(x=diamonds.carat, y=.mean)) + geom_line() +  
         ylab("Avg Price") + xlab("Carats")
```


### Daty

- [lubridate](http://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html) - bardziej cywilizowany sposób operowania na datach


```R
library(lubridate)
ymd("2011/06/04")
ymd("2011 06 04")
ymd("2011-06-04")
```


### Programowanie funkcyjne
Pakiet `purrr`
```R
lst <- list(1:100, 2:10, 3:5)
lst %>% purrr::map(length)
```

### Testy jednostkowe
- [testthat](http://r-pkgs.had.co.nz/tests.html) - umożliwia pisanie testów jednostkowych do swoich pakietów/funkcji


### Generowanie raportów
- [knitr](http://yihui.name/knitr/) - umożliwia generowanie raportów (np. z wykonanych w ramach projektu eksperymentów)


### "Niezbędnik"
Pracę z R wygodnie można rozpocząć importując pakiet `tidyverse`, który zawiera szereg przydatnych narzędzi - m.in. wspomniane już `ggplot2`, `dplyr` oraz `readr` jak również:

- tibble - ulepszona wersja ramek danych (`data.frame`),
- tidyr - pakiet do transformacji ramek danych,
- stringr - operacje na ciągach znaków,
- forcats - narzędzia do pracy ze zmiennymi dyskretnymi.


## Ćwiczenia praktyczne

1. Dane są następujące obiekty:
```R
v1 = c("2000.02.03 24:00", "2010.12.30 19:23", "2015.01.01 20:14")
v2 = "23-12-1998"
v3 = list("1900.02.03", "1920.12.30")
v4 = "1984-12-24"
```
  - Przekonwertuj obiekt `v1,v2,v3` do postaci dat - zakładając strefę czasową 'CET'.
  - Wyciągnij numery dni tygodnia dla dat zapisanych w `v1`.
  - Czy rok `v4` jest przestępny?
  - Ile minut minęło pomiędzy `v4`, a `v2`?

2. Znajdź minimum funkcji: $$y = \frac{1}{2}x^2 - 3\sqrt{x} + 2$$
3. Dla zbioru danych iris (`data(iris)`) wygeneruj następujące wykresy:
```R
require(ggplot2)
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color = Species)) + geom_point()
ggplot(iris, aes(x=Sepal.Width, y=Petal.Width)) + geom_point() + facet_wrap(~Species) +theme_bw()
```

4. Dla zbioru danych CO2 (`data(CO2)`) wygeneruj ramkę danych zawierającą informacje o tym ile w każdej z obu lokalizacji było roślin pochłaniających więcej dwutlenku węgla niż wynosi wartość średnia dla całego zbioru:
```R
require(dplyr)
CO2 %>%
  filter(uptake > mean(uptake)) %>%
  group_by(Type) %>%
  summarise(Plant.Count = length(uptake))
```

5. Dana jest lista l:
```R
l <- list(1:10, 2:20, 3:30, 4:40, 5:50, rnorm(1000, 20, 30))
```
  wygeneruj dla niej ramkę danych zawierającą średnie i odchylenia standardowe dla poszczególnych jej elementów:
```R
require(plyr)
ldply(l, function(v) data.frame(Mean=mean(v), SD=sd(v)))
```
