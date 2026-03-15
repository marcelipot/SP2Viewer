function h = spider_plot_benchmark(P, varargin)
%spider_plot Create a spider or radar plot with individual axes.
%
% Syntax:
%   spider_plot(P)
%   spider_plot(P, Name, Value, ...)
%
% Input Arguments:
%   (Required)
%   P                - The data points used to plot the spider chart. The
%                      rows are the groups of data and the columns are the
%                      data points. The axes labels and axes limits are
%                      automatically generated if not specified.
%                      [vector | matrix]
%
% Name-Value Pair Arguments:
%   (Optional)
%   AxesLabels       - Used to specify the label each of the axes.
%                      [auto-generated (default) | cell of strings | 'none']
%
%   AxesInterval     - Used to change the number of intervals displayed
%                      between the webs.
%                      [3 (default) | integer]
%
%   AxesPrecision    - Used to change the precision level on the value
%                      displayed on the axes.
%                      [1 (default) | integer]
%
%   AxesDisplay      - Used to change the number of axes in which the
%                      axes text are displayed. 'None' or 'one' can be used
%                      to simplify the plot appearance for normalized data.
%                      ['all' (default) | 'none' | 'one']
%
%   AxesLimits       - Used to manually set the axes limits. A matrix of
%                      2 x size(P, 2). The top row is the minimum axes
%                      limits and the bottow row is the maximum axes limits.
%                      [auto-scaled (default) | matrix]
%
%   FillOption       - Used to toggle color fill option.
%                      ['off' (default) | 'on']
%
%   FillTransparency - Used to set color fill transparency.
%                      [0.1 (default) | scalar in range (0, 1)]
%
%   Color            - Used to specify the line color, specified as an RGB
%                      triplet. The intensities must be in the range (0, 1).
%                      [MATLAB colors (default) | RGB triplet]
%
%   LineStyle        - Used to change the line style of the plots.
%                      ['-' (default) | '--' | ':' | '-.' | 'none' | cell array of character vectors]
%
%   LineWidth        - Used to change the line width, where 1 point is
%                      1/72 of an inch.
%                      [0.5 (default) | positive value | vector]
%
%   Marker           - Used to change the marker symbol of the plots.
%                      ['o' (default) | 'none' | '*' | 's' | 'd' | ... | cell array of character vectors]
%
%   MarkerSize       - Used to change the marker size, where 1 point is
%                      1/72 of an inch.
%                      [8 (default) | positive value | vector]
%
%   AxesFontSize     - Used to change the font size of the values
%                      displayed on the axes.
%                      [10 (default) | scalar value greater than zero]
%
%   LabelFontSize    - Used to change the font size of the labels.
%                      [10 (default) | scalar value greater than zero]
%
%   Direction        - Used to change the direction of rotation of the
%                      plotted data and axis labels.
%                      [clockwise (default) | counterclockwise]
%
%   AxesLabelsOffset - Used to adjust the position offset of the axes
%                      labels.
%                      [0.1 (default) | positive value]
%
%   AxesScaling      - Used to change the scaling of the axes.
%                      ['linear' (default) | 'log']
%
% Examples:
%   % Example 1: Minimal number of arguments. All non-specified, optional
%                arguments are set to their default values. Axes labels
%                and limits are automatically generated and set.
%
%   D1 = [5 3 9 1 2];
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   spider_plot(P);
%   legend('D1', 'D2', 'D3', 'Location', 'southoutside');
%
%   % Example 2: Manually setting the axes limits. All non-specified,
%                optional arguments are set to their default values.
%
%   D1 = [5 3 9 1 2];
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   spider_plot(P,...
%       'AxesLimits', [1, 2, 1, 1, 1; 10, 8, 9, 5, 10]); % [min axes limits; max axes limits]
%
%   % Example 3: Set fill option on. The fill transparency can be adjusted.
%
%   D1 = [5 3 9 1 2];
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   spider_plot(P,...
%       'AxesLabels', {'S1', 'S2', 'S3', 'S4', 'S5'},...
%       'AxesInterval', 2,...
%       'FillOption', 'on',...
%       'FillTransparency', 0.1);
%
%   % Example 4: Maximum number of arguments.
%
%   D1 = [5 3 9 1 2];
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   spider_plot(P,...
%       'AxesLabels', {'S1', 'S2', 'S3', 'S4', 'S5'},...
%       'AxesInterval', 4,...
%       'AxesPrecision', 0,...
%       'AxesDisplay', 'one',...
%       'AxesLimits', [1, 2, 1, 1, 1; 10, 8, 9, 5, 10],...
%       'FillOption', 'on',...
%       'FillTransparency', 0.2,...
%       'Color', [1, 0, 0; 0, 1, 0; 0, 0, 1],...
%       'LineStyle', {'--', '-', '--'},...
%       'LineWidth', [1, 2, 3],...
%       'Marker', {'o', 'd', 's'},...
%       'MarkerSize', [8, 10, 12],...
%       'AxesFontSize', 12,...
%       'LabelFontSize', 10,...
%       'Direction', 'clockwise',...
%       'AxesLabelsOffset', 0,...
%       'AxesScaling', 'linear');
%
%   % Example 5: Excel-like radar charts.
%
%   D1 = [5 0 3 4 4];
%   D2 = [2 1 5 5 4];
%   P = [D1; D2];
%   spider_plot(P,...
%       'AxesInterval', 5,...
%       'AxesPrecision', 0,...
%       'AxesDisplay', 'one',...
%       'AxesLimits', [0, 0, 0, 0, 0; 5, 5, 5, 5, 5],...
%       'FillOption', 'on',...
%       'FillTransparency', 0.1,...
%       'Color', [139, 0, 0; 240, 128, 128]/255,...
%       'LineWidth', 4,...
%       'Marker', 'none',...
%       'AxesFontSize', 14,...
%       'LabelFontSize', 10);
%   title('Excel-like Radar Chart',...
%       'FontSize', 14);
%   legend_str = {'D1', 'D2'};
%   legend(legend_str, 'Location', 'southoutside');
%
%   % Example 6: Logarithimic scale on all axes. Axes limits and axes
%                intervals are automatically set to factors of 10.
%
%   D1 = [-1 10 1 500];
%   D2 = [-10 20 1000 60];
%   D3 = [-100 30 10 7];
%   P = [D1; D2; D3];
%   spider_plot(P,...
%       'AxesPrecision', 2,...
%       'AxesDisplay', 'one',...
%       'AxesScaling', 'log');
%   legend('D1', 'D2', 'D3', 'Location', 'northeast');
%
%   % Example 7: Spider plot with subplot feature.
%
%   D1 = [5 3 9 1 2];
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   subplot(1, 2, 1)
%   spider_plot(P,...
%       'AxesInterval', 1,...
%       'AxesPrecision', 0);
%   subplot(1, 2, 2)
%   spider_plot(P,...
%       'AxesInterval', 1,...
%       'AxesPrecision', 0);
%
% Author:
%   Moses Yoo, (jyoo at hatci dot com)
%   2020-03-26: Added feature to allow different line styles, line width,
%               marker type, and marker sizes for the data groups.
%   2020-02-12: Fixed condition and added error checking for when only one
%               data group is plotted.
%   2020-01-27: Corrected bug where only 7 entries were allowed in legend.
%   2020-01-06: Added support for subplot feature.
%   2019-11-27: Add option to change axes to logarithmic scale.
%   2019-11-15: Add feature to customize the plot rotational direction and
%               the offset position of the axis labels.
%   2019-10-23: Minor revision to set starting axes as the vertical line.
%               Add customization option for font sizes and axes display.
%   2019-10-16: Minor revision to add name-value pairs for customizing
%               color, marker, and line settings.
%   2019-10-08: Another major revision to convert to name-value pairs and
%               add color fill option.
%   2019-09-17: Major revision to improve speed, clarity, and functionality
%
% Special Thanks:
%   Special thanks to Gabriela Andrade, Andrés Garcia, Alex Grenyer,
%   Tobias Kern, Zafar Ali, Christophe Hurlin, & Roman for their feature
%   recommendations and suggested bug fixes.

