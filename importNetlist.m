function [Libs, Options, ICs, Params, Extras, netlist, Components] = importNetlist()


%Get the user-specified path and filename

[file,newpath] = uigetfile;
oldpath = path;
path(oldpath,newpath)

fileID = fopen(file,'r');
read = fscanf(fileID,'%c');
fclose(fileID);
path(oldpath)


%Pre-processing: Split file into lines and remove excess spaces

netlist = strsplit(read,'\n');
flag = 0; %flag for + being found
index = 0; %index of the main stuff when + appears
i = 1;

while i <= length(netlist)
    
    line = netlist(i);
    while isempty(line{1})
        netlist(i) = [];
        disp('Empty line removed')
        if i <= length(netlist)
        line = netlist(i);
        else
            break
        end
    end
    if i <= length(netlist)
    line_ch = char(string(line{1}));

    while line_ch(1) == ' '
        line_ch = line_ch(2:length(line_ch));

    end
    netlist(i) = {string(line_ch)};
    line = netlist(i);

    if (line{1} == '+')&(flag==0)

        index = netlist(i-1);

    end

    if (line{1} == '+')&(flag==1)

       netlist(index) = append(netlist(index),line{2:length(line)});

    end

    if (line{1} ~= '+')&(flag==1)

        flag = 0;

    end

i = i+1;
    else
        break
    end
end
i=1;
%Pre-processing: remove the '+' lines


for i = 1:length(netlist)
    check = 1;
    while check == 1
    line = netlist(i);
    if (line{1} == '+')
        netlist(i) = [];

    else
        check = 0;

    end
    end

end


%Loop with switch case on element types, depending on element type chose
%formatting
a = 0;b=0;c=0;d=0;e=0;f=0;g=0;h=0;ii=0;j=0;k=0;l=0;m=0;o=0;q=0;r=0;s=0;t=0;u=0;v=0;w=0;x=0;z=0;
lib=0;opt=0;ic=0;par=0;
ext=0;

for i = 1:length(netlist)
    
    line = netlist(i);
    line_str = string(line{1});
    line_split = strsplit(line_str,' ');
    value = char(line_split(1));
    switch value(1)
%Components: Get A's
        case 'A'
           a = a+1;     
           A(a) = makeComponent(line_split(1),line_split(10:length(line_split)),0,line_split(2:9));

%Components: Get behavioural sources
        case 'B'
            b = b+1;
            B(b) = makeComponent(line_split(1),line_split(4:length(line_split)),0,line_split(2:3));

%Components: Get capacitors
        case 'C'
            c=c+1;
            C(c) = makeComponent(line_split(1),line_split(4:length(line_split)),0,line_split(2:3));

%Components: Get diodes
        case 'D'
            d=d+1;
            D(d) = makeComponent(line_split(1),line_split(4:length(line_split)),0,line_split(2:3));

%Components: Get voltage dependent v sources
        case 'E'
            e = e+1;
            E(e) = makeComponent(line_split(1),line_split(6:length(line_split)),0,line_split(2:5));

%Components: Get current dependent I sources
        case 'F'
            f = f+1;
            F(f) = makeComponent(line_split(1),line_split(4:length(line_split)),0,line_split(2:3));

%Components: Get v dependent I sources
        case 'G'
            g = g+1;
            G(g) = makeComponent(line_split(1),line_split(6:length(line_split)),0,line_split(2:5));

%Components: Get I dependent v sources
        case 'H'
            h = h+1;
            H(h) = makeComponent(line_split(1),line_split(4:length(line_split)),0,line_split(2:3));

%Components: Get strong and independent I sources
        case 'I'
            ii = ii+1;
            I(ii) = makeComponent(line_split(1),line_split(4:length(line_split)),0,line_split(2:3));

%Components: Get Jfets
        case 'J'
            j = j+1;
            J(j) = makeComponent(line_split(1),line_split(5:length(line_split)),0,line_split(2:4));

%Components: Get mutual inductances
        case 'K'
            k = k+1;
            K(k) = makeComponent(line_split(1),line_split(2:length(line_split)),0,'');

%Components: Get inductances
        case 'L'
            l = l+1;
            L(l) = makeComponent(line_split(1),line_split(4:length(line_split)),0,line_split(2:3));

%Components: Get Mosfets
        case 'M'
            m = m+1;
            M(m) = makeComponent(line_split(1),line_split(6:length(line_split)),0,line_split(2:5));

%Components: Get Lossy transmission lines
        case 'O'
            o = o+1;
            O(o) = makeComponent(line_split(1),line_split(6:length(line_split)),0,line_split(2:5));

%Components: Get bipolar transistors
        case 'Q'
            q = q+1;
            Q(q) = makeComponent(line_split(1),line_split(5:length(line_split)),0,line_split(2:4));

%Components: Get resistors
        case 'R'
            r = r+1;
            R(r) = makeComponent(line_split(1),line_split(4:length(line_split)),0,line_split(2:3));

