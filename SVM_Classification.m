%% 主函数
clc;
clear all;

run_FeatureExtract

load dataCSP.mat 
load mine6.mat

%% X为训练集， T测试集， Y训练标签
%% SVM
model = fitcsvm(X,Y);
[fpredict1,fpredict2] = predict(model,T);
fpredict=[fpredict1,fpredict2];

acc=size(find((fpredict1-y_test)==0),1)/size(y_test,1);
fprintf(strcat('正确率=',num2str(acc*100),'%%'));
