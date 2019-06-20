function [t,d] = readMultiVectorStamped(myBag, topic_name, b_time_from_header )

if(nargin < 3)
    b_time_from_header = true;
end

[msg,meta] = myBag.readAll(topic_name);

if(numel(msg)>0)
    num_d = numel(msg{1}.data.data);
else
    num_d = 0;
    warning('No message in the selected topic')
end

t = zeros(1,numel(msg));
d = zeros(num_d,numel(msg));

for i=1:numel(msg)
    if(b_time_from_header)
        t(i) = msg{i}.header.stamp.time;        
    else
        t(i) = meta{i}.time.time;        
    end
    d(:,i) = msg{i}.data.data;
end

end

