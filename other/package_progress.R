# package_progress.R
# Przykłady wykorzystania paczki 'progress'

# Instalacja (jeśli jeszcze nie zainstalowano):
# install.packages("progress")

library(progress)

# ==============================================================================
# PRZYKŁAD 1: Podstawowy pasek postępu
# Najprostsza implementacja z domyślnymi ustawieniami.
# ==============================================================================
cat("\nPrzykład 1: Podstawowy pasek\n")
pb1 <- progress_bar$new(total = 100)

for (i in 1:100) {
  pb1$tick() # Aktualizuje pasek o 1 krok
  Sys.sleep(0.02) # Symulacja pracy
}

# ==============================================================================
# PRZYKŁAD 2: Pasek z czasem upływającym, procentami i szacowanym czasem (ETA)
# Zgodnie z możliwościami paczki, możemy dodawać własne tagi informacyjne.
# Pasek nie znika po zakończeniu (clear = FALSE).
# ==============================================================================
cat("\nPrzykład 2: Złożony pasek (Procent, Czas, ETA)\n")
pb2 <- progress_bar$new(
  format = "  Obliczanie [:bar] :percent | Czas: :elapsed | ETA: :eta",
  total = 100, 
  clear = FALSE, # Zostawia pasek w konsoli po skończeniu
  width = 75     # Ustalona szerokość paska
)

for (i in 1:100) {
  pb2$tick()
  Sys.sleep(0.05)
}

# ==============================================================================
# PRZYKŁAD 3: Własne znaki na pasku postępu (Custom characters)
# Możemy zmienić domyślne znaki "=" na cokolwiek innego.
# ==============================================================================
cat("\nPrzykład 3: Niestandardowe znaki postępu\n")
pb3 <- progress_bar$new(
  format = "  Pobieranie [:bar] :percent",
  total = 50,
  complete = "+",   # Znak dla ukończonej części
  incomplete = "-", # Znak dla nieukończonej części
  current = ">",    # Znak dla aktualnej pozycji (grot)
  clear = TRUE
)

for (i in 1:50) {
  pb3$tick()
  Sys.sleep(0.05)
}

# ==============================================================================
# PRZYKŁAD 4: Pasek postępu z dynamicznym tekstem (Tokens)
# Idealne, gdy iterujemy po plikach lub zmiennych i chcemy wyświetlać ich nazwy.
# ==============================================================================
cat("\nPrzykład 4: Dynamiczne nazwy elementów (Tokens)\n")
nazwy_plikow <- c("dane_Q1.csv", "dane_Q2.csv", "dane_Q3.csv", "dane_Q4.csv")
pb4 <- progress_bar$new(
  format = "  Przetwarzanie pliku: :plik [:bar] :percent",
  total = length(nazwy_plikow)
)

for (plik in nazwy_plikow) {
  # Przekazujemy aktualną wartość do tokena ':plik'
  pb4$tick(tokens = list(plik = plik))
  Sys.sleep(0.8) # Symulacja dłuższego przetwarzania pliku
}

# ==============================================================================
# PRZYKŁAD 5: Aktualizacja paska o niestandardowy skok (Więcej niż 1 jednostka)
# Przydatne, gdy w jednym kroku pętli przetwarzamy paczkę danych (np. 100 wierszy).
# ==============================================================================
cat("\nPrzykład 5: Aktualizacja o większy krok (Batch processing)\n")
calkowita_liczba_wierszy <- 1000
rozmiar_paczki <- 100

pb5 <- progress_bar$new(
  format = "  Przetwarzanie wierszy [:bar] :current/:total (:percent)",
  total = calkowita_liczba_wierszy
)

# Symulacja przetwarzania 1000 wierszy w paczkach po 100
for (i in 1:(calkowita_liczba_wierszy / rozmiar_paczki)) {
  pb5$tick(rozmiar_paczki) # Pasek przesuwa się od razu o 100 jednostek
  Sys.sleep(0.3)
}


# ==============================================================================
# PRZYKŁAD 5a: Aktualizacja paska o niestandardowy skok (Więcej niż 1 jednostka)
# Przydatne, gdy w jednym kroku pętli przetwarzamy paczkę danych (np. 100 wierszy).
# =============================================================================

library(crayon) # Wczytujemy pakiet odpowiedzialny za kolory

cat("\nPrzykład 5a: Aktualizacja o większy krok z ZIELONYM I CZERWONYM KOLOREM\n")
calkowita_liczba_wierszy <- 1000
rozmiar_paczki <- 100

# Tworzymy pasek postępu, używając crayon::green() do pokolorowania formatu
pb5a <- progress_bar$new(
   format = crayon::green("  Przetwarzanie wierszy ") %+% crayon::red("[:bar]") %+% crayon::green(":current/:total (:percent)"),
   total = calkowita_liczba_wierszy,
   clear = FALSE
)

# Symulacja przetwarzania 1000 wierszy w paczkach po 100
for (i in 1:(calkowita_liczba_wierszy / rozmiar_paczki)) {
  pb5a$tick(rozmiar_paczki) # Pasek przesuwa się od razu o 100 jednostek
  Sys.sleep(0.3)
}
