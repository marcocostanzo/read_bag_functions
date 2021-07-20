function [Plan] = readPlanResult(myBag, topic_name, Ts , scale)

%scale is assumed a vector of 5 elements (a scale factor for each segment)

[msg,meta] = myBag.readAll(topic_name);

if(numel(msg)<1)
    warning('No message in the selected topic')
end

msg{1} = msg{end};

%Segment from Home to Pre-grasp 
NumSeg = numel(msg{1}.result.pre_grasp_traj);
for h = 1: NumSeg
    
    NumWayPoints = numel(msg{1}.result.pre_grasp_traj(h).points);

    Total_time = [];
    Total_qd = [];
    for k = 1:NumWayPoints-1
        ti = msg{1}.result.pre_grasp_traj(h).points(k).time_from_start.time*scale(1);
        tf = msg{1}.result.pre_grasp_traj(h).points(k+1).time_from_start.time*scale(1);
        t = ti:Ts:tf;
        duration = tf-ti;
        qi = msg{1}.result.pre_grasp_traj(h).points(k).positions;
        qf = msg{1}.result.pre_grasp_traj(h).points(k+1).positions;
        qdi = msg{1}.result.pre_grasp_traj(h).points(k).velocities/scale(1);
        qdf = msg{1}.result.pre_grasp_traj(h).points(k+1).velocities/scale(1);
        qddi = msg{1}.result.pre_grasp_traj(h).points(k).accelerations/scale(1)^2;
        qddf = msg{1}.result.pre_grasp_traj(h).points(k+1).accelerations/scale(1)^2;

        qdk = quintico(t,qi,qf,qdi,qdf,qddi,qddf,ti,duration);
        Total_time = [Total_time t]; 
        Total_qd = [Total_qd;qdk];
    end
    Plan.pre_grasp(h).time = Total_time;
    Plan.pre_grasp(h).qd = Total_qd;
end

%Segment from Pre-grasp to Grasp
NumSeg = numel(msg{1}.result.grasp_traj);
for h = 1:NumSeg
    
    NumWayPoints = numel(msg{1}.result.grasp_traj(h).points);

    Total_time = [];
    Total_qd = [];
    for k = 1:NumWayPoints-1
        ti = msg{1}.result.grasp_traj(h).points(k).time_from_start.time*scale(2);
        tf = msg{1}.result.grasp_traj(h).points(k+1).time_from_start.time*scale(2);
        t = ti:Ts:tf;
        duration = tf-ti;
        qi = msg{1}.result.grasp_traj(h).points(k).positions;
        qf = msg{1}.result.grasp_traj(h).points(k+1).positions;
        qdi = msg{1}.result.grasp_traj(h).points(k).velocities/scale(2);
        qdf = msg{1}.result.grasp_traj(h).points(k+1).velocities/scale(2);
        qddi = msg{1}.result.grasp_traj(h).points(k).accelerations/scale(2)^2;
        qddf = msg{1}.result.grasp_traj(h).points(k+1).accelerations/scale(2)^2;

        qdk = quintico(t,qi,qf,qdi,qdf,qddi,qddf,ti,duration);
        Total_time = [Total_time t]; 
        Total_qd = [Total_qd;qdk];
    end
    Plan.grasp(h).time = Total_time;
    Plan.grasp(h).qd = Total_qd;
end

