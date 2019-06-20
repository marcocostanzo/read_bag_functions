function [t_w,w] = readWrenchStamped(myBag, topic_name, b_time_from_header )

if(nargin < 3)
    b_time_from_header = true;
end

[msg,meta] = myBag.readAll(topic_name);

if(numel(msg)<1)
    warning('No message in the selected topic')
end

t_w = zeros(1,numel(msg));
w = zeros(6,numel(msg));

for i=1:numel(msg)
    if(b_time_from_header)
        t_w(i) = msg{i}.header.stamp.time;        
    else
        t_w(i) = meta{i}.time.time;        
    end
    w(:,i) = [msg{i}.wrench.force; msg{i}.wrench.torque];
end

end

