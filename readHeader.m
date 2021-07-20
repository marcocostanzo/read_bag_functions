function SyncTraj = readHeader(myBag, topic_name)

[msg,meta] = myBag.readAll(topic_name);

if(numel(msg)<1)
    warning('No message in the selected topic')
end

k = 1;
for i=1:numel(msg)
   switch msg{i}.frame_id
          case 'pre_grasp'
            SyncTraj(k).name = 'pre_grasp';
            SyncTraj(k).t0 = msg{i}.stamp.time;
            k = k+1;
          case 'grasp'
            SyncTraj(k).name = 'grasp';
            SyncTraj(k).t0 = msg{i}.stamp.time;
            k = k+1;
          case 'post_grasp'
            SyncTraj(k).name = 'post_grasp';
            SyncTraj(k).t0 = msg{i}.stamp.time;
            k = k+1;
          case 'pre_place'
            SyncTraj(k).name = 'pre_place';
            SyncTraj(k).t0 = msg{i}.stamp.time;
            k = k+1;
          case 'place'
            SyncTraj(k).name = 'place';
            SyncTraj(k).t0 = msg{i}.stamp.time;
            k = k+1;
          otherwise 
            ;
   end
end

end

