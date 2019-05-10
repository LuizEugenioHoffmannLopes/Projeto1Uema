;ALUNOS: ANDRÉ LUIS ROLIM DE CASTRO SILVA - 201627885, BIANCA VALÉRIA LOPES PEREIRA - 201621694;
;CLAUBER MARTINS PINTO - 201228693, LUIZ EUGÊNIO HOFFMANN LOPES - 201212755
;MARCOS VINICIUS JANUÁRIO DA SILVA - 201614715, MATHEUS PEREIRA DA SILVA - 201625684;
;PAULA FABIANNA SOARES OLIVEIRA - 201629647
;DISCIPLINA: MICROPROCESSADORES E MICROCONTROLADORES PROFESSOR: ELTON DE SOUSA E SILVA 
;PROJETO PWN - 8051 - Assembly com Perído de 2s
;Botão P3.3             20%             ON = 0,4s       OFF =  1,6s      
;Botão P3.4             40%             ON = 0,8s       OFF =  1,2s
;Botão P3.5             60%             ON = 1,2s       OFF =  0,8s
;Botão P3.6             80%             ON = 1,6s       OFF =  0,4s
;Botão P3.7             99%             ON = 1,98s      OFF =  0,02s
        org             0000h           ;origem no endereço 00h de memória
principal:
        mov             20h,#0C0h       ;move valor 11000000b para memória 20
        mov             21h,#0A4h       ;move valor 10100100b para memória 21
        mov             22h,#099h       ;move valor 10011001b para memória 22
        mov             23h,#082h       ;move valor 10000010b para memória 23
        mov             24h,#080h       ;move valor 10000000b para memória 24
        mov             25h,#098h       ;move valor 10011000b para memória 25
        mov             a,#0FFh         ;move a constante FFh para o acumulador
        mov             P3,a            ;inicializa P3
        jb              P3.3,menu3      ;botão 3 pressioinado? Não, pula para menu3
        sjmp            botao3          ;desvia para botao3      
menu3:
        jb              P3.4,menu4      ;botão 4 pressioinado? Não, pula para menu4
        sjmp            botao4          ;desvia para botao4      
menu4:
        jb              P3.5,menu5      ;botão 5 pressioinado? Não, pula para menu5
        sjmp            botao5          ;desvia para botao5      
menu5:
        jb              P3.6,menu6      ;botão 6 pressioinado? Não, pula para menu6
        sjmp            botao6          ;desvia para botao6      
menu6:
        jb              P3.7,principal  ;botão 7 pressioinado? Não, pula para principal
        sjmp            botao7          ;desvia para botao7      

botao3:
        acall           display20
        mov             P2,#00h         ;escreve 11111111b em P2
        clr             P1.0            ;ligar BUZZER
        acall           delay0s4        ;chama rotina delay0s4
        mov             P2,#0FFh        ;escreve 00000000b em P2
        setb            P1.0            ;desligar BUZZER
        acall           delay1s6        ;chama rotina delay1s6
        sjmp            botao3          ;loop infinito

botao4:
        acall           display40
        mov             P2,#00h         ;escreve 11111111b em P2
        clr             P1.0            ;ligar BUZZER
        acall           delay0s8        ;chama rotina delay0s8
        mov             P2,#0FFh        ;escreve 00000000b em P2
        setb            P1.0            ;desligar BUZZER
        acall           delay1s2        ;chama rotina delay1s2
        sjmp            botao4          ;loop infinito

botao5:
        acall           display60
        mov             P2,#00h         ;escreve 11111111b em P2
        clr             P1.0            ;ligar BUZZER
        acall           delay1s2        ;chama rotina delay1s2
        mov             P2,#0FFh        ;escreve 00000000b em P2
        setb            P1.0            ;desligar BUZZER
        acall           delay0s8        ;chama rotina delay0s8
        sjmp            botao5          ;loop infinito

botao6:
        acall           display80
        mov             P2,#00h         ;escreve 11111111b em P2
        clr             P1.0            ;ligar BUZZER
        acall           delay1s6        ;chama rotina delay1s6
        mov             P2,#0FFh        ;escreve 00000000b em P2
        setb            P1.0            ;desligar BUZZER
        acall           delay0s4        ;chama rotina delay0s4
        sjmp            botao6          ;loop infinito

botao7:
        clr             P1.2            ;unidade
        clr             P1.3            ;dezena
        mov             P0,25h          ;escreve 99 no display
        mov             P2,#00h         ;escreve 11111111b em P2
        clr             P1.0            ;ligar BUZZER
        acall           delay1s98       ;chama rotina delay1s98
        mov             P2,#0FFh        ;escreve 00000000b em P2
        setb            P1.0            ;desligar BUZZER
        acall           delay0s02       ;chama rotina delay0s02
        sjmp            botao7          ;loop infinito