%%% Data Properties %%%
% Point properties
[num_data_groups, num_data_points] = size(P);

% Number of optional arguments
numvarargs = length(varargin);

% Check for even number of name-value pair argments
if mod(numvarargs, 2) == 1
    error('Error: Please check name-value pair arguments');
end

% Create default labels
axes_labels = cell(1, num_data_points);

% Iterate through number of data points
for ii = 1:num_data_points
    % Default axes labels
    axes_labels{ii} = sprintf('Label %i', ii);
end

% Default arguments
axes_interval = 3;
axes_precision = 1;
axes_display = 'one';
axes_limits = [];
fill_option = 'off';
fill_transparency = 0.2;
colors = lines(num_data_groups);
line_style = '-';
line_width = 2;
marker_type = 'o';
marker_size = 8;
axes_font_size = 10;
label_font_size = 10;
direction = 'clockwise';
axes_labels_offset = 0.1;
axes_scaling = 'linear';
LegOption = '';

% Check if optional arguments were specified
if numvarargs > 1
    % Initialze name-value arguments
    name_arguments = varargin(1:2:end);
    value_arguments = varargin(2:2:end);
    
    % Iterate through name-value arguments
    for ii = 1:length(name_arguments)
        
        % Set value arguments depending on name
        switch lower(name_arguments{ii})
            
            
            case 'axeslabels'
                axes_labels = value_arguments{ii};
            case 'axesinterval'
                axes_interval = value_arguments{ii};
            case 'axesprecision'
                axes_precision = value_arguments{ii};
            case 'axesdisplay'
                axes_display = value_arguments{ii};
            case 'axeslimits'
                axes_limits = value_arguments{ii};
            case 'filloption'
                fill_option = value_arguments{ii};
            case 'filltransparency'
                fill_transparency = value_arguments{ii};
            case 'color'
                colors = value_arguments{ii};
            case 'linestyle'
                line_style = value_arguments{ii};
            case 'linewidth'
                line_width = value_arguments{ii};
            case 'marker'
                marker_type = value_arguments{ii};
            case 'markersize'
                marker_size = value_arguments{ii};
            case 'axesfontsize'
                axes_font_size = value_arguments{ii};
            case 'labelfontsize'
                label_font_size = value_arguments{ii};
            case 'direction'
                direction = value_arguments{ii};
            case 'axeslabelsoffset'
                axes_labels_offset = value_arguments{ii};
            case 'axesscaling'
                axes_scaling = value_arguments{ii};
            case 'valuetitles'
                axestitlesvalues = value_arguments{ii};
            case 'axetoplot'
                axesEC = value_arguments{ii};
            case 'races'
                nbRaces = value_arguments{ii};
            case 'graphoption'
                LegOption = value_arguments{ii};
            case 'fullscreenpos'
                fullscreenOffset = value_arguments{ii};
            otherwise
                error('Error: Please enter in a valid name-value pair.');
        end
    end
    
