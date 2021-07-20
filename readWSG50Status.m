function [t,width,speed] = readWSG50Status(myBag, topic_name, b_time_from_header )

if(nargin < 3)
    b_time_from_header = true;
end

[msg,meta] = myBag.readAll(topic_name);

if(numel(msg)<1)
    warning('No message in the selected topic')
end

t = zeros(1,numel(msg));
width = zeros(1,numel(msg));
speed = zeros(1,numel(msg));

for i=1:numel(msg)
    if(b_time_from_header)
        t(i) = msg{i}.header.stamp.time;        
    else
        t(i) = meta{i}.time.time;        
    end
    t(i) = meta{i}.time.time;        
    width(i) = msg{i}.width;
    speed(i) = msg{i}.speed;
end

end

