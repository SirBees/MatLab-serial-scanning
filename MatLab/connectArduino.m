%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% scans through available ports, finds arduino. if the handshake is returned it opens that serial port at 9600baud
%

function m_port = connectArduino(varargin)
    
    baudrate = 9600; 
    out_message = 'MATLAB';   
    in_message = 'ARDUINO';
   
    if nargin == 1
        if isnumeric(varargin{1})
            baudrate = varargin{1};
        else
            out_message = varargin{1};
        end
        
    elseif nargin == 2
        if isnumeric(varargin{1})
            baudrate = varargin{1};
            out_message = varargin{2};
        else
            out_message = varargin{1}; 
            in_message = varargin{2};
        end
        
    elseif nargin == 3
        baudrate = varargin{1};
        out_message = varargin{2};
        in_message = varargin{3};
    end            
    
    if isunix == 1
        sysprefix = "/dev/ttyACM";
    elseif ispc == 1
        sysprefix = "COM";
    else 
        return
    end

    for portnumber = 0:14   
    
        portname = sysprefix + portnumber;
    
        try         
            if isunix == 1
                system("sudo chmod a+rw " + portname);
            end
                
            m_port = serialport(portname, baudrate);
        
            writeline(m_port, out_message);
        
            if readline(m_port) == in_message
                break
            end
        
        catch
            disp("no device on " + portname);
        end
    end
end


