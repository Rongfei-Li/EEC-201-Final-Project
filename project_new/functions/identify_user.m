function [logic] = identify_user(Codebook_series,Codebook_new,Cepstrumt,M)
 % input(Codebook_series):  a group of all codebooks
 % input(Cepstrum): Current Cepstrum to test
 % output(StrOut): User name identified
 Codebooks1 = Codebook_series(:,1:M*1);
Codebooks2 = Codebook_series(:,(M*1+1):M*2);
Codebooks3 = Codebook_series(:,(M*2+1):M*3);
Codebooks4 = Codebook_series(:,(M*3+1):M*4);
Codebooks5 = Codebook_series(:,(M*4+1):M*5);
Codebooks6 = Codebook_series(:,(M*5+1):M*6);
Codebooks7 = Codebook_series(:,(M*6+1):M*7);
Codebooks8 = Codebook_series(:,(M*7+1):M*8);
Codebooks9 = Codebook_series(:,(M*8+1):M*9);
Codebooks10 = Codebook_series(:,(M*9+1):M*10);
Codebooks11 = Codebook_series(:,(M*10+1):M*11);
Codebooks12 = Codebook_new;

[d1] = disteu(Codebooks1,Cepstrumt);
Disturbance1 = sum(min(d1,[],2)) / size(d1,1);
[d2] = disteu(Codebooks2,Cepstrumt);
Disturbance2 = sum(min(d2,[],2)) / size(d2,1);
[d3] = disteu(Codebooks3,Cepstrumt);
Disturbance3 = sum(min(d3,[],2)) / size(d3,1);
[d4] = disteu(Codebooks4,Cepstrumt);
Disturbance4 = sum(min(d4,[],2)) / size(d4,1);
[d5] = disteu(Codebooks5,Cepstrumt);
Disturbance5 = sum(min(d5,[],2)) / size(d5,1);
[d6] = disteu(Codebooks6,Cepstrumt);
Disturbance6 = sum(min(d6,[],2)) / size(d6,1);
[d7] = disteu(Codebooks7,Cepstrumt);
Disturbance7 = sum(min(d7,[],2)) / size(d7,1);
[d8] = disteu(Codebooks8,Cepstrumt);
Disturbance8 = sum(min(d8,[],2)) / size(d8,1);
[d9] = disteu(Codebooks9,Cepstrumt);
Disturbance9 = sum(min(d9,[],2)) / size(d9,1);
[d10] = disteu(Codebooks10,Cepstrumt);
Disturbance10 = sum(min(d10,[],2)) / size(d10,1);
[d11] = disteu(Codebooks11,Cepstrumt);
Disturbance11 = sum(min(d11,[],2)) / size(d11,1);
[d12] = disteu(Codebooks12,Cepstrumt);
Disturbance12 = sum(min(d12,[],2)) / size(d12,1);

Dis = [Disturbance1,Disturbance2,Disturbance3,Disturbance4,Disturbance5,...
    Disturbance6,Disturbance7,Disturbance8,Disturbance9,Disturbance10,Disturbance11,Disturbance12];
index = find(Dis == min(Dis));

if (index == 12)
    logic = 1;
else
    logic = 2;
end
    
end