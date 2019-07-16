programa
{
	inclua biblioteca Texto --> tx
	inclua biblioteca Calendario --> c
	inclua biblioteca Util --> u
	inclua biblioteca Mouse --> m
	inclua biblioteca Graficos --> g
	inclua biblioteca Matematica --> M
	inclua biblioteca Sons --> s

	//Var globais
	//-------------------------

	const inteiro LarguraT = 1000
	const inteiro AlturaT = 500

	inteiro horarioH = c.hora_atual(falso)
	cadeia Comprimento = "0"

	//Toda essa parte está relacionada aos setores e suas determinadas variaveis contadoras...
	//INICIO----------------
	cadeia senhaSetor = ""
	
	//setor atendimento express
	inteiro aex_count = 0
	//setor fgts
	inteiro fgt_count = 0
	//setor pis
	inteiro pis_count= 0
	//setor abertura de contas e empretimos
	inteiro epa_count = 0
	//setor atendimento caixa
	inteiro cxc_count = 0

	//aqui é a variavel que guarda o valor de alguma contadora que foi selecionada.
	inteiro save_count = 0
	//variavel substituta da save_count, para corrigir bugs.
	inteiro senhaSubs = 0

	//FIM------------------

	//Agora começa a parte do reprodutor por audio da senha
	//INICIO-----------------
	
	//vetor destinado a guardar todos os caracteres da senha geral.
	caracter senhaCaracter[6]


	//FIM---------------------

	/*
	 * informe aqui o numero do guiche que irá atender o cliente, durante toda a execuçao do programa.
	
	Ate que o programa finalizar, e poderá mudar novamente. Caso contrario, alterar o numero com o programa em execução,
	nao influenciará em nada '-' */
	
	cadeia guicheNumber = ""

	cadeia senhasChamadas[5] = {"000000", "000000", "000000", "000000", "000000"}
	cadeia guicheNumeroChamado[5] = {"0", "0", "0", "0", "0"}

	//Posiçao do mouse. esta sendo meio inutil '-'
	inteiro mouseX = m.posicao_x()
	inteiro mouseY = m.posicao_y()

	//Guarda as posicoes de onde tem elipse.
	const inteiro qtd = 15
	inteiro ElipsePx[qtd]
	inteiro ElipsePy[qtd]

	//Variaveis que guarda as coordenados do preferencial.
	inteiro preferencialX = 0
	inteiro preferencialY = 0
	//Variavel checa se é preferencial ou nao.
	logico preferencialEscolhido = falso

	//Variaveis que guarda as coordenador do setor selecionado.
	inteiro setorX = 0
	inteiro setorY = 0
	//Variavel que guarda o setor escolhido
	cadeia setorEscolhido = ""

	//Variaveis de controle do atendente. marcar elipse.
	inteiro guicheX = 0
	inteiro guicheY = 0
	//Variavel que guarda qual dos guiches esta selecionado.
	inteiro guicheSelecionado = 0
	cadeia guicheSelecionadoReajutado = "0" + guicheSelecionado

	//guardar senhas
	const inteiro tamanhoMaximoFila = 1000
	cadeia filaSenhasAbertas[2][tamanhoMaximoFila]

	//senha que aparecerá na tela, apos o atendente chamar por essa senha;
	cadeia senhaChamada = ""


	//teste var contadora 
	//tentar reajustar a chamada da fila
	cadeia testeC = ""
	inteiro countC = 0
	
	
	funcao inicio()
	{
		desenharTela()
		iniciarVetorFila()
		enquanto(verdadeiro)
		{
			cor_FundoPadrao()
			Divisorias()
			escreverCamposGerar()
			escreverCamposCliente()
			escreverCamposAtendente()
			verifica_mouse_esta_sobre_elipse()
			g.renderizar()	
		}
		
	}
	
	funcao desenharTela()
	{
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_dimensoes_janela(LarguraT, AlturaT)
		
	}

	funcao cor_FundoPadrao()
	{
		g.definir_cor(g.COR_BRANCO)
		g.limpar()
	}

	funcao Divisorias()
	{
		g.definir_cor(g.COR_AZUL)
		g.desenhar_retangulo(333, 0, 333, AlturaT, verdadeiro, verdadeiro)
	}

	funcao escreverCamposCliente()
	{
		g.definir_cor(g.COR_BRANCO)
		g.definir_tamanho_texto(30.0)
		g.desenhar_texto(450, 60, "SENHA")
		g.definir_tamanho_texto(20.0)
		g.desenhar_texto(460, 170, "GUICHE")
		g.desenhar_retangulo(420, 100, 170, 50, verdadeiro, falso)
		g.definir_tamanho_texto(40.0)
		se(senhaChamada == "000000") senhaChamada = "" 
		g.desenhar_texto(430, 110, senhaChamada)
		g.definir_tamanho_texto(20.0)
		g.desenhar_texto(490, 195, guicheNumber)

		desenharTabelaSenhasPerdidos()
	}

	funcao desenharTabelaSenhasPerdidos()
	{
		const inteiro linhaSeparacaoX = 515
		const inteiro linhaSeparacaoY = 270
	
		const inteiro linhaDivX = 360
		const inteiro linhaDivY = 340
		
		g.desenhar_retangulo(360, 270, 275, 190, verdadeiro, falso)
		g.desenhar_linha(360, 310, 360+275, 310)
		g.desenhar_linha(linhaSeparacaoX, linhaSeparacaoY, linhaSeparacaoX, linhaSeparacaoY+190)

		//Mensagem - Senhas perdidas/Chamadas
		g.definir_tamanho_texto(13.0)
		g.definir_estilo_texto(verdadeiro, falso, falso)
		g.desenhar_texto(420, 250, "Senhas Chamadas/Perdidas")
		
		g.definir_tamanho_texto(20.0)
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.desenhar_texto(400, 285, "SENHA")
		g.desenhar_texto(535, 285, "GUICHE")

		//Linhas divisorias das senhas da tabela.
		g.definir_tamanho_texto(17.0)
		inteiro SomaY = 0
		para(inteiro i = 1; i <= 4; i++)
		{
			g.desenhar_linha(linhaDivX, linhaDivY+SomaY, linhaDivX+275, linhaDivY+SomaY)
			SomaY+=30
		}

		filaTabelaChamados()
	}

	funcao filaTabelaChamados()
	{
		inteiro SomaY_texto = 0
		para(inteiro i = 0; i <= 4; i++)
		{
			se(senhasChamadas[i] != "000000")
			{
				g.desenhar_texto(400, 320+SomaY_texto, senhasChamadas[i])
				g.desenhar_texto(565, 320+SomaY_texto, guicheNumber)
				SomaY_texto+=30
			}
			senao
			{
				g.desenhar_texto(400, 320+SomaY_texto, "")
			}
			
		}
	}

	/*funcao filaTabelaChamados()
	{
		inteiro SomaY_texto = 0
		para(inteiro i = 1; i <= 5; i++)
		{
			inteiro reajuste = (save_count - i)
			cadeia setorEscolhido_ = ""
			se(reajuste <= 9)
			{
				setorEscolhido_ += setorEscolhido + "00"
			}
			senao se(reajuste <= 99)
			{
				setorEscolhido_ += setorEscolhido + "0"
			}
			
			se(reajuste > 0)
			{
				g.desenhar_texto(400, 320+SomaY_texto, setorEscolhido_ + reajuste)
				g.desenhar_texto(565, 320+SomaY_texto, guicheNumber)
				SomaY_texto+=30
			}
			senao
			{
				g.desenhar_texto(400, 320+SomaY_texto, "")
				SomaY_texto+=30
			}
			
		}
	}*/

	funcao escreverCamposAtendente()
	{
		g.definir_cor(g.COR_PRETO)
		g.desenhar_texto(810, 30, "Guiche")
		desenharElipse(680, 50, "01", 7)
		desenharElipse(730, 50, "02", 8)
		desenharElipse(780, 50, "03", 9)
		desenharElipse(830, 50, "04", 10)
		desenharElipse(880, 50, "05", 11)
		desenharElipse(930, 50, "06", 12)

		checarGuiche()
		
		se(guicheSelecionado != 0)
		{
			marcarElipse(guicheX, guicheY)
		}

		marcarProximoGuiche()

		g.definir_cor(g.criar_cor(100, 100, 100))
		g.desenhar_retangulo(800, 100, 90, 35, verdadeiro, verdadeiro)
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.definir_tamanho_texto(16.0)
		g.definir_cor(g.COR_PRETO)
		g.desenhar_texto(805, 110, "Atualizar")
		
		g.desenhar_retangulo(770, 160, 150, 45, verdadeiro, falso)
		g.definir_tamanho_texto(33.0)
		g.desenhar_texto(780, 170, senhaChamada)
	}

	funcao checarGuiche()
	{
		se(m.botao_pressionado(m.BOTAO_ESQUERDO))
		{
			se(guicheX == 680 e guicheY == 50)
			{
				guicheSelecionado = 1
			}
			senao se(guicheX == 730 e guicheY == 50)
			{
				guicheSelecionado = 2
			}
			senao se(guicheX == 780 e guicheY == 50)
			{
				guicheSelecionado = 3
			}
			senao se(guicheX == 830 e guicheY == 50)
			{
				guicheSelecionado = 4
			}
			senao se(guicheX == 880 e guicheY == 50)
			{
				guicheSelecionado = 5
			}
			senao se(guicheX == 930 e guicheY == 50)
			{
				guicheSelecionado = 6
			}
		}
	}

	funcao marcarProximoGuiche()
	{
		se(mouse(800, 100, 90, 35) == verdadeiro)
		{
			g.definir_cor(g.COR_PRETO)
			g.desenhar_retangulo(795, 95, 100, 45, verdadeiro, verdadeiro)

			se(m.botao_pressionado(m.BOTAO_ESQUERDO) e guicheSelecionado != 0)
			{
				para(inteiro i = 0; i < tamanhoMaximoFila - 2; i++)
				{
					filaSenhasAbertas[0][i] = filaSenhasAbertas[0][i+1]
					
					senhaChamada = filaSenhasAbertas[0][0]
					guicheNumber = guicheSelecionado + ""
				}
			}
		}
	}

	funcao escreverCamposGerar()
	{
		Horario(horarioH)
		
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.definir_cor(g.COR_PRETO)
		g.definir_tamanho_texto(14.0)
		g.desenhar_texto(50, 30, "Olá, " + Comprimento)
		g.desenhar_texto(50, 45, "Por favor, Preencha tudo!.")

		g.desenhar_texto(50, 80, "Preferencial:")
		
		desenharElipse(50, 97, "Sim", 0)
		desenharElipse(120, 97, "Nao", 1)

		g.desenhar_texto(50, 140, "Escolha o Setor:")
		
		desenharElipse(50, 160, "Atendimento Express", 2)
		desenharElipse(50, 175, "FGTS", 3)
		desenharElipse(50, 190, "PIS", 4)
		desenharElipse(50, 205, "Emprestimos/Abertura de Contas", 5)
		desenharElipse(50, 220, "Atendimendo Caixa", 6)

		se(preferencialX != 0)
		{
			marcarElipse(preferencialX, preferencialY)
		}
		se(setorX != 0)
		{
			marcarElipse(setorX, setorY)
		}
		adicionarSenha()
	}

	funcao escolherSetores_PreferencialYN(inteiro PositionX, inteiro PositionY)
	{
		se(m.botao_pressionado(m.BOTAO_ESQUERDO))
		{
			se(PositionX <= 300 e PositionY <= 100)
			{
				preferencialX = PositionX
				preferencialY = PositionY
			}
			senao se(PositionX <= 300 e PositionY > 100)
			{
				setorX = PositionX
				setorY = PositionY
			}	
			senao se(PositionX > 300 e PositionY > 0)
			{
				guicheX = PositionX
				guicheY = PositionY
			}
		}
		
	}

	funcao adicionarSenha()
	{
		se(mouse(120, 320, 90, 35) == verdadeiro)
		{
			g.desenhar_retangulo(115, 315, 100, 45, verdadeiro, verdadeiro)

			se(m.botao_pressionado(m.BOTAO_ESQUERDO) e preferencialX != 0 e setorX != 0)
			{
				se(preferencialX == 50 e preferencialY == 97)
				{
					preferencialEscolhido = verdadeiro
				}
				senao se(preferencialX == 120 e preferencialY == 97)
				{
					preferencialEscolhido = falso
				}

				se(setorX == 50 e setorY == 160)
				{
					setorEscolhido = "AEX"
					aex_count++
					senhaSubs = aex_count
				}
				senao se(setorX == 50 e setorY == 175)
				{
					setorEscolhido = "FGT"
					fgt_count++
					senhaSubs = fgt_count
				}
				senao se(setorX == 50 e setorY == 190)
				{
					setorEscolhido = "PIS"
					pis_count++
					senhaSubs = pis_count
				}
				senao se(setorX == 50 e setorY == 205)
				{
					setorEscolhido = "EPA"
					epa_count++
					senhaSubs = epa_count
				}
				senao se(setorX == 50 e setorY == 220)
				{
					setorEscolhido = "CXC"
					cxc_count++
					senhaSubs = cxc_count
				}
				
				preferencialX = 0
				preferencialY = 0
				setorX = 0
				setorY = 0
			}
		}

		//Aqui começa a parte de salvar a senha ja com a categoria e var contadora.
		senhaSetor = setorEscolhido + senhaSubs

		save_count = aex_count + fgt_count + pis_count + epa_count + cxc_count
		
		g.definir_cor(g.criar_cor(100, 100, 100))
		g.desenhar_retangulo(120, 320, 90, 35, verdadeiro, verdadeiro)
		g.definir_cor(g.COR_PRETO)
		g.definir_tamanho_texto(16.0)
		g.desenhar_texto(125, 330, "Adicionar")
		
		//fazer reajuste na senha, caso os numeros sejam menor que 9 e 99. adicionando 0.
		gerarSenha()
	}

	funcao marcarElipse(inteiro x, inteiro y)
	{
		g.desenhar_elipse(x + 4, y + 4, 6, 6, verdadeiro)
	}

	funcao logico verifica_mouse_esta_sobre_elipse()
	{
		para(inteiro i = 0; i < qtd; i++)
		{
			se(mouse(ElipsePx[i], ElipsePy[i], 13, 13) == verdadeiro)
			{
				g.definir_cor(g.COR_PRETO)
				g.desenhar_retangulo(ElipsePx[i], ElipsePy[i], 13, 13, falso, falso)
				escolherSetores_PreferencialYN(ElipsePx[i], ElipsePy[i])
				retorne verdadeiro
			}
		}
		retorne falso
	}

	funcao desenharElipse(inteiro x, inteiro y, cadeia texto, inteiro pos)
	{
		g.definir_cor(g.COR_PRETO)
		g.desenhar_elipse(x, y, 13, 13, falso)
		g.desenhar_texto(x + 20, y, texto)
		
		ElipsePx[pos] = x
		ElipsePy[pos] = y
	}

	funcao gerarSenha()
	{
		se(senhaSubs == 0)
		{
			senhaSetor = "000000"
		}
		senao
		{
			se(senhaSubs <= 9)
			{
				senhaSetor = setorEscolhido + "00" + senhaSubs
				
			}
			senao se(senhaSubs <= 99)
			{
				senhaSetor = setorEscolhido + "0" + senhaSubs
			}
		}
		filaSenhasAbertas[0][save_count] = senhaSetor
		//separarCaracteresSenha()
	}

	funcao falarSenha()
	{
		
	}

	/*funcao separarCaracteresSenha()
	{
		para(inteiro i = 0; i <= 5; i++)
		{
			senhaCaracter[i] = tx.obter_caracter(senhaSetor, i)
		}
	}*/

	funcao logico mouse(inteiro x, inteiro y, inteiro a, inteiro b)
	{
		se(m.posicao_x() >= x e m.posicao_y() >= y e m.posicao_x() <= x+a e m.posicao_y() <= y+b)
		{
			retorne verdadeiro
		}
		retorne falso
	}
	
	funcao Horario(inteiro hora)
	{
		se(hora >= 5 e hora < 12)
		{
			Comprimento = "Bom Dia!."
		}

		senao se(hora >= 12 e hora <= 17)
		{
			Comprimento = "Boa Tarde!."
		}
		
		senao
		{
			Comprimento = "Boa Noite!."
		}
	}

	funcao iniciarVetorFila()
	{
		para(inteiro j = 0; j <= 1; j++)
		{
			para(inteiro i = 0; i <= tamanhoMaximoFila - 1; i++)
			{
				filaSenhasAbertas[j][i] = "0"
			}
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 6251; 
 * @DOBRAMENTO-CODIGO = [120, 127, 133, 139, 156, 190, 209, 272, 323, 357, 380, 480, 502, 507, 515, 524, 542];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = {senhaSetor, 22, 8, 10}-{filaSenhasAbertas, 92, 8, 17};
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */