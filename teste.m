% plotic.m
% plota Intervalos de confianca do estimador da media
% verifica quando o intervalo de confiança acerta (contem a média teórica)
% e quando erra (não contem a média teórica)
% Prof. Eduardo Parente Ribeiro - UFPR

% Experimente trocar valores de P, L, C, mu, sigma

% confiança (95%)
P=0.95;

L=40; %linhas. Numero de pontos do estimador
C=100; %colunas. numero de replicações

% gera matriz LxC de numeros aleatorios com distribuicao 

% normal, mu e sigma
mu=15;
sigma=2;
r = normrnd(mu,sigma,L,C);

%Exponencial
%mu=1; %media = sigma = lambda
%sigma = mu;
%r = exprnd(mu,L,C);


%calcula a media de cada uma das colunas
m=mean(r);

%calcula o desvio padrao de cada uma das colunas
d=std(r);

%calcula o desvio padrao do estimador
%s=sigma/sqrt(L); % com desvio real
s=d/sqrt(L); % com desvio estimado


%calcula os intervalos de confianca
alfa=1-P;
%z=norminv(alfa/2);
z=tinv(alfa/2, L-1);
ci=[m-z*s; m+z*s];

figure
clf
E=[1 C];
t=1:C;

%plota linha na media teorica e circulos nas medias estimadas
plot(t,mu*ones(1,C),t,m,'ro')
hold on

%plota intervalos de confianca
plot([t; t],ci,'k-+')

%verifica quais intervalos nao contem a media teorica e plota em vermelho
fora = (ci(2,:)>mu) | (ci(1,:)<mu);
[f i]=find(fora>0);
plot([t(i); t(i)],ci(:,i),'r-+')
Confianca=P*100
Nfora=sum(fora)
Acertos=(1-Nfora/C)*100
s=sprintf('%d intervalos nao contem a media. %2.0f%% dos intervalos contem a media',Nfora, Acertos);
text(1,min(ci(2,:)),s)

%ajusta a escala
%axis([0 C+1 -2 2])
