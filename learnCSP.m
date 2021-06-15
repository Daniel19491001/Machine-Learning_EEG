function CSPMatrix = learnCSP(EEGSignals,classLabels)
nbChannels = size(EEGSignals.x,2);      % ͨ��
nbTrials = size(EEGSignals.x,3);        % ʵ�����
nbClasses = length(classLabels);        % ���

if nbClasses ~= 2
    disp('ERROR! CSP can only be used for two classes');
    return;
end

covMatrices = cell(nbClasses,1); %the covariance matrices for each class

%% Ϊÿ����������׼����Э�������
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
%��P�任��һ��Э�������
transformedCov1 =  P * covMatrices{1} * P';

%�任Э��������EVD
[U1 D1] = eig(transformedCov1);
eigenvalues = diag(D1);
[eigenvalues egIndex] = sort(eigenvalues, 'descend');
U1 = U1(:, egIndex);
CSPMatrix = U1' * P;
