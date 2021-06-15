SVM_Classification.m为主函数，其他三个.m文件为应用到的函数。
s003r04final.set与s003r08final.set分别为第四步数据和第八步数据预处理完后的数据。
mine1.mat和mine2.mat为从EEG.data提取出的数据。
mine3.mat和mine4.mat为第四步为训练集，第八步为测试集的数据。
mine5.mat和mine6.mat为第四步为训练集，第四步为测试集的数据。
将主函数和run_FeatureExtract.m中load语句改成对应的数据文件即可查看实验结果。
dataCSP.mat为过程中产生的数据，代表经过CSP算法后的数据。