function [time,ls_struct] = readLSCombinedStamped(myBag, topic_name, b_time_from_header )

if(nargin < 3)
    b_time_from_header = true;
end

[msg,meta] = myBag.readAll(topic_name);

if(numel(msg)<1)
    warning('No message in the selected topic')
    ls_struct=[];
    time = [];
    return;
end

time = zeros(1,numel(msg));
ls_struct(numel(msg)) = struct(...
                    'time',[],...
                    'sigma', [], ...
                    'cor_tilde',[],...
                    'cor',[],...
                    'ft_tilde_ls',[],...
                    'taun_tilde_ls',[],...
                    'ft_ls',[],...
                    'taun_ls',[],...
                    'radius',[],...
                    'generalized_max_force',[],...
                    'generalized_max_force0',[],...
                    'generalized_max_force1',[],...
                    'generalized_force',[],...
                    'generalized_force0',[],...
                    'generalized_force1',[],...
                    'fn_ls',[],...
                    'fn_ls_free_pivot',[]...
                    );
                
for i=1:numel(msg)
    if(b_time_from_header)
        time(i) = msg{i}.header.stamp.time;        
    else
        time(i) = meta{i}.time.time;        
    end
    ls_struct(i).time = time(i);
    ls_struct(i).sigma = msg{i}.sigma;
    ls_struct(i).cor_tilde = msg{i}.cor_tilde;
    ls_struct(i).cor = msg{i}.cor;
    ls_struct(i).ft_tilde_ls = msg{i}.ft_tilde_ls;
    ls_struct(i).taun_tilde_ls = msg{i}.taun_tilde_ls;
    ls_struct(i).ft_ls = msg{i}.ft_ls;
    ls_struct(i).taun_ls = msg{i}.taun_ls;
    ls_struct(i).radius = msg{i}.radius;
    ls_struct(i).generalized_max_force = msg{i}.generalized_max_force;
    ls_struct(i).generalized_max_force0 = msg{i}.generalized_max_force0;
    ls_struct(i).generalized_max_force1 = msg{i}.generalized_max_force1;
    ls_struct(i).generalized_force = msg{i}.generalized_force;
    ls_struct(i).generalized_force0 = msg{i}.generalized_force0;
    ls_struct(i).generalized_force1 = msg{i}.generalized_force1;
    ls_struct(i).fn_ls = msg{i}.fn_ls;
    ls_struct(i).fn_ls_free_pivot = msg{i}.fn_ls_free_pivot;

end





end

