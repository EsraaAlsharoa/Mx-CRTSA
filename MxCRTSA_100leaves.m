clear;
clc
close all

addpath('dataset','functions');
load('my100leaves.mat')

gamma=0.06;   
lambda=0.1;
for i=1:10
    
    fprintf('----Mx-CRTSA start, attempt number %d--------\n', i);
[Plabel,Timecost(i)] = MxCRTSA(A,gamma,lambda,numClust);
   fprintf('----Mx-CRTSA end, attempt number %d--------\n', i);
acc(i) = ClusteringMeasure(Plabel, truth);
        [~, nmi(i),~] = compute_nmi(truth,Plabel);
        f(i) = compute_f(truth,Plabel);
        if (min(truth)==0)
            AR(i)=RandIndex(truth+1,Plabel);
        else
            AR(i)=RandIndex(truth,Plabel);
        end 
end

fprintf('acc: %.4f    (%.4f)\n' , mean(acc),std(acc));
fprintf('nmi: %.4f  (%.4f)\n' , mean(nmi), std(nmi));
fprintf('AR: %.4f   (%.4f)\n' , mean(AR), std(AR));
fprintf('F-score: %.4f    (%.4f)\n' , mean(f),std(f));
fprintf('Timecost: %.4f  \n\n' , mean(Timecost));

