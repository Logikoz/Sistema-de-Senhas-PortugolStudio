programa
{
	inclua biblioteca Util --> u
	inclua biblioteca Arquivos --> a
	inclua biblioteca Sons --> s
	inclua biblioteca Graficos --> g
	inclua biblioteca Texto --> t

	caracter vetor[] = {'a', 'c', 'a', '0', '1', '9'}
	
	funcao inicio()
	{
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_dimensoes_janela(1000, 5000)
		falarSenha()
		enquanto(verdadeiro)
		{
			g.definir_cor(g.COR_BRANCO)
			g.limpar()
			
			g.renderizar()
		}
	}

	funcao falarSenha()
	{
		inteiro teste = 0
		enquanto(teste < 757)
		{
			cadeia camS = "./Sons/senha.mp3"
			inteiro carS = s.carregar_som(camS)
			inteiro repS = s.reproduzir_som(carS, falso)
			s.definir_volume(100)
			s.definir_volume_reproducao(repS, 70)
			teste = s.obter_posicao_atual_musica(repS)
		}
				
		/*para(inteiro i = 0; i <= 5; i++)
		{
			cadeia cam = "./Sons/" + vetor[i] + ".mp3"
			inteiro car = s.carregar_som(cam)
			inteiro rep = s.reproduzir_som(car, falso)
			s.definir_volume(100)
			s.definir_volume_reproducao(rep, 70)
			u.aguarde(700)
			
		}

		cadeia cam = "./Sons/a.mp3"
		inteiro car = s.carregar_som(cam)
		inteiro rep = s.reproduzir_som(car, falso)
		s.definir_volume(100)
		s.definir_volume_reproducao(rep, 70)*/
		
		cadeia camG = "./Sons/guichê.mp3"
		inteiro carG = s.carregar_som(camG)
		inteiro repG = s.reproduzir_som(carG, falso)
		s.definir_volume(100)
		s.definir_volume_reproducao(repG, 70)
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 505; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = {teste, 27, 10, 5};
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */