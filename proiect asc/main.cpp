#include <iostream>
#include <fstream>
using namespace std;
ifstream f("intrari.in");
void citire(int *lista, int &n, int &lungime) //citire basic din fisier
{
    f>>n;
    int i=0,m;
    while(f>>m)
    {
        lista[i]=m;
        i++;
    }
    lungime=i;
    f.close();
}

int main()
{
    int lista[100],n=0,lungime=0,i,j,matrice[100][100],m=0,panterior=0;

    citire(lista,n,lungime);
    cout<<"Exercitiul "<<n<<endl;
    n=lista[0];
    for(i=0; i<n; i++)
        for(j=0; j<n; j++)
            matrice[i][j]=0; // fac matricea de adiacenta initial 0

    int cate_legaturi[100],legaturi[1000];
    for(i=1;i<=n;i++)
    cate_legaturi[i-1]=lista[i],m+=cate_legaturi[i-1];//m reprezinta cate legaruti sunt in total
   //pun [i-1] pentru ca elementele din lista sunt de la 1, iar eu in vector pun din 0
    for(i=n+1;i<lungime;i++)
    legaturi[i-(n+1)]=lista[i]; //legaturile sunt la finalul listei asa ca eu cand le bag in vector vreau sa le bag din poztia 0
    //n merge cu cate_legaturi
    j=0;

    for(i=0;i<n;i++)
       {
          if(i!=0)
            panterior+=cate_legaturi[i-1]; //suma legaturi
        for(j=j;j<panterior+cate_legaturi[i];j++) //j merge de la ultimul j la suma legaturilor actuale
            matrice[i][legaturi[j]]=1; //adaug 1 pe lini i si numarul legaturi ex: matrice[0][3]=1;
       }

       //afisare matrice adiacenta
     for(i=0; i<n; i++)
        {
            for(j=0;j<n;j++)
                cout<<matrice[i][j]<<' ';
            cout<<endl;
        }


        return 0;
}
