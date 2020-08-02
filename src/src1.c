#include <stdio.h>
#include <stdlib.h>
#include <winsock2.h>
#include <windows.h>

void printRandoms(int lower, int upper,  
                             int count) 
{ 
    int i; 
    for (i = 0; i < count; i++) { 
        int num = (rand() % 
           (upper - lower + 1)) + lower; 
	printf("%d ", num); 
    } 
} 
int **Pais,P,D,i,n,result; //P = Paises / D = Dias

void lol()
{
	P += 1;
	D += 1;

	Pais = (int**)calloc(P, sizeof(int*));//Aloca a memoria de Pais com o tamanho da variavel P
	for (i = 0; i < P; i++) Pais[i] = (int*)calloc(D, sizeof(int)); //Faz loop por todas as linhas alocando as colunas (os dias)
}
