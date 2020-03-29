# Aktywne reguly:
1.  Usunięcie nieopłaconych wypożyczeń
	- **Opis:** Reguła ma na celu usunięcie nieopłaconych wypożyczeń
	- **Zdarzenia inicjujace:** Nowy miesiąc
	- **Warunki uruchomienia:** miesiące różne od stycznia, ze względu na inwentaryzacje.
	- **Dzialanie:** Sprawdzamy wypożyczenia, które nie mają płatności, następnie sprawdzamy czy są one starsze niż 3 miesiące. Jeśli tak to usuwamy je.
	- **Szacunek zlozonosci:** Złączenie tabel rental oraz payment, wyszukanie po dacie, usunlięcie	
	- **Mechanizmy:** Asercje, triggery
2.  Zablokowanie możliwości wypożyczenia więcej niż 3 filmów dla użytkownika, który jest utworzony mniej niż rok temu:
	- **Opis:** Reguła służy zablokowaniu wypożyczenia dużej liczby filmów dla nowych użytkowników
	- **Zdarzenia inicjujace:** Dodanie nowego wiersza Rental
	- **Warunki uruchomienia:** liczba wypożyczeń użytkownika jest większa niż 3.
	- **Dzialanie:** Usuwamy dodany wiersz Rental.
	- **Szacunek zlozonosci:** Połączenie tabel customer oraz rental, zliczenie wyników i usunięcie wiersza
	- **Mechanizmy:** Asercje, triggery
3.  Ustawienie zniżki 30% dla wszystkich niezapłaconych zamówień przyjętych przez pracowników danego sklepu w ostatnich 7 dniach
	- **Opis:** Reguła służy do przeprowadzania szybkich promocji w danych oddziałach
	- **Zdarzenia inicjujace:** Na żądanie
	- **Warunki uruchomienia:** brak dodatkowych warunków
	- **Dzialanie:** Dla wszystkich płatności, które spełniają warunki, gdzie payment_date jest pusty, zmniejszamy wartość amount o 30%;
	- **Szacunek zlozonosci:** połączenie tabel Payment, Staff oraz Store, wyszukanie zamówień z odpowiednią datą, modyfikacja pola.
	- **Mechanizmy:** Asercje, triggery
4.  Dodanie zniżki dla użytkownika, który wypożyczył ponad 10 filmów
	- **Opis:** Reguła ma za zadanie nadawać dodatkowe zniżki dla stałych klientów
	- **Zdarzenia inicjujace:** Dodanie wiersza w tabeli Rental
	- **Warunki uruchomienia:** użytkownik wypożyczył ponad 10 filmów
	- **Dzialanie:** W dodawanym wierszy Payment obniżamy pole amount o 30%.
	- **Szacunek zlozonosci:** Złączenie tabel customer oraz rental, grupowanie i zliczenie.
	- **Mechanizmy:** Asercje, triggery
5.  Dodanie wypożyczeń tylko dla aktywnego użytkownika.
	- **Opis:** Reguła sprawdza, czy wypożyczenie dotyczy aktywnego użytkownika.
	- **Zdarzenia inicjujace:** Dodanie wiersza do Rental.
	- **Warunki uruchomienia:** brak dodatkowych warunków
	- **Dzialanie:** Przy dodawaniu wypozyczenia sprawdzane jest, czy dotyczy ono aktywnego użytkownika.
	- **Szacunek zlozonosci:** Połączenie tabel rental i user oraz sprawdzenie warunku active
	- **Mechanizmy:** Asercje, triggery