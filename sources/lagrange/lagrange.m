function varargout = lagrange(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lagrange_OpeningFcn, ...
                   'gui_OutputFcn',  @lagrange_OutputFcn, ...
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


function lagrange_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
warning('off','all')
warning
if strcmp(get(hObject,'Visible'),'off')
        datacursormode on
        hLine = Massevolumique();
        %dcm_obj = datacursormode(ancestor(hLine, 'figure'));
        %set(dcm_obj,'DisplayStyle','datatip','SnapToDataVertex','on');
end


function varargout = lagrange_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on selection change in figureslist.
function figureslist_Callback(hObject, eventdata, handles)

axes(handles.axes);
cla;
clr = lines(14);

popup_sel_index = get(handles.figureslist, 'Value');
switch popup_sel_index
    case 1      
        Massevolumique();
    case 2
        Interpexp(clr);
    case 3
        Erreurexp();
    case 4
        Interpexptcheby(clr);
    case 5
        Erreurexptcheby();
    case 6
       Exemple();
    case 7
        Runge(clr);
    case 8
        Rungetcheby(clr);
end

function figureslist_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Cette fonction retourne les valeurs du polynome %%
%% d'interpolation de Lagrange P(x) pour x dans I %%
function px = Lagrange(xi, yi, I)
    p = polyfit(xi,yi,numel(xi)-1);
    px = polyval(p,I);
    
function out = Massevolumique()
    xi = [94 205 371];
    yi = [929 902 860];
    I = 100:1/50:1000;
    p = Lagrange(xi, yi, I);
    xm = [251 305 800];
    ym = Lagrange(xi, yi, xm);
    out = plot(I,p);

function out = Interpexp(clr)
    I = -1:1/100:1;
    y = exp(I);
    plot(I, y);
    hold on;
    for n=2:8
        xi = -1:2/n:1;
        yi = exp(xi);
        p = Lagrange(xi, yi, I);
        hold on;
        plot(I,p,'Color',clr(n,:));
    end
     
function out = Interpexptcheby(clr)
    I = -1:1/100:1;
    y = exp(I);
    plot(I, y);
    hold on;
    for n=2:8
        xi = -1:2/n:1;
        xi = cos(2*(xi-1)*pi/n);
        yi = exp(xi);
        p = Lagrange(xi, yi, I);
        hold on;
        plot(I,p,'Color',clr(n,:));
    end
     
function out =  Erreurexp()
    I = -1:1/50:1;
    y = exp(I);
    xi = -1:2/8:1;
    yi = exp(xi);
    p = Lagrange(xi, yi, I);
    E = abs(y - p);
    plot(I, E);
    
function out =  Erreurexptcheby()
    I = -1:1/50:1;
    y = exp(I);
    xi = -1:2/8:1;
    xi = cos(2*(xi-1)*pi/8);
    yi = exp(xi);
    p = Lagrange(xi, yi, I);
    E = abs(y - p);
    plot(I, E);
    
function out = Exemple()
    out = -1:1/50:1;
    y =  1./(25.*(out.^2)+1);
    plot(out,y);

    
function out = Runge(clr)
    I = Exemple();
    for n = [6 10 14]
        xi = -1:2/n:1;
        yi = 1./(25.*(xi.^2)+1);
        p = Lagrange(xi, yi, I);
        hold on;
        plot(I,p,'Color',clr(n,:));
    end
    
    
function out = Rungetcheby(clr)
    I = Exemple();
    for n = [6 10 14]
        xi = -1:2/n:1;
        xi = cos(2*(xi-1)*pi/n);
        yi = 1./(25.*(xi.^2)+1);
        p = Lagrange(xi, yi, I);
        hold on;
        plot(I,p,'Color',clr(n,:));
    end 


% --- Executes during object creation, after setting all properties.
function axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes


