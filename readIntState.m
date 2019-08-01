function [t,f] = readIntState(myBag, topic_name, b_time_from_header )

if(nargin < 3)
    b_time_from_header = true;
end

[msg,meta] = myBag.readAll(topic_name);

if(numel(msg)<1)
    warning('No message in the selected topic')
else
    if ~isfield(msg{1},'header')
        b_time_from_header = false;
    end
end

t = zeros(1,numel(msg));
f = zeros(1,numel(msg));

for i=1:numel(msg)     
    if(b_time_from_header)
        t(i) = msg{i}.header.stamp.time;        
    else
        t(i) = meta{i}.time.time;        
    end
    f(i) = msg{i}.state;
end

end

