function [t_v,v] = readTactileStamped(myBag, topic_name, b_time_from_header )

if(nargin < 3)
    b_time_from_header = true;
end

[msg,meta] = myBag.readAll(topic_name);

if(numel(msg)>0)
    num_v = msg{1}.tactile.rows*msg{1}.tactile.cols;
else
    num_v = 0;
    warning('No message in the selected topic')
end

t_v = zeros(1,numel(msg));
v = zeros(num_v,numel(msg));

for i=1:numel(msg)
    if(b_time_from_header)
        t_v(i) = msg{i}.header.stamp.time;        
    else
        t_v(i) = meta{i}.time.time;        
    end
    v(:,i) = msg{i}.tactile.data;
end

end

