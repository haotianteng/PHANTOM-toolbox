function state = Trigger(Session,Channel,State)
%This function will send a trigger to the 
ChannelList = zeros(1,2);
ChannelList(Channel) = State;
Session.outputSingleScan(ChannelList);
end