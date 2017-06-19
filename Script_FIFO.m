%% Script taxa de confiança M/D/1 %%
close all
clear all
clc
format long
%declaracao de variaveis
P=.95;
L=7;
u=[.5 .8 .9 .95];
C=size(u,2);
%% Cálculo da Curva Teórica
serviceTime=0.025;
ut=0:0.01:0.99;
Ew=((ut*serviceTime)./(2*(1-ut)));
figure
plot(ut,Ew)
title('Atraso médio na fila -TEÓRICO-')
xlabel('Utilização (u)')
ylabel('Atraso médio (Ew)')
%% Gráfico da curva simulada
EwS7=load('data.txt');
media=zeros(C,1);
d=zeros(C,1);
%calculo da media e desvio padrao
for j=1:C
    PEwS7(j,:)=EwS7(j*(1:L));
    media(j,1)=mean(EwS7(j*(1:L)));
    d(j,1)=std(EwS7(j*(1:L)));
end
%calcula o desvio padrao do estimador
s=d/sqrt(L); % com desvio estimado

%calcula os intervalos de confianca
alfa=1-P;
z=tinv(alfa/2, L-1);
ci=[media'-z*s'; media'+z*s'];

figure
plot(u,media,'-ro')
hold on

title('Atraso médio na fila -SIMULAÇÃO-')
xlabel('Utilização (u)')
ylabel('Atraso médio (Ew)')

%% Comparção entre curvas obtidas
figure
plot(u,PEwS7','go',ut,Ew,u,media','r*')
hold on
%plota intervalos de confianca
plot([u; u],ci,'k-+')
hold on
%verifica quais intervalos nao contem a media teorica e plota em vermelho
fora = (ci(2,:)>u(1,:)) | (ci(1,:)<u(1,:));
[f i]=find(fora>0);
plot([u(i); u(i)],ci(:,i),'r-+')
Confianca=P*100
Nfora=sum(fora)
Acertos=(1-Nfora/C)*100
msg=sprintf('%d intervalos nao contem a media. %2.0f%% dos intervalos contem a media',Nfora, Acertos);
text(.32,.3,msg)

title('Atraso médio na fila -COMPARAÇÃO-')
xlabel('Utilização (u)')
ylabel('Atraso médio (Ew)')
axis([0.3,1,0,0.6])