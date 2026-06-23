function numeric_data = read_xlsx(workbook_file, sheet_name, data_lines)
% Reads numeric data from an Excel spreadsheet.
% Input:
% workbook_file - path to the Excel file.
% sheet_name - worksheet name or index to read.
% data_lines - row interval to read, defined as [first_row, last_row]. Multiple intervals can be defined as an Nx2 matrix.
% Output:
% numeric_data - numeric matrix imported from the selected worksheet and row interval.
%
% Example:
% numeric_data = read_xlsx('C:\Users\YOUR_USER\Documents\YOUR_FOLDER\Results\Post_results.xlsx', 'Metaparticles_time125', [2, 3014]);

%% Input handling
if nargin == 1 || isempty(sheet_name); sheet_name = 1; end
if nargin <= 2 || isempty(data_lines); data_lines = [2, 3014]; end

%% Import data
opts = spreadsheetImportOptions('NumVariables', 26);
opts.Sheet = sheet_name;
opts.DataRange = 'A' + string(data_lines(1,1)) + ':Z' + string(data_lines(1,2));
opts.VariableNames = strcat('Var', string(1:26));
opts.SelectedVariableNames = opts.VariableNames;
opts.VariableTypes = repmat({'double'}, 1, 26);
numeric_table = readtable(workbook_file, opts, 'UseExcel', false);

for idx = 2:size(data_lines, 1)
    opts.DataRange = 'A' + string(data_lines(idx,1)) + ':Z' + string(data_lines(idx,2));
    temporary_table = readtable(workbook_file, opts, 'UseExcel', false);
    numeric_table = [numeric_table; temporary_table]; %#ok<AGROW>
end

%% Convert to numeric matrix
numeric_data = table2array(numeric_table);
end