delay0s02:
        mov             TCON,#10h       ;habilita contagem do Timer0
        mov             TMOD,#01h       ;Configura o Timer0 para incrementar com o ciclo de máquina
                                        ;Configura o Timer0 no modo 1 (16bits)                                      
;T0 inicia em 45536 (TH = 0B1h e TL = 0E0h), para estourar em 20000 us, 65536 - 20000 = 45536 us
        mov             TH0,#0B1h       ;Inicializa TH0 em 0B1h         
        mov             TL0,#0E0h       ;Inicializa TL0 em 0E0h
loop2ON0s02:
        jnb             TF0,loop2ON0s02 ;TF0 igual a 1? Não, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        ret                             ;retorna após a função acall

delay0s4:
        mov             a,#06d          ;move o valor 6d para o acc
        mov             TCON,#10h       ;habilita contagem do Timer0
        mov             TMOD,#01h       ;Configura o Timer0 para incrementar com o ciclo de máquina
                                        ;Configura o Timer0 no modo 1 (16bits)                                      
loop0s4:
        mov             TH0,#00h        ;Inicializa TH0 em 00h         
        mov             TL0,#00h        ;Inicializa TL0 em 00h
loopON0s4:
        jnb             TF0,loopON0s4   ;TF0 igual a 1? Não, descia para loop      
        dec             a               ;decrementa 1 unidade do acc
        clr             TF0             ;Sim, Limpa a flag de TF0
        cjne            a,#00,loop0s4   ;verifica se a=0, sim executa a linha de baixo, senão salta uma linha             
        jc              continua0s4     ;jump para proxima rotina
continua0s4:
;6 x 65536 = 393216 us          ;400000 - 393216 = 6784 us
;T0 inicia em 58752 (TH = 0E6h e TL = 048h), para estourar em 400000 us, 65536 - 6784 = 58752 us
        mov             TH0,#0E5h       ;Inicializa TH0 em 0E5h         
        mov             TL0,#080h       ;Inicializa TL0 em 080h
loop2ON0s4:
        jnb             TF0,loop2ON0s4  ;TF0 igual a 1? Não, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        ret                             ;retorna após a função acall

delay0s8:
        mov             a,#12d          ;move o valor 12d para o acc
        mov             TCON,#10h       ;habilita contagem do Timer0
        mov             TMOD,#01h       ;Configura o Timer0 para incrementar com o ciclo de máquina
                                        ;Configura o Timer0 no modo 1 (16bits)                                      
loop0s8:
        mov             TH0,#00h        ;Inicializa TH0 em 00h         
        mov             TL0,#00h        ;Inicializa TL0 em 00h
loopON0s8:
        jnb             TF0,loopON0s8   ;TF0 igual a 1? Não, descia para loop      
        dec             a               ;decrementa 1 unidade do acc
        clr             TF0             ;Sim, Limpa a flag de TF0
        cjne            a,#00,loop0s8   ;verifica se a=0, sim executa a linha de baixo, senão salta uma linha             
        jc              continua0s8     ;jump para proxima rotina
continua0s8:
;12 x 65536 = 786432 us         ;800000 - 786432 = 13568 us
;T0 inicia em 51968 (TH = 0CBh e TL = 000h), para estourar em 800000 us, 65536 - 13568 = 51968 us
        mov             TH0,#0CBh       ;Inicializa TH0 em 0CBh         
        mov             TL0,#000h       ;Inicializa TL0 em 000h
loop2ON0s8:
        jnb             TF0,loop2ON0s8  ;TF0 igual a 1? Não, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        ret                             ;retorna após a função acall

delay1s2:
        mov             a,#18d          ;move o valor 18d para o acc
        mov             TCON,#10h       ;habilita contagem do Timer0
        mov             TMOD,#01h       ;Configura o Timer0 para incrementar com o ciclo de máquina
                                        ;Configura o Timer0 no modo 1 (16bits)                                      
loop1s2:
        mov             TH0,#00h        ;Inicializa TH0 em 00h         
        mov             TL0,#00h        ;Inicializa TL0 em 00h
loopON1s2:
        jnb             TF0,loopON1s2   ;TF0 igual a 1? Não, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        dec             a               ;decrementa 1 unidade do acc
        cjne            a,#00,loop1s2   ;verifica se a=0, sim executa a linha de baixo, senão salta uma linha             
        jc              continua1s2     ;jump para proxima rotina               
