# Lumoflor 

## Spis treści:
```
  1.	Technologie w projekcie
  2.	Struktura katalogów
  3.	Funkcjonalności użytkownika
  4.	MFA (Multi-Factor Authentication)
  5.	Panel administratora
  6.	Jak uruchomić lokalnie
  7.  Baza danych, przykładowe rekordy i jej relacje
```
Lumoflor to jedyna w swoim rodzaju strona, gdzie kupisz magiczne rośliny! Produkty pochodzą ze 100% legalnego źródła i są regularnie uzupełniane.  Stronę Lumoflor można uruchomić wchodząc na [oficjalną stronę internetową](https://misklep.tymi.org/login.html) bądź uruchamiając projekt lokalnie (więcej o tym w rozdziale 6)

# Technologie w projekcie

## Języki użyte przy tworzeniu strony:
• Frontend: HTML + JS (czysty, bez framework  

•Backend/API: PHP  

•Baza danych: MySQL (XAMPP)  

•Autoryzacja: Własna MFA (dwuskładnikowe)

## Struktura katalogów

api/           - endpointy backendowe w PHP  

FrontEnd/      - frontend sklepu i panel admina  

db/            - plik .sql do importu (struktura bazy)  

.env.example   - przykładowy plik konfiguracyjny  

README.md      - dokumentacja projektu

## Funkcjonalności Użytkownika

•	Rejestracja i logowanie  

•	Włączenie MFA (logowanie dwuetapowe)  
 
•	Przeglądanie oferty sklepu (produkty)  

•	Dodawanie do koszyka  

•	Dostęp do inventory (zakupione przedmioty)  

•	Edycja profilu (opis i avatar)


## MFA (Multi-Factor Authentication)

Po aktywacji MFA użytkownik musi dodatkowo podać kod jednorazowy przy logowaniu.
Zrobione w czystym JS bez żadnych bibliotek.

## Panel administratora

Wszystko zrobione w HTML i JS
Admin ma dostęp do:  

⁃	Dodawania, edytowania i usuwania produktów  
 
⁃	Zarządzania kategoriami  
 
⁃	Przeglądania kont użytkowników•	Przeglądania logów systemowych (np. kto co zrobił)  
 

## Jak uruchomić lokalnie

Poniżej znajduje się instrukcja jak uruchomić projekt lokalnie w 5 prostych krokach
```
1.	Sklonuj repozytorium: git clone https://github.com/MistycznySklep/MistycznySklep.git
2.	Uruchom XAMPP lub inny edytor
3.	W phpMyAdmin utwórz bazę danych o nazwie lumoflor i zaimportuj plik SQL z folderu db/
4.	Skopiuj plik .env.example do .env i wstaw odpowiednie dane
```
```env
DB_HOST=
DB_USER=
DB_PASSWORD=
DB_NAME=
```
```
5.	Otwórz FrontEnd/index.html w przeglądarce i przetestuj działanie

```
## Baza danych, przykładowe rekordy i diagram encji
![image](https://github.com/user-attachments/assets/2c1fca6d-83ec-4b76-ae01-a0735379e671)
![image](https://github.com/user-attachments/assets/a7e84dbe-b5bb-4105-a4a7-ec5b5135783f)
w folderze db znajduje się plik `lumoflor_database.sql`, który zawiera całą bazę danych


