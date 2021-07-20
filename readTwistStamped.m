function [t_v,v] = readTwistStamped(myBag, topic_name, b_time_from_header )

if(nargin < 3)
    b_time_from_header = true;
end

[msg,meta] = myBag.readAll(topic_name);

if(numel(msg)<1)
    warning('No message in the selected topic')
end

t_v = zeros(1,numel(msg));
v = zeros(6,numel(msg));

for i=1:numel(msg)
    if(b_time_from_header)
        t_v(i) = msg{i}.header.stamp.time;        
    else
        t_v(i) = meta{i}.time.time;        
    end
    v(:,i) = [msg{i}.twist.linear; msg{i}.twist.angular];
end

end