continua1s2:
;18 x 65536 = 1179648 us        ;1200000 - 1179648 = 20352 us
;T0 inicia em 45184 (TH = 0B0h e TL = 080h), para estourar em 1200000 us, 65536 - 20352 = 45184 us
        mov             TH0,#0B0h       ;Inicializa TH0 em 0B0h         
        mov             TL0,#080h       ;Inicializa TL0 em 080h
loop2ON1s2:
        jnb             TF0,loop2ON1s2  ;TF0 igual a 1? Não, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        ret                             ;retorna após a função acall

delay1s6:
        mov             a,#24d          ;move o valor 24d para o acc
        mov             TCON,#10h       ;habilita contagem do Timer0
        mov             TMOD,#01h       ;Configura o Timer0 para incrementar com o ciclo de máquina
                                        ;Configura o Timer0 no modo 1 (16bits)                                        
loop1s6:
        mov             TH0,#00h        ;Inicializa TH0 em 00h         
        mov             TL0,#00h        ;Inicializa TL0 em 00h
loopON1s6:
        jnb             TF0,loopON1s6   ;TF0 igual a 1? Não, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        dec             a               ;decrementa 1 unidade do acc
        cjne            a,#00,loop1s6   ;verifica se a=0, sim executa a linha de baixo, senão salta uma linha             
        jc              continua1s6     ;jump para proxima rotina              
continua1s6:
;24 x 65536 = 1572864 us        ;1600000 - 1572864 = 27136 us
;T0 inicia em 38400 (TH = 096h e TL = 000h), para estourar em 1600000 us, 65536 - 27136 = 38400 us
        mov             TH0,#096h       ;Inicializa TH0 em 096h         
        mov             TL0,#000h       ;Inicializa TL0 em 000h
loop2ON1s6:
        jnb             TF0,loop2ON1s6  ;TF0 igual a 1? Não, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        ret                             ;retorna após a função acall

delay1s98:
        mov             a,#30d          ;move o valor 30d para o acc
        mov             TCON,#10h       ;habilita contagem do Timer0
        mov             TMOD,#01h       ;Configura o Timer0 para incrementar com o ciclo de máquina
                                        ;Configura o Timer0 no modo 1 (16bits)                                        
loop1s98:
        mov             TH0,#00h        ;Inicializa TH0 em 00h         
        mov             TL0,#00h        ;Inicializa TL0 em 00h
loopON1s98:
        jnb             TF0,loopON1s98  ;TF0 igual a 1? Não, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        dec             a               ;decrementa 1 unidade do acc
        cjne            a,#00,loop1s98  ;verifica se a=0, sim executa a linha de baixo, senão salta uma linha             
        jc              continua1s98    ;jump para proxima rotina              
continua1s98:
;30 x 65536 = 1966080 us        ;1980000 - 1966080 = 13920 us
;T0 inicia em 51616 (TH = 096h e TL = 000h), para estourar em 1980000 us, 65536 - 13920 = 51616 us
        mov             TH0,#0C9h       ;Inicializa TH0 em 0C9h         
        mov             TL0,#0A0h       ;Inicializa TL0 em 0A0h
loop2ON1s98:
        jnb             TF0,loop2ON1s98 ;TF0 igual a 1? Não, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        ret                             ;retorna após a função acall

display20:
        clr             P1.3            ;dezena
        setb            P1.2            ;unidade
        mov             P0,20h          ;escreve 00 no display
        acall           delay0s02
        setb            P1.3            ;dezena
        clr             P1.2            ;unidade
        mov             P0,21h          ;escreve 20 no display
        acall           delay0s02
        ret                             ;retorna após a função acall

display40:
        clr             P1.3            ;dezena
        setb            P1.2            ;unidade
        mov             P0,20h          ;escreve 00 no display
        acall           delay0s02
        setb            P1.3            ;dezena
        clr             P1.2            ;unidade
        mov             P0,22h          ;escreve 40 no display
        acall           delay0s02
        ret                             ;retorna após a função acall

display60:
        clr             P1.3            ;dezena
        setb            P1.2            ;unidade
        mov             P0,20h          ;escreve 00 no display
        acall           delay0s02
        setb            P1.3            ;dezena
        clr             P1.2            ;unidade
        mov             P0,23h          ;escreve 60 no display
        acall           delay0s02
        ret                             ;retorna após a função acall

display80:
        clr             P1.3            ;dezena
        setb            P1.2            ;unidade
        mov             P0,20h          ;escreve 00 no display
        acall           delay0s02
        setb            P1.3            ;dezena
        clr             P1.2            ;unidade
        mov             P0,24h          ;escreve 80 no display
        acall           delay0s02
        ret                             ;retorna após a função acall

        end                             ;Fim do programa