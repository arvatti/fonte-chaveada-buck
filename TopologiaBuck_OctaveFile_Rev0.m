%
% Conversor Buck Síncrono Fonte Principal
% Algoritmo de Projeto
%

clc; % limpa a tela
format long; % maior resolução nos cálculos
disp('<<<<<<<<<<<<')
disp('Parametros do conversor Buck')
disp('>>>>>>>>>>>>')
f =80E3 					% frequência de chaveamento em Hertz
Vs_max = 325 				% tensão máxima de entrada em Vdc
Vs_min = 120 				% tensão mínima de entrada em Vdc
Vo = 48 					% tensão de saída em Vdc
ripple = 0.01 				% tensão de Ripple
Io_max = 600E-3				% corrente máxima de saída em Amperes
disp('---------------------')
disp('Resultado dos dados:')
disp('---------------------')
D_min = Vo/Vs_max 			% valor do menor duty cycle necessário
D_max = Vo/Vs_min 			% valor do maior duty cycle necessário
L_min = ((1-D_max)*(Vo/Io_max))/(2*f) 	% indutância mínima em Henry
L = 1.25*L_min 				% valor do indutor (margem de 25%)
IL = Io_max 				% corrente no indutor
del_IL = ((Vs_min-Vo)/L)*(D_max/f) 	% variação de corrente no indutor
I_max = IL+(del_IL/2) 			% corrente máxima no indutor
I_min = IL-(del_IL/2) 			% corrente mínima no indutor
I_rms = sqrt(IL^2 + (del_IL/(2*sqrt(3)))^2) % corrente eficaz no indutor
C_min = (1-D_max)/(8*L*ripple*f^2) 	% capacitância mínima
disp('<<<<<<<<<<<<')
disp('Parametros iniciais completo!')
disp('>>>>>>>>>>>>')


 
%Cálculos do indutor de alta frequência:

%
% Cálculos Indutor de Alta Frequência
% Passo 1
%

clc;                         	% limpa a tela
format long;                 	% maior resolução nos cálculos
disp('---------------------')
disp('Valores padrão literatura:')
disp('---------------------')
J_max   = 450                	% máxima densidade de corrente em A/cm^2
del_B   = 0.39               	% densidade de fluxo magnético a 100°C em Tesla
Kw      = 0.7                 	% fator de ocupação de cobre no carretel
disp('---------------------')
disp('Produto AeAw [cm^4]:')
disp('---------------------')
AeAw = (L*I_rms*I_max)*(10^4)/(del_B*J_max*Kw) % produto das áreas AeAw
disp('------------------------------------------------------')
disp('Selecionando o nucelo EE na tabela A')
disp('------------------------------------------------------')

%
% Cálculos para o Indutor de Alta Frequência
% Passo 2
%

clc;                          	% limpa a tela
format long;                  	% maior resolução nos cálculos
disp('---------------------')
disp('Valores padrao literatura:')
disp('---------------------')
u0      = 4*pi*1E-7           	% permeabilidade magnética do ar
disp('---------------------')
disp('Valores da Tabela A:')
disp('---------------------')
Ae       = 0.31                   	% Ae de acordo com a Tabela em cm^2
Aw       = 0.255                  	% Aw de acordo com a Tabela em cm^2
disp('---------------------')
disp('Numero de Espiras:')
disp('---------------------')
Ncalc = L*I_max/(del_B*(Ae/10000));	% número de espiras calculado
N     = ceil(Ncalc)                	% número inteiro de espiras a ser utilizado
disp('---------------------')
disp('Entreferro [mm]:')
disp('---------------------')
l_ef = ((N^2*u0*(Ae/10000))/L)*1E3 	% distância do entreferro em mm
disp('---------------------')
disp('Diam. max. do cond. [cm]:')
disp('---------------------')
d_max = 2*7.5/sqrt(f)          	% diâmetro máximo do condutor em cm
disp('---------------------')
disp('Area min. cobre [cm^2]:')
disp('---------------------')
A_min_cobre = I_rms/J_max          	% área mínima do cobre em cm^2
disp('----------------------------------------------------')
disp('Selecione o fio AWG na Tabela B e realize o passo 3')
disp('----------------------------------------------------')

%
% Cálculos para o Indutor de Alta Frequência
% Passo 3
%

clc;                          		% limpa a tela
format long;                  		% maior resolução nos cálculos
disp('-------------------------')
disp('Valores do AWG escolhido:')
disp('-------------------------')
A_cobre_tab = 0.001624        		% área do cobre sem verniz
A_cobre_iso = 0.002078        		% área do cobre com verniz isolante
disp('---------------------------------')
disp('Numero de condutores necessarios:')
disp('---------------------------------')
num_cond_calc = (I_rms/J_max)/A_cobre_iso;% numero de condutores
num_cond = ceil(num_cond_calc)            % arredonda para o inteiro maior
disp('-----------------------------------------')
disp('Area que o enrolamento vai ocupar [cm^2]:')
disp('-----------------------------------------')
Awmin = N*A_cobre_iso*num_cond       	% área de ocupação aprox. do enrolamento

