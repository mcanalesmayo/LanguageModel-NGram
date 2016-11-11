function terms = strsplit(s, delimiter)
%STRSPLIT Splits a string into multiple terms
%
%   terms = strsplit(s)
%       splits the string s into multiple terms that are separated by
%       white spaces (white spaces also include tab and newline).
%
%       The extracted terms are returned in form of a cell array of
%       strings.
%
%   terms = strsplit(s, delimiter)
%       splits the string s into multiple terms that are separated by
%       the specified delimiter.

%% parse and verify input arguments

assert(ischar(s) && ndims(s) == 2 && size(s,1) <= 1, ...
    'strsplit:invalidarg', ...
    'The first input argument should be a char string.');

if nargin < 2
    d = ' ';
else
    d = delimiter;
end

disp(s)

%% main
p = regexp(s, d);
% remove delimiters that do not appear in this text
if iscell(p)
    d = d(~cellfun('isempty',p));
    p = p(~cellfun('isempty',p));
end

if iscell(d) num_delimiters = length(d); else num_delimiters = 1; end
delimiters = []; delimiters_length = []; delimiters_position = [];
for i=1:num_delimiters
    if iscell(d) delimiter_i = d{i}; else delimiter_i = d; end
    if iscell(p) delimiter_i_p = p{i}; else delimiter_i_p = p; end
    if strcmp(delimiter_i,'\.') di_length = 1; else di_length = 1; end %length(delimiter_i); end
    delimiters = [delimiters delimiter_i];
    delimiters_length = [delimiters_length di_length*ones(1,length(delimiter_i_p))];
    delimiters_position = [delimiters_position delimiter_i_p];
end

if ~isempty(delimiters_position)
    
    [delimiters_position,indexes] = sort(delimiters_position);
    delimiters_length = delimiters_length(indexes);
    diffs = diff(delimiters_position);
    if ~isempty(diffs)
        new_delimiters_position = [];
        new_delimiters_length = [];
        i = 1;
        while i<=length(diffs)
            new_delimiters_position = [new_delimiters_position delimiters_position(i)];
            new_delimiters_length = [new_delimiters_length delimiters_length(i)];
            how_many = 0;
            consecutive = false;
            while diffs(i)==1
                how_many = how_many+1;
                i = i + 1;
                consecutive = true;
                if i>length(diffs) break; end
            end
            if consecutive
                if i+how_many>length(delimiters_length)
                    new_delimiters_length(end) = delimiters_length(i)+1;
                else
                    new_delimiters_length(end) = sum(delimiters_length(i-how_many:i));
                end
            end
            i=i+1;
            
        end
        
        if diffs(end)~=1
            new_delimiters_position = [new_delimiters_position delimiters_position(end)];
            new_delimiters_length = [new_delimiters_length delimiters_length(end)];
        end
        
    else
        
        new_delimiters_position = delimiters_position;
        new_delimiters_length = delimiters_length;
        
    end
    
    % extract the terms
    nt = numel(new_delimiters_position) + 1;
    terms = cell(1, nt);
    sp = 1;
    for i = 1 : nt-1
        dl = new_delimiters_length(i);
        terms{i} = strtrim(s(sp:new_delimiters_position(i)-1));
        sp = new_delimiters_position(i) + dl;
    end
    terms{nt} = strtrim(s(sp:end));
    
else
    
    terms = {};
    
end