%Components: Get v controlled switches
        case 'S'
            s = s+1;
            S(s) = makeComponent(line_split(1),line_split(6:length(line_split)),0,line_split(2:5));

%Components: Get lossless transmission lines
        case 'T'
            t =t+1;
            T(t) = makeComponent(line_split(1),line_split(6:length(line_split)),0,line_split(2:5));

%Components: Get uniform RC-lines
        case 'U'
            u=u+1;
            U(u) = makeComponent(line_split(1),line_split(5:length(line_split)),0,line_split(2:4));

%Components: Get independent voltage source
        case 'V'
            v = v+1;
            V(v) = makeComponent(line_split(1),line_split(4:length(line_split)),0,line_split(2:3));

%Components: Get current controlled switches
        case 'W'
            w = w+1;
            W(w) = makeComponent(line_split(1),line_split(4:length(line_split)),0,line_split(2:3));

%Components: Get subcircuits
        case 'X'
            x = x+1;
            X(x) = makeComponent(line_split(1),line_split(length(line_split)-1),0,line_split(2:(length(line_split)-2)));

%Components: Get Mosfet or IGBT transistors (Z elements)
        case 'Z'
            z = z+1;
            Z(z) = makeComponent(line_split(1),line_split(5:length(line_split)),0,line_split(2:4));


%Libraries: Get
        case '.'
if value(2:3) == 'in'
    lib = lib+1;
    Libs(lib) = makeLib(extractBefore(line_split(2),'.'),extractAfter(line_split(2),'.'));

end

%Initial conditions: Get name value pairs
if value(2:3)  == 'ic'
    ic=ic+1;
    ICs(ic) = makeIC(line_split(2),line_split(4));

    line = line_split(5:length(line_split));
    while length(line) >= 3
    ic=ic+1;
    ICs(ic) = makeIC(line(1),line(3));
    line = line(4:length(line));
    %ICs = line_split;
    end

end


%Parameters: Get
if value(2:3)  == 'pa'
    par = par+1;
    Params(par) = makeParam(line_split(2),line_split(4));

    line = line_split(5:length(line_split));
    while length(line) >= 3
    par=par+1;
    Params(par) = makeParam(line(1),line(3));
    line = line(4:length(line));
    %ICs = line_split;
    end

end

%Options: Get
if value(2:3)  == 'op'
    
    if line_split(2)~= 'noopiter' %To exclude shorter options for now
     opt = opt+1;
    Options(opt) = makeOptions(line_split(2), line_split(4),0,'non');
    end
    %Options(opt).l = line_split;

end

%Dot commands: Get optionally
if (value(2:3)  == 'mo')|(value(2:3)  == 'su')
    ext = ext+1;
    Extras(ext).line = line_split;
end
        
%Default case and function end

    end
end

%Components: Find present types
%a = 0;b=0;c=0;d=0;e=0;f=0;g=0;h=0;ii=0;j=0;k=0;l=0;m=0;o=0;q=0;r=0;s=0;t=0;u=0;v=0;w=0;x=0;z=0;
%lib=0;opt=0;ic=0;par=0;
%ext=0;

%Components: initialise
Components(1) = makeComponent('Rinit','1',0,{0,0});

%Components: Merge into one struct
elementSum = a+b+c+d+e+f+g+h+ii+j+k+l+m+o+q+r+s+t+u+v+w+x+z;

if a ~= 0
    Components = [Components,A];
end
if b ~= 0
    Components = [Components,B];
end
if c ~= 0
    Components = [Components,C];
end
if d ~= 0
    Components = [Components,D];
end
if e ~= 0
    Components = [Components,E];
end
if f ~= 0
    Components = [Components,F];
end
if g ~= 0
    Components = [Components,G];
end
if h ~= 0
    Components = [Components,H];
end
if ii ~= 0
    Components = [Components,I];
end
if j ~= 0
    Components = [Components,J];
end
if k ~= 0
    Components = [Components,K];
end
if l ~= 0
    Components = [Components,L];
end
if m ~= 0
    Components = [Components,M];
end
if o ~= 0
    Components = [Components,O];
end
if q ~= 0
    Components = [Components,Q];
end
if r ~= 0
    Components = [Components,R];
end
if s ~= 0
    Components = [Components,S];
end
if t ~= 0
    Components = [Components,T];
end
if u ~= 0
    Components = [Components,U];
end
if v ~= 0
    Components = [Components,V];
end
if w ~= 0
    Components = [Components,W];
end
if x ~= 0
    Components = [Components,X];
end
if z ~= 0
    Components = [Components,Z];
end
Components = Components(2:length(Components));
%Compile import diagnostics: element emounts, starting lines and end lines
count_it = ['Total number of elements: ', num2str(elementSum)];
disp(count_it)

%fill in empty arguments
if ~exist('Libs','var') == 1
Libs = [];
end
if ~exist('Options','var') == 1
Options = [];
end
if ~exist('ICs','var') == 1
ICs = [];
end
if ~exist('Params','var') == 1
Params = [];
end
if ~exist('Extras','var') == 1
Extras = [];
end

end