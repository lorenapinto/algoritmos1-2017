#include "stdafx.h"
#include <iostream>
#include "conio.h"
#include "stdio.h"
#include "stdlib.h"
#include <string>

using namespace std;

void ALTA_SECUENCIAL(void);
void LISTADO_SECUENCIAL(void);
void MODIFICACION_SECUENCIAL(void);
void CONSULTA_SECUENCIAL(void);
void BAJA_FISICA_SECUENCIAL(void);
void BAJA_LOGICA_SECUENCIAL(void);

struct tipo_registro{
	int no_empresa;
	string nombre;
	string direccion;
	int telefono;
	string localidad;
};

tipo_registro Registro;
FILE *alias;

void main()
{
	int opcion;
	do{
		cout<<"         MENU"<<endl;
		cout<<"(1) Adicionar informacion sobre una empresa"<<endl;
		cout<<"(2) Listado de empresas que prestan el servicio"<<endl;
		cout<<"(3) modificado de datos de una empresa "<<endl;
		cout<<"(4) consulta de los datos de una empresa"<<endl;
		cout<<"(5) borrado de los datos de una empresa"<<endl;
		cout<<"(0) SALIR"<<endl;
		cout<<endl;
		cout<<"ingrese una opcion de la accion a realizar"<<endl;
		cin>>opcion;
		switch(opcion)
		{
		case 1:
			{
				ALTA_SECUENCIAL();
				break;
			}
		case 2:
			{
				LISTADO_SECUENCIAL();
				break;
			}
		case 3:
			{
				MODIFICACION_SECUENCIAL();
				break;
			}
		case 4:
			{
				CONSULTA_SECUENCIAL();
				break;
			}
		case 5:
			{
				BAJA_LOGICA_SECUENCIAL();
				break;
			}
		case 0:
			{
				cout<<"salir"<<endl;
				break;
			}
		default:
			{
				cout<<"opcion invalida"<<endl;
				break;
			}
		}
	}while(opcion!=0);
	getch();

}
void ALTA_SECUENCIAL(void) 
{ 
	
  int no_empresa; 
  cout << "\n\rADICION DE REGISTROS DE EMPRESAS"; 
  alias=fopen("EMPRESAS.SEC","rb+");
  if(alias==NULL) 
    alias=fopen("EMPRESAS.SEC","wb");
  cout << "\n\n\n\rNumero de empresa: "; 
  cin >> no_empresa; 
  fread(&Registro,sizeof(Registro),1,alias);  
  while(!feof(alias)) 
  { 
    if(Registro.no_empresa==no_empresa) 
    { 
       cout << "\n\n\n\rRegistro duplicado !!!"; 
       fclose(alias); 
       getch(); 
       return; 
    } 
    fread(&Registro,sizeof(Registro),1,alias); 
  } 
  cout << "\n\rNombre     : "; 
  cin.ignore();
  getline(cin, Registro.nombre);
  cin.ignore();
  cout << "\n\rDireccion: "; 
  getline(cin,Registro.direccion); 
  cout << "\n\rTelefono   : "; 
  cin >> Registro.telefono; 
  cout << "\n\rLocalidad     : "; 
  cin.ignore();
  getline(cin,Registro.localidad); 
  Registro.no_empresa=no_empresa; 
  fwrite(&Registro,sizeof(Registro),1,alias); 
  fclose(alias);  
  cout << "\n\n\n\rEmpresa registrada !"; 
  cout << "\n\r<<< Oprima cualquier tecla para continuar >>>"; 
  getch(); 
  return; 
} 

void LISTADO_SECUENCIAL(void) 
{ 
  cout << "\n\rLISTADO DE EMPRESAS REGISTRADAS"; 
  alias=fopen("EMPRESAS.SEC","rb"); 
  if(alias==NULL) 
  { 
    cout << "\n\n\n\rNo existe el archivo."; 
    cout << "\n\r<<< Oprima cualquier tecla para continuar >>>"; 
    getch(); 
    return; 
  } 
  cout<< "\n\rNo Empresa       Nombre              Direccion                Telefono    Localidad "<<endl; 
  cout << "\n\r---------------------------------------------------------------------------------------"<<endl; 
  fread(&Registro,sizeof(Registro),1,alias); 
  while(!feof(alias)) 
  { 
	  cout<<Registro.no_empresa<<"\t""\t"<<Registro.nombre<<"\t""\t"<<Registro.direccion<<"\t""\t"<<Registro.telefono<<"\t""\t"<<Registro.localidad<<endl; 
	  fread(&Registro,sizeof(Registro),1,alias); 
  } 
  fclose(alias);
 cout << "\n\r---------------------------------------------------------"; 
  cout << "\n\rFin del listado !!!"; 
  cout << "\n\r<<< Oprima cualquier tecla para continuar >>>"; 
  getch(); 
  return; 
}

