%% Projeto 03
% *Autor:* Marlon da Silva Rogério

%% Referências
% *GONZALEZ, R. C.*, WOODS, R. E. Processamento de Imagens Digitais. 
% Editora Edgard Blucher, ISBN São Paulo, 2000.
% *Support MathWorks*, 2021. Disponível em: <https://www.mathworks.com/help/>.
% Acesso em: 13 de junho. de 2021

close all; clear; clc;
%% 1 Transformadas de intensidade (Definições)
% * Defina algumas das transformada de intensidade estudas.
img_transformada = imread('transformada.png');
img_gama = imread('gama.png');
figure;
subplot(1,2,1);
imshow(img_transformada);
title('Transformadas de intensidade');
subplot(1,2,2);
imshow(img_gama);
title('Transformadas de gama');


%% 1.1 Transformadas de intensidade (Aplicação)
% Crie uma função que recebe uma imagem e ‘Melhore’ essa imagem de entrada
% com transformadas de intensidade (adicionando e variando parâmetros).
% Aplique em um exemplo comente o resultado.

img_rgb = imread('descobrir_numero42.jpeg');
img = rgb2gray(img_rgb);

%% 1.1.1 Negativo
negativo = imcomplement(img);
figure;
subplot(2,2,1);
imshow(img);
title('Img Original (Cinza)');
subplot(2,2,2);
imshow(negativo);
title('Img Negativa');
subplot(2,2,3);
imhist(img);
title('Histograma - Img Original');
subplot(2,2,4);
imhist(negativo);
title('Histograma - Negativa');

%% 1.1.2 Potência de gama
gama = imadjust(img, [], [], 3);
figure;
subplot(2,2,1);
imshow(img);
title('Img Original (Cinza)');
subplot(2,2,2);
imshow(gama);
title('Img Gama');
subplot(2,2,3);
imhist(img);
title('Histograma - Img Original');
subplot(2,2,4);
imhist(gama);
title('Histograma - Gama');

%% 1.1.3 Linearização
linear = imadjust(img, [0.3 0.9], []);
figure;
subplot(2,2,1);
imshow(img);
title('Img Original (Cinza)');
subplot(2,2,2);
imshow(linear);
title('Img Linearizada');
subplot(2,2,3);
imhist(img);
title('Histograma - Img Original');
subplot(2,2,4);
imhist(linear);
title('Histograma - Linearização');

%% 1.1.4 Logaritmo
logaritmo = 1 * log(1+ double(img));
logaritmo = im2uint8(mat2gray(logaritmo));
figure;
subplot(2,2,1);
imshow(img);
title('Img Original (Cinza)');
subplot(2,2,2);
imshow(logaritmo);
title('Img Logaritmo');
subplot(2,2,3);
imhist(img);
title('Histograma - Img Original');
subplot(2,2,4);
imhist(logaritmo);
title('Histograma - Logaritmo');


%% 2 Histgramas e Equalização (Definições)
% * Formas de equalizar histograma.

%% 2.1 Histgramas e Equalização (Aplicação)
% * Aplique em uma imagem comente os resultados.
img_equalizada = histeq(logaritmo, 30);
figure;
subplot(2,2,1);
imshow(img);
title('Img Original (Cinza)');
subplot(2,2,2);
imshow(img_equalizada);
title('Img Equalizada');
subplot(2,2,3);
imhist(img);
title('Histograma - Img Original');
subplot(2,2,4);
imhist(img_equalizada);
title('Histograma - Equalizado');

%% 2.2 Manipulação de contraste
limiar = 94;
atenuacao_realce = double(img_equalizada)/limiar;
contraste_aumentado = atenuacao_realce.^2 ;
contraste_aumentado = uint8(contraste_aumentado*limiar);
figure;
subplot(2,2,1);
imshow(img);
title('Img Original (Cinza)');
subplot(2,2,2);
imshow(contraste_aumentado);
title('Img Contraste');
subplot(2,2,3);
imhist(img);
title('Histograma - Img Original');
subplot(2,2,4);
imhist(contraste_aumentado);
title('Histograma - Contraste');

%% 2.2.1 Binazação
binario = logaritmo <= limiar;
figure;
subplot(2,2,1);
imshow(logaritmo);
title('Img Logarítmo (Cinza)');
subplot(2,2,2);
imshow(binario);
title('Img Binária');
subplot(2,2,3);
imhist(logaritmo);
title('Histograma - Img Logarítmo');
subplot(2,2,4);
imhist(binario);
title('Histograma - Binário');

%% 2.3 Equalização
img_catedral_czs = imread('cruzeiroapocalipse2.jpeg');
img_catedral_czs_equalizado = histeq(img_catedral_czs);

figure;
subplot(1,2,1);
imhist(img_catedral_czs);
title('Histograma Catedral CZS Original');
subplot(1,2,2);
imhist(img_catedral_czs_equalizado);
title('Histograma Catedral CZS Equalizado');

figure;
subplot(1,2,1);
imshow(img_catedral_czs);
title('Img Catedral CZS Original');
subplot(1,2,2);
imshow(img_catedral_czs_equalizado);
title('Img Catedral CZS Equalizada');


%% 3 - Filtros espaciais (Definições) 
% *Correlação:* diz respeito ao cálculo do somatório do produto em dada posição
% de uma máscara movida ao logo de uma imagem.
% *Convolução:* diz respeito a rotação em 180° da *correlação.*
% *Filtro espacial:* como sugere o nome, diz respeito a manipulação de uma
% imagem por meio de um tendo como base um máscara com vizinhança de
% tamanho X.

%% 3.1 - Filtro espacial (Aplicação)
% Utilice a função filtro (‘filtro espacial’) escolha uma mascara w1 e w2. 
% Escolha algumas imagens diferentes. 
% Aplique w1,  comente os resultados 
% Aplique w2,  comente os resultados

img_fe_original = imread('quebra_cabeca.jpeg'); 
img_fe_original = rgb2gray(img_fe_original);
w2 = 1/(11*11) *ones(11,11);
w1 = 1/9*ones(3,3);
img_fe_w1 = imfilter(img_fe_original, w1);
img_fe_w2 = imfilter(img_fe_original, w2);
figure;
subplot(2,2,1);
imshow(img_fe_original);
title('Imagem original');
subplot(2,2,2);
imshow(img_fe_w1, []);
title('Imagem filtrada W1 - Mat 3x3');
subplot(2,2,3);
imshow(img_fe_original);
title('Imagem original');
subplot(2,2,4);
imshow(img_fe_w2, []);
title('Imagem filtrada W2 - Mat 11x11');
