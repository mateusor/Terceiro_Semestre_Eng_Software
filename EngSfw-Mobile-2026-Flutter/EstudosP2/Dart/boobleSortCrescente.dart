void main(){
    List<int>lista = [8, 3, 1, 7, 4, 9, 2];
    int aux=0;

    for(int i = 0; i < lista.length; i++){

        for(int j = 0; j < lista.length-1; j++){

            if (lista[j]> lista[j+1]){
                
                aux = lista[j];
                lista [j]=lista[j+1];
                lista [j+1] = aux;
            }
        }
}
    print (lista);
}

