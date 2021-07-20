function [t, position, velocity, effort] = readJointStates(myBag, topic_name, joints_to_read, b_time_from_header )

if(nargin < 4)
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
position = zeros(numel(joints_to_read),numel(msg));
velocity = zeros(numel(joints_to_read),numel(msg));
if(nargout>=4)
effort = zeros(numel(joints_to_read),numel(msg));
end

for i=1:numel(msg)     
    if(b_time_from_header)
        t(i) = msg{i}.header.stamp.time;        
    else
        t(i) = meta{i}.time.time;        
    end
    for j=1:numel(joints_to_read)
        index = find(strcmp(msg{i}.name, joints_to_read{j}),1);
        if isempty(index)
            position(j,i) = NaN;
            velocity(j,i) = NaN;
            if(nargout>=4)
            effort(j,i) = NaN;
            end
        else
            position(j,i) = msg{i}.position(index);
            velocity(j,i) = msg{i}.velocity(index);
            if(nargout>=4)
            effort(j,i) = msg{i}.effort(index);
            end
        end
    end
end

end

