function component = makeComponent(compName,type, tolerance, Nodes)
% MAKECOMPONENT is used to input each component. It returns the component
% array useful to create the netlist. 
%compName - follows spice syntax of naming
%type - component value, library type or source type with parameters
%tolerance - % tolerance on component parameters used for NaN handling, use
%0 when no variation allowed
%Nodes - set of nodes component/subcircuit is connected to, no limitation
%on length
component.name = compName;
component.type = type;
component.tol = tolerance;
component.nodes = Nodes;
end
