classdef Series
    %SERIES Series class definition
    %   Detailed explanation goes here
    
    properties
        series
        names
        x_labels
        plot_cmd
    end
    
    methods
        function plot(this)
            eval(this.plot_cmd);
        end
    end
    
end

