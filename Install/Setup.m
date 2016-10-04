waitfor(msgbox('Please choose the path you want to install the Psychtoolbox'));
ToolboxPath = uigetdir('C:\ToolBox\','Install Psychtool box to:');
DownloadPsychtoolbox(ToolboxPath);