function CSPMatrix = learnCSP(EEGSignals,classLabels)
nbChannels = size(EEGSignals.x,2);      % 通道
nbTrials = size(EEGSignals.x,3);        % 实验次数
nbClasses = length(classLabels);        % 类别

if nbClasses ~= 2
    disp('ERROR! CSP can only be used for two classes');
    return;
end

covMatrices = cell(nbClasses,1); %the covariance matrices for each class

%% 为每个试验计算标准化的协方差矩阵。
trialCov = zeros(nbChannels,nbChannels,nbTrials);
for t=1:nbTrials
    E = EEGSignals.x(:,:,t)';                       %note the transpose
    EE = E * E';
    trialCov(:,:,t) = EE ./ trace(EE);
end
clear E;
clear EE;

for c=1:nbClasses      
    covMatrices{c} = mean(trialCov(:,:,EEGSignals.y == classLabels(c)),3);  
end
covTotal = covMatrices{1} + covMatrices{2};
[Ut Dt] = eig(covTotal); 
eigenvalues = diag(Dt);
[eigenvalues egIndex] = sort(eigenvalues, 'descend');
Ut = Ut(:,egIndex);
P = diag(sqrt(1./eigenvalues)) * Ut';
%用P变换第一类协方差矩阵
transformedCov1 =  P * covMatrices{1} * P';

%变换协方差矩阵的EVD
[U1 D1] = eig(transformedCov1);
eigenvalues = diag(D1);
[eigenvalues egIndex] = sort(eigenvalues, 'descend');
U1 = U1(:, egIndex);
CSPMatrix = U1' * P;