end

%%% Error Check %%%
% Check if axes labels is a cell
if iscell(axes_labels)
    % Check if the axes labels are the same number as the number of points
    if length(axes_labels) ~= num_data_points
        error('Error: Please make sure the number of labels is the same as the number of points.');
    end
else
    % Check if valid string entry
    if ~contains(axes_labels, 'none')
        error('Error: Please enter in valid labels or "none" to remove labels.');
    end
end

% Check if axes limits is not empty
if ~isempty(axes_limits)
    % Check if the axes limits same length as the number of points
    if size(axes_limits, 1) ~= 2 || size(axes_limits, 2) ~= num_data_points
        error('Error: Please make sure the min and max axes limits match the number of data points.');
    end
    
    % Lower and upper limits
    lower_limits = axes_limits(1, :);
    upper_limits = axes_limits(2, :);
    
    % Difference in upper and lower limits
    diff_limits = upper_limits - lower_limits;
    
    % Check to make sure upper limit is greater than lower limit
    if any(diff_limits < 0)
        error('Error: Please make sure max axes limits are greater than the min axes limits.');
    end
    
    % Check the range of axes limits
    if any(diff_limits == 0)
        error('Error: Please make sure the min and max axes limits are different.');
    end
end

% Check if axes properties are an integer
if floor(axes_interval) ~= axes_interval || floor(axes_precision) ~= axes_precision
    error('Error: Please enter in an integer for the axes properties.');
end

% Check if axes properties are positive
if axes_interval < 1 || axes_precision < 0
    error('Error: Please enter a positive for the axes properties.');
end

% Check if axes display is valid string entry
if ~ismember(axes_display, {'all', 'none', 'one'})
    error('Error: Invalid axes display entry. Please enter in "all", "none", or "one" to set axes text.');
end

% Check if not a valid fill option arguement
if ~ismember(fill_option, {'off', 'on'})
    error('Error: Please enter either "off" or "on" for fill option.');
end

% Check if fill transparency is valid
if fill_transparency < 0 || fill_transparency > 1
    error('Error: Please enter a transparency value between [0, 1].');
end

% Check if font size is greater than zero
if axes_font_size <= 0 || label_font_size <= 0
    error('Error: Please enter a font size greater than zero.');
end

% Check if direction is valid string entry
if ~ismember(direction, {'counterclockwise', 'clockwise'})
    error('Error: Invalid direction entry. Please enter in "counterclockwise" or "clockwise" to set direction of rotation.');
end

% Check if axes labels offset is positive
if axes_labels_offset < 0
    error('Error: Please enter a positive for the axes labels offset.');
end

% Check if axes scaling is valid
if ~ismember(axes_scaling, {'linear', 'log'})
    error('Error: Invalid axes scaling entry. Please enter in "linear" or "log" to set axes scaling.');
end

% Check axis limits if num_data_groups is one
if num_data_groups == 1 && isempty(axes_limits)
    error('Error: For one data group, please enter in a range for the axes limits.');
end

% Check if line style is a char
if ischar(line_style)
    % Convert to cell array of char
    line_style = cellstr(line_style);
    
    % Repeat cell to number of data groups
    line_style = repmat(line_style, num_data_groups, 1);
elseif iscellstr(line_style)
    % Check is length is one
    if length(line_style) == 1
        % Repeat cell to number of data groups
        line_style = repmat(line_style, num_data_groups, 1);
    elseif length(line_style) ~= num_data_groups
        error('Error: Please specify the same number of line styles as number of data groups.');
    end
else
    error('Error: Please make sure the line style is a char or a cell array of char.');
end

% Check if line width is numeric
if isnumeric(line_width)
    % Check is length is one
    if length(line_width) == 1
        % Repeat array to number of data groups
        line_width = repmat(line_width, num_data_groups, 1);
    elseif length(line_width) ~= num_data_groups
        error('Error: Please specify the same number of line width as number of data groups.');
    end
else
    error('Error: Please make sure the line width is a numeric value.');
end

% Check if marker type is a char
if ischar(marker_type)
    % Convert to cell array of char
    marker_type = cellstr(marker_type);
    
    % Repeat cell to number of data groups
    marker_type = repmat(marker_type, num_data_groups, 1);
elseif iscellstr(marker_type)
    % Check is length is one
    if length(marker_type) == 1
        % Repeat cell to number of data groups
        marker_type = repmat(marker_type, num_data_groups, 1);
    elseif length(marker_type) ~= num_data_groups
        error('Error: Please specify the same number of line styles as number of data groups.');
    end
else
    error('Error: Please make sure the line style is a char or a cell array of char.');
end

% Check if line width is numeric
if isnumeric(marker_size)
    if length(marker_size) == 1
        % Repeat array to number of data groups
        marker_size = repmat(marker_size, num_data_groups, 1);
    elseif length(marker_size) ~= num_data_groups
        error('Error: Please specify the same number of line width as number of data groups.');
    end
else
    error('Error: Please make sure the line width is numeric.');
end

%%% Axes Scaling Properties %%%
% Check axes scaling option
if strcmp(axes_scaling, 'log')
    % Logarithm of base 10, account for numbers less than 1
    P = sign(P) .* log10(abs(P));
    
    % Minimum and maximun log limits
    min_limit = min(min(fix(P)));
    max_limit = max(max(floor(P)));
    
    % Update axes interval
    axes_interval = max_limit - min_limit;
    
    % Update axes limits
    axes_limits = zeros(2, num_data_points);
    axes_limits(1, :) = min_limit;
    axes_limits(2, :) = max_limit;
end


%%% Figure Properties %%%
axes(axesEC);
hold on;
set(axesEC, 'color', [0 0 0]);





% Axis limits
hold on;
% axis square;
% axis([-1, 1, -1, 1] * 1.3);

% Axis properties
axesEC.XTickLabel = [];
axesEC.YTickLabel = [];
axesEC.XColor = 'none';
axesEC.YColor = 'none';




% Plot colors
grey = [1, 1, 1];

% Polar increments
theta_increment = 2*pi/num_data_points;
rho_increment = 1/(axes_interval+1);

%%% Scale Data %%%
% Pre-allocation
P_scaled = zeros(size(P));
axes_range = zeros(3, num_data_points);


if isempty(LegOption) == 1 | strcmpi(LegOption, 'All Legs');
    %nothing
else;
    if strcmpi(LegOption, 'Butterfly Only');
        P(1,7) = NaN; %no turn on the butterfly leg
    else;
        P(1,6) = NaN; %no start on the other legs
    end;
end;

% Iterate through number of data points
for ii = 1:num_data_points
    % Group of points
    group_points = P(:, ii);
    
    % Automatically the range of each group
    min_value = min(group_points);
    max_value = max(group_points);
    range = max_value - min_value;
    
    % Check if axes_limits is empty
    if isempty(axes_limits)
        % Scale points to range from [rho_increment, 1]
        P_scaled(:, ii) = ((group_points - min_value) / range) * (1 - rho_increment) + rho_increment;
    else
        % Manually set the range of each group
        min_value = axes_limits(1, ii);
        max_value = axes_limits(2, ii);
        range = max_value - min_value;
        
        % Check if the axes limits are within range of points
        if min_value > min(group_points) || max_value < max(group_points)
            error('Error: Please make the manually specified axes limits are within range of the data points.');
        end
        
        % Scale points to range from [rho_increment, 1]
        P_scaled(:, ii) = ((group_points - min_value) / range) * (1 - rho_increment) + rho_increment;
    end
    % Store to array
    axes_range(:, ii) = [min_value; max_value; range];
end


for ii = 1:num_data_points
    % Group of points
    group_pointsBIS = max_value;
    
    % Automatically the range of each group
    min_valueBIS = min(group_pointsBIS);
    max_valueBIS = max(group_pointsBIS);
    rangeBIS = max_valueBIS - min_valueBIS;
    
    % Check if axes_limits is empty
    if isempty(axes_limits)
        % Scale points to range from [rho_increment, 1]
        P_scaledBIS(:, ii) = ((group_pointsBIS - min_valueBIS) / rangeBIS) * (1 - rho_increment) + rho_increment;
    else
        % Manually set the range of each group
        min_valueBIS = axes_limits(1, ii);
        max_valueBIS = axes_limits(2, ii);
        rangeBIS = max_valueBIS - min_valueBIS;
        
        % Check if the axes limits are within range of points
        if min_valueBIS > min(group_pointsBIS) || max_valueBIS < max(group_pointsBIS)
            error('Error: Please make the manually specified axes limits are within range of the data points.');
        end
        
        % Scale points to range from [rho_increment, 1]
        P_scaledBIS(:, ii) = ((group_pointsBIS - min_valueBIS) / rangeBIS) * (1 - rho_increment) + rho_increment;
    end
    
    % Store to array
    axes_rangeBIS(:, ii) = [min_valueBIS; max_valueBIS; rangeBIS];
end

%%% Polar Axes %%%
% Polar coordinates
rho = 0:rho_increment:1;

% Check rotational direction
switch direction
    case 'counterclockwise'
        % Shift by pi/2 to set starting axis the vertical line
        theta = (0:theta_increment:2*pi) + (pi/2);
    case 'clockwise'
        % Shift by pi/2 to set starting axis the vertical line
        theta = (0:-theta_increment:-2*pi) + (pi/2);
end

% Remainder after using a modulus of 2*pi
theta = mod(theta, 2*pi);

% Iterate through each theta

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%Size management%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xFactor = xlim(axesEC);
yFactor = ylim(axesEC);
xFactor = xFactor(2)./6.4;
yFactor = yFactor(2)./3.9;
xOffset = 770;
yOffset = 165;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for ii = 1:length(theta)-1
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta(ii), rho);
    
    % Plot webs
    x_axes = (x_axes .* xFactor) + xOffset;
    y_axes = (y_axes .* yFactor) + yOffset;
    
    h{1,ii} = plot(x_axes, y_axes,...
        'LineWidth', 1.5,...
        'Color', [0 0 0], 'parent', axesEC);
    % Turn off legend annotation
%     h.Annotation.LegendInformation.IconDisplayStyle = 'off';
end
xcenter = x_axes(1,1);
ycenter = y_axes(1,1);
    


% Iterate through each rho
for ii = 2:length(rho)
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta, rho(ii));
    x_axes = (x_axes .* xFactor) + xOffset;
    y_axes = (y_axes .* yFactor) + yOffset;
    
    % Plot axes
    h{2,ii} = plot(x_axes, y_axes,...
        'Color', [0 0 0], 'parent', axesEC);
    
    % Turn off legend annotation
%     h.Annotation.LegendInformation.IconDisplayStyle = 'off';
end

% Set end index depending on axes display argument
switch axes_display
    case 'all'
        theta_end_index = length(theta)-1;
    case 'one'
        theta_end_index = 1;
    case 'none'
        theta_end_index = 0;
end

% Iterate through each theta
for ii = 1:theta_end_index
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta(ii), rho);
    x_axes = (x_axes .* xFactor) + xOffset;
    y_axes = (y_axes .* yFactor) + yOffset;
    
    % Iterate through points on isocurve
    for jj = 2:length(rho)
        % Axes increment value
        min_value = axes_range(1, ii);
        range = axes_range(3, ii);
        axes_value = min_value + (range/axes_interval) * (jj-2);
        
        % Check axes scaling option
        if strcmp(axes_scaling, 'log')
            % Exponent to the tenth power
            axes_value = 10^axes_value;
        end
        
        % Display axes text
        text_str = sprintf(sprintf('%%.%if', axes_precision), axes_value);
        h{3,jj} = text(x_axes(jj), y_axes(jj), text_str,...
            'Units', 'Data',...
            'Color', [0 0 0],...
            'FontUnits', 'normalized', ...
            'FontSize', axes_font_size,...
            'FontName', 'Book Antiqua', ...
            'FontAngle', 'italic', ...
            'HorizontalAlignment', 'center',...
            'VerticalAlignment', 'middle', ...
            'parent', axesEC);
    end
end;

%%% Plot %%%
% Iterate through number of data groups
x_pointLine = [];
y_pointLine = [];


for ii = 1:num_data_groups
    % Convert polar to cartesian coordinates
    [x_points, y_points] = pol2cart(theta(1:end-1), P_scaled(ii, :));
    x_points = (x_points .* xFactor) + xOffset;
    y_points = (y_points .* yFactor) + yOffset;
    
    if ii == 1;
        [x_pointsBIS, y_pointsBIS] = pol2cart(theta(1:end-1), P_scaledBIS(ii, :));  
        x_pointsBIS = (x_pointsBIS .* xFactor) + xOffset;
        y_pointsBIS = (y_pointsBIS .* yFactor) + yOffset;
        
        x_pointLine = [x_pointLine x_pointsBIS];
        y_pointLine = [y_pointLine y_pointsBIS];
    end;
    
    % Make points circular
    x_circular = [x_points, x_points(1)];
    y_circular = [y_points, y_points(1)];
    
    % Plot data points
    h{4,ii} = plot(x_circular, y_circular,...
        'LineStyle', line_style{ii},...
        'Marker', marker_type{ii},...
        'Color', colors(ii, :),...
        'LineWidth', line_width(ii),...
        'MarkerSize', marker_size(ii),...
        'MarkerFaceColor', colors(ii, :), ...
        'parent', axesEC);
    
    % Check if fill option is toggled on
    if strcmp(fill_option, 'on')
        % Fill area within polygon
        
        x_circular2 = x_circular;
        index = find(isnan(x_circular) == 1);
        if isempty(index) == 0;
            x_circular2(index) = xcenter;
        end;
        y_circular2 = y_circular;
        index = find(isnan(y_circular) == 1);
        if isempty(index) == 0;
            y_circular2(index) = ycenter;
        end;
         h{5,ii} = patch(x_circular2, y_circular2, colors(ii, :),...
            'EdgeColor', 'none',...
            'FaceAlpha', fill_transparency, ...
            'parent', axesEC);
        
        % Turn off legend annotation
%         h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end

