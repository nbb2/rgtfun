function cfg = loadinputfile(filepath)
    % Reads lines like: name = value;
    txt = fileread(filepath);
    pairs = regexp(txt, '(?<key>[A-Za-z]\w*)\s*=\s*(?<val>[^;]+);', 'names');
    cfg = struct();
    for k = 1:numel(pairs)
        key = pairs(k).key;
        raw = strtrim(pairs(k).val);
        if (startsWith(raw, '"') && endsWith(raw, '"')) || ...
           (startsWith(raw, '''') && endsWith(raw, ''''))
            val = raw(2:end-1);              
        else
            num = str2double(raw);
            if ~isnan(num)
                val = num;
            else
                val = raw;
            end
        end
        cfg.(key) = val;
    end
end