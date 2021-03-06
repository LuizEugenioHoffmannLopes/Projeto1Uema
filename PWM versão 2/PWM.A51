;ALUNOS: ANDR� LUIS ROLIM DE CASTRO SILVA - 201627885, BIANCA VAL�RIA LOPES PEREIRA - 201621694;
;CLAUBER MARTINS PINTO - 201228693, LUIZ EUG�NIO HOFFMANN LOPES - 201212755
;MARCOS VINICIUS JANU�RIO DA SILVA - 201614715, MATHEUS PEREIRA DA SILVA - 201625684;
;PAULA FABIANNA SOARES OLIVEIRA - 201629647

;DISCIPLINA: MICROPROCESSADORES E MICROCONTROLADORES PROFESSOR: ELTON DE SOUSA E SILVA 

;PROJETO PWN - 8051 - Assembly com Per�do de 24ms

;Bot�o P3.3             20%             ON = 4,8ms      OFF =  19,2ms      
;Bot�o P3.4             40%             ON = 9,6ms      OFF =  14,4ms
;Bot�o P3.5             60%             ON = 14,4ms     OFF =  9,6ms
;Bot�o P3.6             80%             ON = 19,2ms     OFF =  4,8ms
;Bot�o P3.7             99%             ON = 23,76ms    OFF =  0,24ms
        org             0000h           ;origem no endere�o 00h de mem�ria
principal:
        mov             20h,#0C0h       ;move valor 11000000b para mem�ria 20
        mov             21h,#0A4h       ;move valor 10100100b para mem�ria 21
        mov             22h,#099h       ;move valor 10011001b para mem�ria 22
        mov             23h,#082h       ;move valor 10000010b para mem�ria 23
        mov             24h,#080h       ;move valor 10000000b para mem�ria 24
        mov             25h,#098h       ;move valor 10011000b para mem�ria 25
        mov             a,#0FFh         ;move a constante FFh para o acumulador
        mov             P3,a            ;inicializa P3
        jb              P3.3,menu3      ;bot�o 3 pressioinado? N�o, pula para menu3
        sjmp            botao3          ;desvia para botao3      
menu3:
        jb              P3.4,menu4      ;bot�o 4 pressioinado? N�o, pula para menu4
        sjmp            botao4          ;desvia para botao4      
menu4:
        jb              P3.5,menu5      ;bot�o 5 pressioinado? N�o, pula para menu5
        sjmp            botao5          ;desvia para botao5      
menu5:
        jb              P3.6,menu6      ;bot�o 6 pressioinado? N�o, pula para menu6
        sjmp            botao6          ;desvia para botao6      
menu6:
        jb              P3.7,principal  ;bot�o 7 pressioinado? N�o, pula para principal
        sjmp            botao7          ;desvia para botao7      

botao3:
        acall           display20
        mov             P2,#00h         ;escreve 11111111b em P2
        clr             P1.0            ;ligar BUZZER
        acall           delay20         ;chama rotina delay20
        mov             P2,#0FFh        ;escreve 00000000b em P2
        setb            P1.0            ;desligar BUZZER
        acall           delay80         ;chama rotina delay80
        sjmp            botao3          ;loop infinito

botao4:
        acall           display40
        mov             P2,#00h         ;escreve 11111111b em P2
        clr             P1.0            ;ligar BUZZER
        acall           delay40         ;chama rotina delay40
        mov             P2,#0FFh        ;escreve 00000000b em P2
        setb            P1.0            ;desligar BUZZER
        acall           delay60         ;chama rotina delay60
        sjmp            botao4          ;loop infinito

botao5:
        acall           display60
        mov             P2,#00h         ;escreve 11111111b em P2
        clr             P1.0            ;ligar BUZZER
        acall           delay60         ;chama rotina delay60
        mov             P2,#0FFh        ;escreve 00000000b em P2
        setb            P1.0            ;desligar BUZZER
        acall           delay40         ;chama rotina delay40
        sjmp            botao5          ;loop infinito

botao6:
        acall           display80
        mov             P2,#00h         ;escreve 11111111b em P2
        clr             P1.0            ;ligar BUZZER
        acall           delay80         ;chama rotina delay80
        mov             P2,#0FFh        ;escreve 00000000b em P2
        setb            P1.0            ;desligar BUZZER
        acall           delay20         ;chama rotina delay20
        sjmp            botao6          ;loop infinito

botao7:
        clr             P1.2            ;unidade
        clr             P1.3            ;dezena
        mov             P0,25h          ;escreve 99 no display
        mov             P2,#00h         ;escreve 11111111b em P2
        clr             P1.0            ;ligar BUZZER
        acall           delay99         ;chama rotina delay99
        mov             P2,#0FFh        ;escreve 00000000b em P2
        setb            P1.0            ;desligar BUZZER
        acall           delay01         ;chama rotina delay01
        sjmp            botao7          ;loop infinito

delay01:
        mov             TCON,#10h       ;habilita contagem do Timer0
        mov             TMOD,#01h       ;Configura o Timer0 para incrementar com o ciclo de m�quina
                                        ;Configura o Timer0 no modo 1 (16bits)                                      
;T0 inicia em 65296 (TH = 0FFh e TL = 010h), para estourar em 240 us, 65536 - 240 = 65296 us
        mov             TH0,#0FFh       ;Inicializa TH0 em 0B1h         
        mov             TL0,#010h       ;Inicializa TL0 em 0E0h
loopO1:
        jnb             TF0,loopO1      ;TF0 igual a 1? N�o, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        ret                             ;retorna ap�s a fun��o acall

delay20:
        mov             TCON,#10h       ;habilita contagem do Timer0
        mov             TMOD,#01h       ;Configura o Timer0 para incrementar com o ciclo de m�quina
                                        ;Configura o Timer0 no modo 1 (16bits)                                      
