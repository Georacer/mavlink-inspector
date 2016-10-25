function [ date ] = stamp2date( stamp, lock_usec, lock_date )
%STAMP2DATE Summary of this function goes here
%   Detailed explanation goes here

date = (stamp-lock_usec)/1000000/60/60/24 + lock_date;

end
