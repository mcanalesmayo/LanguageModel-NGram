bookA = fileread('books/RomeoAndJuliet.txt');
bookB = fileread('books/ASystemOfPracticalMedicine.txt');
delimiters = {' ', '!', ',', '-', '\.', ':', ';', '?', '\r', '\n', '-', '&'};
sentencesA = lower(preprocess(bookA));
sentencesB = lower(preprocess(bookB));

% Bigram book A
biMdl = bigramClass(delimiters);
biMdl.build(sentencesA);

% Start of sentence
word = '<s>';
fprintf('%s ', word);
% Until end of sentence
while strcmp(word, '</s>') ~= 1
    word = nextWord(word, biMdl);
    fprintf('%s ', word);
end
fprintf('%n');
pause(15);

% Trigram book A
triMdl = trigramClass(delimiters);
triMdl.build(sentencesA, biMdl);

% Start of sentence
word = '<s>';
fprintf('%s ', word);
% Until end of sentence
while strcmp(word, '</s>') ~= 1
    word = nextWord(word, triMdl);
    fprintf('%s ', word);
end
fprintf('%n');
pause(15);

% Bigram book B
biMdl = bigramClass(delimiters);
biMdl.build(sentencesB);

% Start of sentence
word = '<s>';
fprintf('%s ', word);
% Until end of sentence
while strcmp(word, '</s>') ~= 1
    word = nextWord(word, biMdl);
    fprintf('%s ', word);
end
fprintf('%n');
pause(15);

% Posible "Excess of array dimensions (memory)"
% Trigram book B
triMdl = trigramClass(delimiters);
triMdl.build(sentencesB, biMdl);
% Start of sentence
word = '<s>';
fprintf('%s ', word);
% Until end of sentence
while strcmp(word, '</s>') ~= 1
    word = nextWord(word, triMdl);
    fprintf('%s ', word);
end
fprintf('%n');