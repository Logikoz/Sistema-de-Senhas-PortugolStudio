programa
{
	const inteiro qtd = 10
	inteiro teste[qtd] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
	inteiro primeiro
	inteiro ultimo
	
	funcao inicio()
	{
		enquanto(verdadeiro)
		{
			inteiro valor
			escreva("Informe um valor: ")
			leia(valor)
			limpa()

			se(valor == -1)
			{
				para(inteiro i = 9; i >= 0; i--)
				{
					se(i >= 0)
					{
						escreva(i)
						teste[i] = teste[i - 1]
					}
				}
			}
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 355; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = {teste, 4, 9, 5};
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */