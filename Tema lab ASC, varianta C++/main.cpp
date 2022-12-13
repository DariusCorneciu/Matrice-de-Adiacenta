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

void matrix_mult(int n, int (*m1)[100],int (*m2)[100], int (*mres)[100]) //inmultire de matrici
    {
        int i,j,k;
        for(i=0;i<n;i++)
        {
            for(j=0;j<n;j++)
            {
                mres[i][j]=0;
            for(k=0;k<n;k++)
                mres[i][j]+=m1[i][k]*m2[k][j];
            }

        }
    }

void afis_matrice(int n, int (*matrice)[100]) //afirea unei matrici pe ecran
{
    int i,j;
         for(i=0; i<n; i++)
        {
            for(j=0;j<n;j++)
                cout<<matrice[i][j]<<' ';
            cout<<endl;
        }
}

void matrice_adiacenta(int n,int (*ma)[100], int *cleg,int *leg) //genererea de matrice adiacenta
{
     int i,j=0,panterior=0;
    for(i=0;i<n;i++)
       {
          if(i!=0)
            panterior+=cleg[i-1]; //suma legaturi
        for(j=j;j<panterior+cleg[i];j++) //j merge de la ultimul j la suma legaturilor actuale
            ma[i][leg[j]]=1; //adaug 1 pe lini i si numarul legaturi ex: matrice[0][3]=1;
       }


}

int main()
{
    int lista[100],n=0,lungime=0,i,j,matrice[100][100],m=0,panterior=0,ns=0,nd=0,lun=0,mr[100][100];

    citire(lista,n,lungime);
    cout<<"Exercitiul "<<n<<endl;
    n=lista[0];
    int cate_legaturi[100],legaturi[1000];
    for(i=1;i<=n;i++)
    cate_legaturi[i-1]=lista[i],m+=cate_legaturi[i-1];//m reprezinta cate legaruti sunt in total
   //pun [i-1] pentru ca elementele din lista sunt de la 1, iar eu in vector pun din 0
    for(i=n+1;i<lungime;i++)
    legaturi[i-(n+1)]=lista[i]; //legaturile sunt la finalul listei asa ca eu cand le bag in vector vreau sa le bag din poztia 0
    //n merge cu cate_legaturi
    j=0;
    matrice_adiacenta(n,matrice,cate_legaturi,legaturi);
    afis_matrice(n,matrice);
    ///CERINTA 2
    nd=lista[lungime-1];
    ns=lista[lungime-2];
    lun=lista[lungime-3];
    int matrice2[100][100],k;
    matrix_mult(n,matrice,matrice,mr);
    for(i=1;i<lun-1;i++)
    {
        for(j=0;j<n;j++)
            for(k=0;k<n;k++)
            matrice2[j][k]=mr[j][k];
         matrix_mult(n,matrice2,matrice,mr);
    }
    cout<<"Sunt exact "<<mr[ns][nd]<<" drumuri de lungime "<<lun<<" de la ("<<ns<<' '<<nd<<")";


        return 0;
}
