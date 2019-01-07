function varargout = DemoButton(varargin)
% DEMOBUTTON MATLAB code for DemoButton.fig
%      DEMOBUTTON, by itself, creates a new DEMOBUTTON or raises the existing
%      singleton*.
%
%      H = DEMOBUTTON returns the handle to a new DEMOBUTTON or the handle to
%      the existing singleton*.
%
%      DEMOBUTTON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMOBUTTON.M with the given input arguments.
%
%      DEMOBUTTON('Property','Value',...) creates a new DEMOBUTTON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DemoButton_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DemoButton_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DemoButton

% Last Modified by GUIDE v2.5 21-Jul-2017 13:47:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DemoButton_OpeningFcn, ...
                   'gui_OutputFcn',  @DemoButton_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before DemoButton is made visible.
function DemoButton_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DemoButton (see VARARGIN)

% Choose default command line output for DemoButton
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DemoButton wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DemoButton_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in PosTestSet.
function PosTestSet_Callback(hObject, eventdata, handles)
% hObject    handle to PosTestSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run PosDetection.m

% --- Executes on button press in NegTestSet.
function NegTestSet_Callback(hObject, eventdata, handles)
% hObject    handle to NegTestSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run NegDetection.m

% --- Executes on button press in PosNegTestSet.
function PosNegTestSet_Callback(hObject, eventdata, handles)
% hObject    handle to PosNegTestSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run PosNegDetection.m
