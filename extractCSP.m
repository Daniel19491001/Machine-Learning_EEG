function features = extractCSP(EEGSignals, CSPMatrix, nbFilterPairs)
nbTrials = size(EEGSignals.x,3);
features = zeros(nbTrials, 2*nbFilterPairs+1);
Filter = CSPMatrix([1:nbFilterPairs (end-nbFilterPairs+1):end],:);
for t=1:nbTrials     
    projectedTrial = Filter * EEGSignals.x(:,:,t)';    
    variances = var(projectedTrial,0,2);    
    for f=1:length(variances)
        features(t,f) = log(1+variances(f));
    end
end
