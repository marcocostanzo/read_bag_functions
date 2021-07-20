function [t,d] = readMultiArray(myBag, topic_name )

[msg,meta] = myBag.readAll(topic_name);

if(numel(msg)>0)
    num_d = numel(msg{1}.data);
else
    num_d = 0;
    warning('No message in the selected topic')
end

t = zeros(1,numel(msg));
d = zeros(num_d,numel(msg));

for i=1:numel(msg)
    t(i) = meta{i}.time.time;        
    d(:,i) = msg{i}.data;
end

end

