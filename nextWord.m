function nextw = nextWord(prev, mdl, mode)
%NEXTWORD generates next word based on a bigram or trigram model
%   By default this function uses a bigram model

if nargin == 2                                  % bigram mode is default
    mode = 'bigram';
end

isBiMode = ismember(mode, {'bigram', 'bi'});    % bigram mode
if strcmp(class(mdl), 'bigramClass')            % if bigramClass
    biMdl = mdl.mdl;                            % it has one model
elseif strcmp(class(mdl), 'trigramClass')       % if trigramClass
    biMdl = mdl.bigMdl;                         % it has two models
    triMdl = mdl.mdl;
end

if isBiMode                                     % if bigram mode
    row = strcmp(mdl.unigrams, prev);           % select unigram index
    isCandidate = biMdl(row,:) > 0;             % select non-zero values
    prob = biMdl(row, isCandidate);             % extract probabilities
else                                            % if trigram mode
    row = strcmp(mdl.bigrams, prev);            % select bigram index
    isCandidate = triMdl(row,:) > 0;            % select non-zero values
    prob = triMdl(row, isCandidate);            % extract probabilities
end

candidates = mdl.unigrams(isCandidate);         % extract candidate words
samples = round(prob * 10000);                  % create 10000 samples
                                                % based on probabilities
                                                % round it to an integer           
csum = [0 cumsum(samples)];                     % cumulative sum of samples
try
    pick = randsample(csum(end), 1);            % randomly pick a sample
    idx = find(csum >= pick, 1);                % find where it falls in csum
    nextw = candidates{idx - 1};                % get the corresponding word
catch                                           % an error ocurred
    nextw = '</s>';                             % return </s> as next word
end

end

