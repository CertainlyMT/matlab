function varargout = nhiethoc_2NHi(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @nhiethoc_2_OpeningFcn, ...
                       'gui_OutputFcn',  @nhiethoc_2_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
    
function nhiethoc_2_OpeningFcn (hObject, ~, handles, varargin)
    handles.output =  hObject;
    guidata(hobject, handles);
    
function varargout = nhiethoc_2_OutputFcn (~, ~, handles)
    varargout {1} =  handles.output ;
    h = msgbox ('hello! Welcome to my applet :) ',' HELLO');
 
 
function start_Callback (~, ~, handles)
    op = str2num(get(handles.GHDP,'string'));
    ov = str2num(get(handles.GHDV,'string'));
    if isempty(op) && isempty(ov)
        op = 1000;
        ov = 10;
    end
    
    n = str2num(get(handles.somol,'string'));
    p1 = str2num(get(handles.apsuat1,'string'));
    v1 = str2num(get(handles.thetich1,'string'));
    p2 = str2num(get(handles.apsuat2,'string'));
    v2 = str2num(get(handles.thetich2,'string'));
    W = str2num(get(handles.congtoanphan,'string'));
    Q = str2num(get(handles.nhiettoanphan,'string'));
    R = 8.314;
    g1 = 5/3;
    g2 = 7/5;
    Cv1 =  R / (g1-1);
    Cv2 = R / (g2-1);
    if  (n < 0) || (p1<0) || (v1<0) || (p2<0) || (v2<0)
        msgbox ('Du lieu sai', 'Warning','Warn');
    else
        contents = get(handles.quatrinh, 'string');
        quatrinhvalue = contents {get(handles.quatrinh, 'value')};
        loaikhi1 = get(handles.donnguyentu, 'value');
        loaikhi2 = get(handles.luongnguyentu, 'value');
        
    if loaikhi1==get(handles.donnguyentu, 'max')
        switch quatrinhvalue
            case 'Qua trinh dang ap'
                if isempty (v2)
                    msgbox ('Vui long nhap the tich v2', 'Warning', 'warn');
                elseif  v2 == v1
                    msgbox ('Vui long nhap lai v2 <> v1', 'Warning', 'warn');
                else
                    t1 = (p1*v1) / (n*R);
                    t2 = (p1*v2) / (n*R);
                    Q1 = n*(Cv1 + R)*(t2-t1)/1000;
                    W1 = p1*(v2-v1)/1000;

                    set(handles.nhietquatrinh,'string', Q1);
                    set(handles.nhiettoanphan,'string', Q1+Q);
                    set(handles.apsuat2,'string', p1);
                    set(handles.nhietdo1,'string', t1);
                    set(handles.nhietdo2,'string', t2);
                    set(handles.congquatrinh,'string', W1);
                    set(handles.congtoanphan,'string', W1+W);

                    X =  linspace(v1,v2,100);
                    Y = p1 + 0*X;
                    axes (handles.axes1);
                    plot (X,Y,'linewidth',4,'color','r');
                    axis ([0 ov 0 op]);
                    Grid on;
                    Xlabel ('v(L)');
                    Ylabel ('p(kPa');
                end
            case 'Qua trinh dang tich'
                if isempty (p2)
                    msgbox('Vui long nhap lai ap suat p2','Warning','Warn');
                elseif p2 == p1
                    msgbox('Vui long nhap lai p2 <> p1','Warning','Warn');
                else
                    W1 = 0;
                    t1 = (p1*v1) / (n*R);
                    t2 = (p2*v1) / (n*R);
                    Q1 = n*Cv1*(t2 - t1)/1000;
                    set(handles.nhietquatrinh,'string',Q1);
                    set(handles.nhiettoanphan,'string',Q1+Q);
                    set(handles.nhietdo1,'string',t1);
                    set(handles.nhietdo2,'string',t2);
                    set(handles.thetich2,'string',v1);
        			set(handles.congquatrinh,'string',W1);
        			set(handles.congtoanphan,'string',W1+W);
        			axes(handles.axes1);
        			X = v1*ones(2,1);
        			Y = linspace(p1,p2,length (X));
        			Plot(X,X,'linewidth',4,'color','r');
        			axis([0 ov 0 op]);
        			Grid on;
        			Xlabel('V(L)');
        			Ylabel('p(kPa)');
    			end
    		case 'Qua trinh dang nhiet'
        		Syms X;
        		t1 = (p1*v1)/(n*R);
     			set(handles.nhietdo1,'string',t1);
        		set(handles.nhietdo2,'string',t1);
        		A = isempty (p2);
        		B = isempty (v2);

    			if  (A == 1 && B == 0 && v2 ~= v1) || (A ==0 && B == 1 && p2~=p1)
        			if  (A == 1) && (B == 0)
            			p2 = (p1*v1)/v2;
            			set(handles.apsuat2,'string',p2);
        			elseif (A == 0) && (B == 1)
            			v2 = (p1*v1)/p2;
            			set(handles.thetich2,'string',v2);
        			end
        			W1 = n*R*t1*log(v2/v1)/1000;
	        		set(handles.nhietquatrinh,'string',W1);
	        		set(handles.nhiettoanphan,'string',W1+Q);
	        		set(handles.congquatrinh,'string',W1);
	        		set(handles.congtoanphan,'string',W1+w);
	        		axes (handles.axes1);
	        		X = linspace (v1,v2,100);
	        		Y = (p1*v1)./ X;
	        		plot (X,Y,'linewidth',4,'color','r');
	    			axis ([0 ov 0 op]);
	        		grid on;
	        		Xlabel ('v(L)');
	        		Ylabel ('p(kPa)');
    			elseif (A==1) && (B==0) && (v2==v1)
    				msgbox('Vui long nhap lai V2 <> V1','Warning','warn');
    			elseif (A==0) && (B==1)&& (p2==p1)
    				msgbox('Vui long nhap lai p2 <> P1','Warning','warn');
    			elseif (A==1) && (B==1)
    				msgbox('Error','Warning','error');
    			else
    				msgbox('Chi nhap mot trong hai thong so p2 hoac v2','Warning','warn');
    			end
    		case'Qua trinh doan nhiet'
    			syms X
    			t1 = (p1*v1)/(n*R);
    			Q1 = 0;
			    set(handles.nhietquatrinh,'string',Q1);
			    set(handles.nhiettoanphan,'string',Q1+Q);
			    set(handles.nhietdo1,'string',t1);
			    A = isempty(p2);
			    B=isempty(v2);
    			if (A ==1 && B==0 && v2~=v1) || (A==0 && B==1 && p2~=p1)
    				if (A==1) && (B==0)
    					p2 = p1*(v1/v2)^g1;
					    set(handles.apsuat2,'string',p2);
					    t2 = (p2*v2)/(n*R);
					    set(handles.nhietdo2,'string',t2);
					elseif (A==0) && (B==1)
					    v2 = ((p1*v1^g1)/p2)^(1/g1);
					    set(handles.thetich2,'string',v2);
					    t2 = (p2*v2)/(n*R);
					    set(handles.nhietdo2,'string',t2);
    				end
    			w1 = (p1*v1-p2*v2)/(1000*(g1-1));
    			set(handles.congquatrinh,'string',w1);
    			set(handles.congtoanphan,'string',w1+w);
    			axes (handles.axes1);
    			X= linspace(v1,v2,100);
    			Y=p2*(v2./x).^gl;
    			plot(X,Y,'linewidth',4,'color','r');
    			axis ([0 ov 0 op]);
    			grid on;
    			Xlabel ('V(L)');
    			Ylabel ('P(kPa)');
    			elseif (A==1) &&(B==0) &&(v2==v1)
    				msgbox('Vui long nhap lai v2 <> v1','Warning','warn');
    			elseif (A==0) && (B==1) && (p2==p1)
    				msgbox('Vui long nhap lai p2 <> p1','Warning','warn');
    			elseif (A==1) && (B==1)
    				msgbox('Error','Warning','error');
    			else
    				msgbox('Chi nhap mot trong hai thong so p2 hoac v2','Warning','warn');
    			end
    	end
    elseif loaikhi2 == get(handles.luongnguyentu,'Max')
        switch quatrinhvalue
            case'Qua trinh dang ap'
                if isempty(v2)
                    mgsbox('Vui long nhap the tich v2','Warning','warn');
                elseif v2==v1
                    msgbox ('Vui long nhap lai v2 <> v1','Warning','warn')
                else
                    t1=(p1*v1)/(n*R);
                    t2 = (p1*v2)/(n*R);
                    Q1= n*(Cv2+R)*(t2-t1)/1000;
                    set(handles.nhietquatrinh,'string',Q1);
                    set(handles.nhiettoanphan,'string',Q1+Q);
                    set(handles.apsuat2,'string',p1);
                    set(handles.nhietdo1,'string',t1);
                    set(handles.nhietdo2,'string',t2);
                    w1=p1*(v2-v1)/1000;
                    set(handles.congquatrinh,'string',w1);
                    set(handles.congtoanphan,'string',w1+w);
                    X= linspace(v1,v2,100);
                    Y=p1+0*x;
                    axes(handles.axes1);
                    plot(X,Y,'linewidth',4,'color','r');
                    axis ([0 ov 0 op]);
                    grid on;
                    Xlabel ('v(L)');
                    Ylabel ('p(kPa)');
                end
            case'Qua trinh dang tich'
                if isempty(p2)
                    msgbox('Vui long nhap ap suat p2','Warning','warn');
                elseif p2 == p1
                    msgbox('Vui long nhap lai p2 <> p1','Warning','warn')
                else
                    w1 = 0;
                    t1 = (p1*v1)/(n*R);
                    t2 = (p2*v2)/(n*R);
                    Q1 = n*Cv2*(t2 - t1)/1000;
                    set(handles.nhietquatrinh,'string',Q1);
                    set(handles.nhiettoanphan,'string',Q1+Q);
                    set(handles.nhiedo1,'string',t1);
                    set(handles.nhiedo2,'string',t2);
                    set(handles.thetich2,'string',v1);
                    set(handles.congquatrinh,'string',w1);
                    set(handles.congtoanphan,'string',w1+w);
                    axes(handles.axes1);
                    X = v1*ones(2,1);
                    y = linspace(p1,p2,length(x));
                    plot(X,Y,'linewidth',4,'color','r');
                    axis([0 ov 0 op]);
                    grid on;
                    Xlabel('V(L)');
                    Ylabel('P(kPa)');
                end
            case'Qua trinh dang nhiet'
                t1 = (p1*v1)/(n*R);
                set(handles.nhiedo1,'string',t1);
                set(handles.nhiedo2,'string',t1);
                A = isempty(p2);
                B = isempty(v2);
                if (A==1 && B==0 && v2~=v1) || (A==0&& B==1 && p2~=p1)
                    if (A==1) && (B==0)
                        p2 = (p1*v1)/v2;
                        set(handles.apsuat2,'string',p2);
                    elseif (A==0) && (B==1)
                        v2 = (p1*v1)/p2;
                        set(handles.thetich2,'string',v2);
                    else
                        msgbox('Chi nhap mot trong hai thong so p2 hoac v2','Warning','warn');
                    end

                    w1 = n*R*t1*log(v2/v1)/1000;
                    set(handles.nhietquatrinh,'string',w1);
                    set(handles.nhiettoanphan,'string',w1+Q);
                    set(handles.congquatrinh,'string',w1);
                    set(handles.congtoanphan,'string',w1+w);
                    axes(handles. axes1);
                    X = linspace(v1,v2,100);
                    Y = (p1*v1)./x;
                    plot(X,Y,'linewidth',4,'color','r');
                    axis([0 ov 0 op]);
                    grid on;
                    Xlabel('v(L)');
                    Ylabel('p(kPa)');
                elseif (A==1) && (B==0) && (v2==v1)
                    megbox('Vui long nhap lai v2 <> v1', 'Warning','warn');
                elseif (A==0) && (B==1) && (p2==p1)
                    megbox('Vui long nhap lai p2 <> p1', 'Warning','warn');
                elseif (A==1) && (B==1)
                    msgbox('Error', 'Warning','error');
                else
                    msgbox('Chi nhap mot trong hai thong so p2 hoac v2', 'Warning','warn');
                end
            case'Qua trinh doan nhiet'
                syms X;
                t1 = (p1*v1)/(n*R);
                Q1 = 0;
                set(handles.nhietquatrinh,'string',Q1);
                set(handles.nhiettoanphan,'string',Q1+Q);
                set(handles.nhiedo1,'string',t1);
                A = isempty(p2);
                B = isempty(v2);
                if (A==1 && B==0 && v2~=v1) || (A==0&& B==1 && p2~=p1)
                    if (A==1) && (B==0)
                        p2 = p1*(v1/v2)^g2;
                        set(handles.apsuat2,'string',p2);
                        t2 = (p2*v2)/(n*R);
                        set(handles.nhiedo2,'string',t2);
                    elseif (A==0) && (B==1)
                        v2 = ((p1*v1^g2)/p2)^(1/g2);
                        set(handles.thetich2,'string',v2);
                        t2 = (p2*v2)/(n*R);
                        set(handles.nhiedo2,'string',t2);
                    end

                    w1 = (p1*v1 - p2*v2)/(1000*(g2 - 1));
                    set(handles.congquatrinh,'string',w1);
                    set(handles.congtoanphan,'string',w1+w);
                    axes(handles. axes1);
                    X = linspace(v1,v2,100);
                    Y = p2*(v2./X).^g2;
                    plot(x,y,'linewidth',4,'color','r');
                    axis([0 ov 0 op]);
                    grid on;
                    xlabel('V(L)');
                    ylabel('P(kPa)');
                elseif (A==1) && (B==0) && (v2==v1)
                    msgbox('Vui long nhap lai V2 <> V1','Warning''warn');
                elseif (A==0) && (B==1) && (p2==p1)
                    msgbox('Vui long nhap lai P2 <> P1','Warning','warn');
                elseif (A==1) && (B==1)
                    msgbox('Error','Warning','error');
                else
                    msgbox('Chi nhap mot trong hai thong so P2 hoac V2','Warning','warn');
                end
        end
    else
        end
    hold on;
end

function next_Callback(~, ~, handles)
    n = str2num(get(handles.somol,'string'));
    p2 = str2num(get(handles.apsuat2,'string'));
    V2 = str2num(get(handles.thetich2,'string'));
    R = 8.3145;
    t2 = (p2*V2)/(n*R);
    set(handles.apsuat1, 'String', p2);
    set(handles.apsuat2, 'String', '');
    set(handles.thetich1, 'String', V2);
    set(handles.thetich2, 'String', '');
    set(handles.nhietdo1, 'String', t2);
    set(handles.nhietdo2, 'String', '');

function close_Callback(~, ~, ~)
    button = questdlg('Do you want to continue?','Continue Operation','Yes','No','No');
    if strcmp(button,'Yes')
        close;
    elseif strcmp(button,'No')
        end;

function reset_Callback(~, ~,handles)
    resetbutton = questdlg('Are you sure ?','Continue Operation','Yes','No','No');
    if strcmp(resetbutton,'Yes')
        set(handles.somol, 'String', '');
        set(handles.apsuat1, 'String', '');
        set(handles.apsuat2, 'String', '');
        set(handles.thetich1, 'String', '');
        set(handles.thetich2, 'String', '');
        set(handles.nhietdo1, 'String', '');
        set(handles.nhietdo2, 'String', '');
        set(handles.congtoanphan, 'String',0);
        set(handles.congquatrinh, 'String',0);
        set(handles.nhiettoanphan, 'String',0);
        set(handles.nhietquatrinh,'string',0);
        axes(handles.axes1);
        cla reset;
        axis([0 10 0 1000]);
        grid on;
        xlabel('V(L)');
        ylabel('P(kPa)');
    elseif strcmp(resetbutton,'No')
        end

function ok_Callback(~, ~, handles)
    op = str2num(get(handles.GHDP,'string'));
    ov = str2num(get(handles.GHDV,'string'));
    xlabel('V(L)');
    ylabel('P(kPa)');
    if isempty(op) == 0 && isempty(ov) == 0
        axis([0 ov 0 op]);
    end

function somol_Callback(~, ~, ~)
function somol_CreateFcn(hObject, ~, ~)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function apsuat1_Callback(~, ~, ~)
function apsuat1_CreateFcn(hObject, ~, ~)
    if ispc && isequal(get(hObject,'BackgroundColor'),get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function apsuat2_Callback(~, ~, ~)
function apsuat2_CreateFcn(hObject, ~, ~)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function nhietdo2_Callback(~, ~, ~)
function nhietdo2_CreateFcn(hObject, ~, ~ )
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function nhietdo1_Callback (~, ~, ~)
function nhietdo1_CreateFcn (hObject, ~, ~)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function thetich2_Callback (~, ~, ~)
function thetich2_CreateFcn (hObject, ~, ~)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function thetich1_Callback (~, ~, ~)
function thetich1_CreateFcn (hObject, ~, ~)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function congtoanphan_Callback (~, ~, ~)
function congtoanphan_CreateFcn (hObject, ~, ~)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function quatrinh_Callback (~, ~, ~)
function quatrinh_CreateFcn (hObject, ~, ~)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function congquatrinh_Callback (~, ~, ~)
function congquatrinh_CreateFcn (hObject, ~, ~)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit10_Callback (~, ~, ~)
function edit10_CreateFcn (hObject, ~, ~)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function loaikhi_Callback(~, ~, ~)
function loaikhi_CreateFcn(hObject, ~,~)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function loaikhi1_Callback(~,~,~ )
function loaikhi2_Callback(~,~ ,~)

function ghdp_Callback(~,~, ~)
function ghdp_CreateFcn (~, ~, ~)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function ghdv_Callback(~,~, ~)
function ghdv_CreateFcn(hObject, ~, ~)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