%Segment from Grasp to Post-Grasp
NumSeg = numel(msg{1}.result.post_grasp_traj);
for h = 1:NumSeg
    
    NumWayPoints = numel(msg{1}.result.post_grasp_traj(h).points);

    Total_time = [];
    Total_qd = [];
    for k = 1:NumWayPoints-1
        ti = msg{1}.result.post_grasp_traj(h).points(k).time_from_start.time*scale(3);
        tf = msg{1}.result.post_grasp_traj(h).points(k+1).time_from_start.time*scale(3);
        t = ti:Ts:tf;
        duration = tf-ti;
        qi = msg{1}.result.post_grasp_traj(h).points(k).positions;
        qf = msg{1}.result.post_grasp_traj(h).points(k+1).positions;
        qdi = msg{1}.result.post_grasp_traj(h).points(k).velocities/scale(3);
        qdf = msg{1}.result.post_grasp_traj(h).points(k+1).velocities/scale(3);
        qddi = msg{1}.result.post_grasp_traj(h).points(k).accelerations/scale(3)^2;
        qddf = msg{1}.result.post_grasp_traj(h).points(k+1).accelerations/scale(3)^2;

        qdk = quintico(t,qi,qf,qdi,qdf,qddi,qddf,ti,duration);
        Total_time = [Total_time t]; 
        Total_qd = [Total_qd;qdk];
    end
    Plan.post_grasp(h).time = Total_time;
    Plan.post_grasp(h).qd = Total_qd;
end

%Segment from Post-grasp to Pre-Place
NumSeg = numel(msg{1}.result.pre_place_traj);
for h = 1:NumSeg
    
    NumWayPoints = numel(msg{1}.result.pre_place_traj(h).points);

    Total_time = [];
    Total_qd = [];
    for k = 1:NumWayPoints-1
        ti = msg{1}.result.pre_place_traj(h).points(k).time_from_start.time*scale(4);
        tf = msg{1}.result.pre_place_traj(h).points(k+1).time_from_start.time*scale(4);
        t = ti:Ts:tf;
        duration = tf-ti;
        qi = msg{1}.result.pre_place_traj(h).points(k).positions;
        qf = msg{1}.result.pre_place_traj(h).points(k+1).positions;
        qdi = msg{1}.result.pre_place_traj(h).points(k).velocities/scale(4);
        qdf = msg{1}.result.pre_place_traj(h).points(k+1).velocities/scale(4);
        qddi = msg{1}.result.pre_place_traj(h).points(k).accelerations/scale(4)^2;
        qddf = msg{1}.result.pre_place_traj(h).points(k+1).accelerations/scale(4)^2;

        qdk = quintico(t,qi,qf,qdi,qdf,qddi,qddf,ti,duration);
        Total_time = [Total_time t]; 
        Total_qd = [Total_qd;qdk];
    end
    Plan.pre_place(h).time = Total_time;
    Plan.pre_place(h).qd = Total_qd;
    Plan.pre_place(h).mode = msg{1}.result.pre_place_pivoting_mode(h);
end

%Segment from Pre-Place to Place 
NumSeg = numel(msg{1}.result.place_traj);
for h = 1:NumSeg
    
    NumWayPoints = numel(msg{1}.result.place_traj(h).points);
    
    if msg{1}.result.place_pivoting_mode(h) == 1
        scale_1=scale(5)*2;
    else
        scale_1=scale(5);
    end
    
    Total_time = [];
    Total_qd = [];
    for k = 1:NumWayPoints-1
        ti = msg{1}.result.place_traj(h).points(k).time_from_start.time*scale_1;
        tf = msg{1}.result.place_traj(h).points(k+1).time_from_start.time*scale_1;
        t = ti:Ts:tf;
        duration = tf-ti;
        qi = msg{1}.result.place_traj(h).points(k).positions;
        qf = msg{1}.result.place_traj(h).points(k+1).positions;
        qdi = msg{1}.result.place_traj(h).points(k).velocities/scale_1;
        qdf = msg{1}.result.place_traj(h).points(k+1).velocities/scale_1;
        qddi = msg{1}.result.place_traj(h).points(k).accelerations/scale_1^2;
        qddf = msg{1}.result.place_traj(h).points(k+1).accelerations/scale_1^2;

        qdk = quintico(t,qi,qf,qdi,qdf,qddi,qddf,ti,duration);
        Total_time = [Total_time t]; 
        Total_qd = [Total_qd;qdk];
    end
    Plan.place(h).time = Total_time;
    Plan.place(h).qd = Total_qd;
    Plan.place(h).mode = msg{1}.result.place_pivoting_mode(h);
end

end