%%% Labels %%%
% Check labels argument
if ~strcmp(axes_labels, 'none')
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta, rho(end));
    x_axes = (x_axes .* xFactor) + xOffset;
    y_axes = (y_axes .* yFactor) + yOffset;
    
    % Iterate through number of data points
    for ii = 1:length(axes_labels)
        % Angle of point in radians
        theta_point = theta(ii);
        
        % Find out which quadrant the point is in
        if theta_point == 0
            quadrant = 0;
        elseif theta_point == pi/2
            quadrant = 1.5;
        elseif theta_point == pi
            quadrant = 2.5;
        elseif theta_point == 3*pi/2
            quadrant = 3.5;
        elseif theta_point == 2*pi
            quadrant = 0;
        elseif theta_point > 0 && theta_point < pi/2
            quadrant = 1;
        elseif theta_point > pi/2 && theta_point < pi
            quadrant = 2;
        elseif theta_point > pi && theta_point < 3*pi/2
            quadrant = 3;
        elseif theta_point > 3*pi/2 && theta_point < 2*pi
            quadrant = 4;
        end
        
        % Adjust label alignment depending on quadrant
        switch quadrant
            case 0
                horz_align = 'left';
                vert_align = 'middle';
                x_pos = axes_labels_offset;
                y_pos = 0;
            case 1
                horz_align = 'left';
                vert_align = 'bottom';
                x_pos = axes_labels_offset;
                y_pos = axes_labels_offset;
            case 1.5
                horz_align = 'center';
                vert_align = 'bottom';
                x_pos = 0;
                y_pos = axes_labels_offset;
            case 2
                horz_align = 'right';
                vert_align = 'bottom';
                x_pos = -axes_labels_offset;
                y_pos = axes_labels_offset;
            case 2.5
                horz_align = 'right';
                vert_align = 'middle';
                x_pos = -axes_labels_offset;
                y_pos = 0;
            case 3
                horz_align = 'right';
                vert_align = 'top';
                x_pos = -axes_labels_offset;
                y_pos = -axes_labels_offset;
            case 3.5
                horz_align = 'center';
                vert_align = 'top';
                x_pos = 0;
                y_pos = -axes_labels_offset;
            case 4
                horz_align = 'left';
                vert_align = 'top';
                x_pos = axes_labels_offset;
                y_pos = -axes_labels_offset;
        end
        
        if ii == 1;
            %racetime
            x_pos = x_pos + 60;
            y_pos = y_pos + 20;
        elseif ii == 2;
            %SwimSpeed
            x_pos = x_pos + 35;
            y_pos = y_pos + 35;
        elseif ii == 3;
            %Stroke Index
            x_pos = x_pos + 40;
            y_pos = y_pos - 30;
        elseif ii == 4;
            %Speed Decay
            x_pos = x_pos + 53;
            y_pos = y_pos - 15;
        elseif ii == 5;
            %Skill Time
            x_pos = x_pos - 50;
            y_pos = y_pos - 15;        
        elseif ii == 6;
            %Start Time
            x_pos = x_pos - 40;
            y_pos = y_pos - 30;
        elseif ii == 7;
            %Turn Time
            x_pos = x_pos - 30;
            y_pos = y_pos + 35;
        end;
    
        if ii == 6;
            if strcmpi(LegOption, 'Backstroke Only') | strcmpi(LegOption, 'Freestyle Only') | strcmpi(LegOption, 'Breaststroke Only');
                titleaxes = {axes_labels{ii}; 'No Start'}; %no start on the other legs
            else;
                if axestitlesvalues(:,ii) == 100;
                    titleaxes = {axes_labels{ii}; 'Best'};
                else;
                    titleaxes = {axes_labels{ii}; ['Top ' num2str(axestitlesvalues(:,ii)) '%']};
                end;
            end;
            
        elseif ii == 7;
            if strcmpi(LegOption, 'Butterfly Only');
                titleaxes = {axes_labels{ii}; 'No Turn'}; %no turn on the butterfly leg
            else;
                if axestitlesvalues(:,ii) == 100;
                    titleaxes = {axes_labels{ii}; 'Best'};
                else;
                    titleaxes = {axes_labels{ii}; ['Top ' num2str(axestitlesvalues(:,ii)) '%']};
                end;
            end;
            
        else;
            if axestitlesvalues(:,ii) == 100;
                titleaxes = {axes_labels{ii}; 'Best'};
            else;
                titleaxes = {axes_labels{ii}; ['Top ' num2str(axestitlesvalues(:,ii)) '%']};
            end;
        end;

        h{6,ii} = text(x_axes(ii)+x_pos, y_axes(ii)+y_pos, titleaxes,...
            'Units', 'Data',...
            'HorizontalAlignment', 'center',...
            'VerticalAlignment', vert_align,...
            'Color', [0 0 0], ...
            'FontUnits', 'Normalized', ...
            'FontSize', label_font_size, ...
            'FontName', 'Book Antiqua', ...
            'FontWeight', 'Bold', ...
            'Fontangle', 'italic', ...
            'parent', axesEC);
        
        drawTriangle = 1;
        if ii == 6;
            if strcmpi(LegOption, 'Backstroke Only') | strcmpi(LegOption, 'Freestyle Only') | strcmpi(LegOption, 'Breaststroke Only');
                drawTriangle = 0;
            end;
        elseif ii == 7;
            if strcmpi(LegOption, 'Butterfly Only');
                drawTriangle = 0; %no turn on the butterfly leg
            end;
        end;
        if drawTriangle == 1;
            posExtent = get(h{6,ii}, 'extent');
            if ii == 2 | ii == 3 | ii == 4;
                x = [posExtent(1)+3 posExtent(1)-2 posExtent(1)-7];
                y = [posExtent(2)-12 posExtent(2)-2 posExtent(2)-12];
                h{7,ii} = patch(x, y, 'Black');
            else;
                x = [posExtent(1)-5 posExtent(1)-10 posExtent(1)-15];
                y = [posExtent(2)-12 posExtent(2)-2 posExtent(2)-12];
                h{7,ii} = patch(x, y, 'Black');
            end;
        else;
            x = [2 1 0];
            y = [0 1 0];
            h{7,ii} = patch(x, y, 'Black');
        end;
    end
end