void MODIFICACION_SECUENCIAL(void) 
{ 
  int no_empresa; 
  cout << "\n\rMODIFICACION DE EMPRESAS REGISTRADAS"; 
  alias=fopen("EMPRESAS.SEC","rb+");
  if(alias==NULL) 
  { 
    cout << "\n\n\n\rNo existe el archivo !!!"; 
    cout << "\n\r<<< Oprima cualquier tecla para continuar >>>"; 
    getch(); 
    return; 
  } 
  cout << "\n\n\n\rNumero de empresa: "; 
  cin >> no_empresa; 
  fread(&Registro,sizeof(Registro),1,alias); 
  while(!feof(alias)) 
  { 
    if(Registro.no_empresa==no_empresa) 
    { cin.ignore();
      cout<< "\n\rNo Empresa       Nombre              Direccion                Telefono    Localidad "<<endl;
      cout << "\n\r------------------------------------------------------------------------------------"<<endl; 
	  cout<<Registro.no_empresa<<"\t""\t"<<Registro.nombre<<"\t""\t"<<Registro.direccion<<"\t""\t"<<Registro.telefono<<"\t""\t"<<Registro.localidad<<endl;
	  cout << "\n\n\n\rAnote los nuevos datos ..."; 
	  cout << "\n\rNombre     : "; 
	  cin.ignore();
	  getline(cin, Registro.nombre);
	  cin.ignore();
	  cout << "\n\rDireccion: "; 
	  getline(cin,Registro.direccion); 
	  cout << "\n\rTelefono   : "; 
	  cin >> Registro.telefono; 
	  cout << "\n\rLocalidad     : "; 
	  cin.ignore();
	  getline(cin,Registro.localidad);  
      fseek(alias,ftell(alias)-sizeof(Registro),SEEK_SET); 
      fwrite(&Registro,sizeof(Registro),1,alias);
      fclose(alias);  
      cout << "\n\n\n\rRegistro de empresa modificado !!!"; 
      cout << "\n\r<<< Oprima cualquier tecla para continuar >>>"; 
      getch(); 
      return; 
    } 
    fread(&Registro,sizeof(Registro),1,alias); 
  } 
  cout << "\n\rNo se encuentra ese registro !!!"; 
  fclose(alias); 
  cout << "\n\r<<< Oprima cualquier tecla para continuar >>>"; 
  getch(); 
  return; 
} 

void CONSULTA_SECUENCIAL(void) 
{ 
  int no_empresa; 
  cout << "\n\rCONSULTA DE REGISTROS DE PRODUCTOS"; 
  alias=fopen("EMPRESAS.SEC","rb"); // Intenta abrir el archivo PRODUCTO.SEC 
                             // en modo de solo lectura 
  if(alias==NULL) 
  { 
    cout << "\n\n\n\rNo existe el archivo !!!"; 
    cout << "\n\r<<< Oprima cualquier tecla para continuar >>>"; 
    getch(); 
    return; 
  } 
  cout << "\n\n\n\rNumero de empresa: "; 
  cin >> no_empresa; 
  fread(&Registro,sizeof(Registro),1,alias);
  while(!feof(alias))  
  { 
    if(Registro.no_empresa==no_empresa) 
    { 
      cout<< "\n\rNo Empresa       Nombre              Direccion                Telefono    Localidad "<<endl;
      cout << "\n\r------------------------------------------------------------------------------------"<<endl; 
	  cout<<Registro.no_empresa<<"\t""\t"<<Registro.nombre<<"\t""\t"<<Registro.direccion<<"\t""\t"<<Registro.telefono<<"\t""\t"<<Registro.localidad<<endl;
      fclose(alias); 
      cout << "\n\r<<< Oprima cualquier tecla para continuar >>>"; 
      getch(); 
      return; 
    } 
    fread(&Registro,sizeof(Registro),1,alias); 
  } 
  cout << "\n\rNo se encuentra ese registro !!!"; 
  fclose(alias); 
  cout << "\n\r<<< Oprima cualquier tecla para continuar >>>"; 
  getch(); 
  return; 
} 

void BAJA_LOGICA_SECUENCIAL(void) 
{ 
  int no_empresa;  
  char op;  
  cout << "\n\rBAJAS LOGICAS DE EMPRESAS REGISTRADAS"; 
  alias=fopen("EMPRESAS.SEC","rb+");
  if(alias==NULL)
  { 
    cout << "\n\n\n\rNo existe el archivo !!!"; 
    cout << "\n\r<<< Oprima cualquier tecla para continuar >>>"; 
    getch(); 
    return; 
  } 
  cout << "\n\n\n\rNumero de empresa: "; cin >> no_empresa; 
  fread(&Registro,sizeof(Registro),1,alias); 
  while(!feof(alias))  
  { 
    if(Registro.no_empresa==no_empresa) 
    { 
      cout<< "\n\rNo Empresa       Nombre              Direccion                Telefono    Localidad "<<endl;
      cout << "\n\r------------------------------------------------------------------------------------"<<endl; 
	  cout<<Registro.no_empresa<<"\t""\t"<<Registro.nombre<<"\t""\t"<<Registro.direccion<<"\t""\t"<<Registro.telefono<<"\t""\t"<<Registro.localidad<<endl;
      Registro.no_empresa=0; 
      Registro.nombre=""; 
	  Registro.direccion="";
      Registro.telefono=0;  
      Registro.localidad=' '; 
      do { 
        cout << "\n\n\rEsta seguro que desea borrarlo? [S/N] ---> "; 
        op=toupper(getche()); 
      }while(op!='S' && op!='N'); 
      if(op=='S')       
	  { 
            fseek(alias,ftell(alias)-sizeof(Registro),SEEK_SET);      
			fwrite(&Registro,sizeof(Registro),1,alias); 
			cout << "\n\n\n\rRegistro de empresa eliminado !!!"; 
      } 
      fclose(alias); 
      cout << "\n\r<<< Oprima cualquier tecla para continuar >>>"; 
      getch(); 
      return; 
    } 
    fread(&Registro,sizeof(Registro),1,alias); 
  } 
  cout << "\n\rNo se encuentra ese registro !!!"; 
  fclose(alias);
  cout << "\n\r<<< Oprima cualquier tecla para continuar >>>"; 
  getch(); 
  return; 
}