;T0 inicia em 60736 (TH = 0EDh e TL = 040h), para estourar em 4800 us, 65536 - 4800 = 60736 us
        mov             TH0,#0EDh       ;Inicializa TH0 em 0B1h         
        mov             TL0,#040h       ;Inicializa TL0 em 0E0h
loop2O:
        jnb             TF0,loop2O      ;TF0 igual a 1? N�o, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        ret                             ;retorna ap�s a fun��o acall

delay40:
        mov             TCON,#10h       ;habilita contagem do Timer0
        mov             TMOD,#01h       ;Configura o Timer0 para incrementar com o ciclo de m�quina
                                        ;Configura o Timer0 no modo 1 (16bits)                                      
;T0 inicia em 55936 (TH = 0DAh e TL = 080h), para estourar em 9600 us, 65536 - 9600 = 55936 us
        mov             TH0,#0DAh       ;Inicializa TH0 em 0B1h         
        mov             TL0,#080h       ;Inicializa TL0 em 0E0h
loop4O:
        jnb             TF0,loop4O      ;TF0 igual a 1? N�o, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        ret                             ;retorna ap�s a fun��o acall

delay60:
        mov             TCON,#10h       ;habilita contagem do Timer0
        mov             TMOD,#01h       ;Configura o Timer0 para incrementar com o ciclo de m�quina
                                        ;Configura o Timer0 no modo 1 (16bits)                                      
;T0 inicia em 51136 (TH = 0C7h e TL = 0C0h), para estourar em 14400 us, 65536 - 14400 = 51136 us
        mov             TH0,#0C7h       ;Inicializa TH0 em 0B1h         
        mov             TL0,#0C0h       ;Inicializa TL0 em 0E0h
loop6O:
        jnb             TF0,loop6O      ;TF0 igual a 1? N�o, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        ret                             ;retorna ap�s a fun��o acall

delay80:
        mov             TCON,#10h       ;habilita contagem do Timer0
        mov             TMOD,#01h       ;Configura o Timer0 para incrementar com o ciclo de m�quina
                                        ;Configura o Timer0 no modo 1 (16bits)                                      
;T0 inicia em 46336 (TH = 0B5h e TL = 000h), para estourar em 19200 us, 65536 - 19200 = 46336 us
        mov             TH0,#0B5h       ;Inicializa TH0 em 0B1h         
        mov             TL0,#000h       ;Inicializa TL0 em 0E0h
loop8O:
        jnb             TF0,loop8O      ;TF0 igual a 1? N�o, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        ret                             ;retorna ap�s a fun��o acall

delay99:
        mov             TCON,#10h       ;habilita contagem do Timer0
        mov             TMOD,#01h       ;Configura o Timer0 para incrementar com o ciclo de m�quina
                                        ;Configura o Timer0 no modo 1 (16bits)                                      
;T0 inicia em 41776 (TH = 0A3h e TL = 030h), para estourar em 23760 us, 65536 - 23760 = 41776 us
        mov             TH0,#0A3h       ;Inicializa TH0 em 0B1h         
        mov             TL0,#030h       ;Inicializa TL0 em 0E0h
loop99:
        jnb             TF0,loop99      ;TF0 igual a 1? N�o, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        ret                             ;retorna ap�s a fun��o acall

delayDisplay:
        mov             TCON,#10h       ;habilita contagem do Timer0
        mov             TMOD,#01h       ;Configura o Timer0 para incrementar com o ciclo de m�quina
                                        ;Configura o Timer0 no modo 1 (16bits)                                      
;T0 inicia em 65512 (TH = 0FFh e TL = 0E8h), para estourar em 24 us, 65536 - 24 = 65512 us
        mov             TH0,#0FFh       ;Inicializa TH0 em 0B1h         
        mov             TL0,#0E8h       ;Inicializa TL0 em 0E0h
loopDisplay:
        jnb             TF0,loopDisplay      ;TF0 igual a 1? N�o, descia para loop
        clr             TF0             ;Sim, Limpa a flag de TF0
        ret                             ;retorna ap�s a fun��o acall



display20:
        clr             P1.3            ;dezena
        setb            P1.2            ;unidade
        mov             P0,20h          ;escreve 00 no display
        acall           delay01
        setb            P1.3            ;dezena
        clr             P1.2            ;unidade
        mov             P0,21h          ;escreve 20 no display
        acall           delayDisplay
        ret                             ;retorna ap�s a fun��o acall

display40:
        clr             P1.3            ;dezena
        setb            P1.2            ;unidade
        mov             P0,20h          ;escreve 00 no display
        acall           delayDisplay
        setb            P1.3            ;dezena
        clr             P1.2            ;unidade
        mov             P0,22h          ;escreve 40 no display
        acall           delayDisplay
        ret                             ;retorna ap�s a fun��o acall

display60:
        clr             P1.3            ;dezena
        setb            P1.2            ;unidade
        mov             P0,20h          ;escreve 00 no display
        acall           delayDisplay
        setb            P1.3            ;dezena
        clr             P1.2            ;unidade
        mov             P0,23h          ;escreve 60 no display
        acall           delayDisplay
        ret                             ;retorna ap�s a fun��o acall

display80:
        clr             P1.3            ;dezena
        setb            P1.2            ;unidade
        mov             P0,20h          ;escreve 00 no display
        acall           delayDisplay
        setb            P1.3            ;dezena
        clr             P1.2            ;unidade
        mov             P0,24h          ;escreve 80 no display
        acall           delayDisplay
        ret                             ;retorna ap�s a fun��o acall

        end                             ;Fim do programa