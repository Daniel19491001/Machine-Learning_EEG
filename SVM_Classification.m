%% ������
clc;
clear all;

run_FeatureExtract

load dataCSP.mat 
load mine6.mat

%% XΪѵ������ T���Լ��� Yѵ����ǩ
%% SVM
model = fitcsvm(X,Y);
[fpredict1,fpredict2] = predict(model,T);
fpredict=[fpredict1,fpredict2];

acc=size(find((fpredict1-y_test)==0),1)/size(y_test,1);
fprintf(strcat('��ȷ��=',num2str(acc*100),'%%'));
