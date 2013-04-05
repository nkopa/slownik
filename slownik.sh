#!/bin/bash

#menu
function menu {
	echo
	echo Co chcesz zrobic?
	echo 1 Znalezc haslo
	echo 2 Dodac wpis
	echo 3 Usunac wpis
	echo 4 Wyjsc
	echo
	echo Podaj liczbe:
	read corobic

	while [ $corobic != 1 ] && [ $corobic != 2 ] && [ $corobic != 3 ] && [ $corobic != 4 ]
	do
		echo
		echo Nie rozumiem.
		echo
		echo Co chcesz zrobic? 
		echo 1 Znalezc haslo
		echo 2 Dodac wpis
		echo 3 Usunac wpis
		echo 4 Wyjsc
		echo
		echo Podaj liczbe:
		read corobic
	done;

	if [ $corobic = 1 ]
	then
		ZnalezcHaslo $corobic #potrzebne do wyboru drogi w tej funkcji
	fi

	if [ $corobic = 2 ]
	then
		echo
		echo Jakie haslo chcesz dodac?
		read haslo
		CzyIstnieje $haslo
	fi

	if [ $corobic = 3 ]
	then
		ZnalezcHaslo $corobic
	fi

}

#czy istnieje
function CzyIstnieje {
	
	cat slownik.txt | grep -i -w ^$1 > spr.txt #dopasowanie wzorca do pełnych słów
	wc -l spr.txt | cut -d ' ' -f 1 > wynik.txt #sprawdza ile znakow
	wynik=`cat "wynik.txt"`
	
	if [ $wynik != 0 ] #co gdy haslo juz istnieje
	then
		echo Takie haslo juz istnieje.
		echo "Czy chcesz dopisac kolejny opis do tego hasla?"
		echo
		echo 1 Tak
		echo 2 Nie
		echo
		echo Podaj liczbe:
		read codalej
							#co robic dalej - pisac czy nie 
		while [ $codalej != 1 ] && [ $codalej != 2 ] 
		do
			echo 
			echo Nie rozumiem.
			echo
			echo "Czy chcesz dopisac kolejny opis do tego hasla?"
			echo
			echo 1 Tak
			echo 2 Nie
			echo
			echo Podaj liczbe:
			read codalej
		done
	fi

	rm spr.txt #usuwanie smieci
	rm wynik.txt

	if [ $codalej = 1 ]
	then 
		let wynik=wynik+1
		DodacWpis $1 $wynik
	fi

	if [ $codalej = 2 ]
	then
		menu
	fi
	
}

#znalezc haslo
function ZnalezcHaslo {
	echo 
	echo Podaj haslo
	read haslo
	echo

	
	cat slownik.txt | grep -i -w ^$haslo

	echo
	echo Wcisnij Enter
	read

	if [ $1 = 1 ]
	then
		menu
	fi

	if [ $1 = 3 ]
	then
		UsunWpis $haslo
	fi
}

#dadac wpis
function DodacWpis {

	echo
	echo Podaj opis hasla
	read opis

	echo $1'('$2')' - $opis >> slownik.txt
	sort slownik.txt > slownik1.txt
	rm slownik.txt
	mv slownik1.txt slownik.txt

	menu
}

#usunac wpis
function UsunWpis {

	echo 
	echo Ktore haslo usunac - podaj numer w nawiasach '('aby anulowac wcisnij Enter')'
	read numer

	cat slownik.txt | grep -i -v ^$1'('$numer')' > slownik1.txt #przepisuje to, co nie pasuje do wzorca
	cat slownik1.txt > slownik.txt

	rm slownik1.txt #usuwanie smieci
	menu

}

menu


