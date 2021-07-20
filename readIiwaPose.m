function [t_pose,position,orientation] = readIiwaPose(myBag, topic_name, b_time_from_header )

if(nargin < 3)
    b_time_from_header = true;
end

[msg,meta] = myBag.readAll(topic_name);

if(numel(msg)<1)
    warning('No message in the selected topic')
end

t_pose = zeros(1,numel(msg));
position = zeros(3,numel(msg));
orientation = zeros(4,numel(msg));

for i=1:numel(msg)
    if(b_time_from_header)
        t_pose(i) = msg{i}.poseStamped.header.stamp.time;        
    else
        t_pose(i) = meta{i}.time.time;        
    end
    position(:,i) = msg{i}.poseStamped.pose.position;
    orientation(:,i) = [ msg{i}.poseStamped.pose.orientation(4); msg{i}.poseStamped.pose.orientation(1:3) ];
end

end

