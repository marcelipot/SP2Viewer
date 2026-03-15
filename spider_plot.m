function spider_plot(P, varargin)
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
set(axesEC, 'color', [0 0 0]);

% Axis limits
hold on;
axis square;
axis([-1, 1, -1, 1] * 1.3);

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
for ii = 1:length(theta)-1
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta(ii), rho);
    
    % Plot webs
    h = plot(x_axes, y_axes,...
        'LineWidth', 1.5,...
        'Color', grey, 'parent', axesEC);
    
    % Turn off legend annotation
    h.Annotation.LegendInformation.IconDisplayStyle = 'off';
end

% Iterate through each rho
for ii = 2:length(rho)
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta, rho(ii));
    
    % Plot axes
    h = plot(x_axes, y_axes,...
        'Color', grey, 'parent', axesEC);
    
    % Turn off legend annotation
    h.Annotation.LegendInformation.IconDisplayStyle = 'off';
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
        text(x_axes(jj), y_axes(jj), text_str,...
            'Units', 'Data',...
            'Color', [1 1 1],...
            'FontSize', axes_font_size,...
            'FontName', 'Antiqua', ...
            'FontWeight', 'Bold', ...
            'HorizontalAlignment', 'center',...
            'VerticalAlignment', 'middle', ...
            'parent', axesEC);
    end
end;

%%% Plot %%%
% Iterate through number of data groups
x_pointLine = [];
y_pointLine = [];

for rep = 1:length(P(:,1));
    if P(rep,2) == 0;
        P_scaled(rep,2) = NaN;
        P_scaled(rep,3) = NaN;
    end;
end;
for ii = 1:num_data_groups
    % Convert polar to cartesian coordinates
    [x_points, y_points] = pol2cart(theta(1:end-1), P_scaled(ii, :));
    
    if ii == 1;
        [x_pointsBIS, y_pointsBIS] = pol2cart(theta(1:end-1), P_scaledBIS(ii, :));    
        x_pointLine = [x_pointLine x_pointsBIS];
        y_pointLine = [y_pointLine y_pointsBIS];
    end;
    
    % Make points circular
    x_circular = [x_points, x_points(1)];
    y_circular = [y_points, y_points(1)];
    
    % Plot data points
    plot(x_circular, y_circular,...
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
        h = patch(x_circular, y_circular, colors(ii, :),...
            'EdgeColor', 'none',...
            'FaceAlpha', fill_transparency, ...
            'parent', axesEC);
        
        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end



if length(x_pointLine) == 6;
    x1 = x_pointLine(4);
    y1 = y_pointLine(4);
    x2 = x_pointLine(5);
    y2 = y_pointLine(5);
    line1length = sqrt((x2-x1)^2 + (y2-y1)^2);
    pt1midx = ((x2-x1)./2)+x1;
    pt1midy = ((y2-y1)./2)+y1;
    u = [1 0];
    v = [x2-x1 y2-y1];
    ThetaRad = acos(dot(u,v)/(norm(u)*norm(v)));
    MRot = [cos(ThetaRad) -sin(ThetaRad); sin(ThetaRad) cos(ThetaRad)];
    CoordExtra1 = MRot*[line1length./2; 0.5];
    xExtra1 = CoordExtra1(1) + x1;
    yExtra1 = CoordExtra1(2) + y1;
    
    x3 = x_pointLine(6);
    y3 = y_pointLine(6);
    x4 = x_pointLine(1);
    y4 = y_pointLine(1);
    line2length = sqrt((x4-x3)^2 + (y4-y3)^2);
    pt2midx = ((x4-x3)./2)+x3;
    pt2midy = ((y4-y3)./2)+y3;
    u = [1 0];
    v = [x4-x3 y4-y3];
    ThetaRad = acos(dot(u,v)/(norm(u)*norm(v)));
    MRot = [cos(ThetaRad) -sin(ThetaRad); sin(ThetaRad) cos(ThetaRad)];
    CoordExtra2 = MRot*[line2length./2; 0.5];  
    xExtra2 = CoordExtra2(1) + x3;
    yExtra2 = CoordExtra2(2) + y3;

    line(axesEC, [pt1midx pt2midx], [pt1midy pt2midy], 'color', [0.7 0.7 0.7], 'linewidth', 2.5);
    line(axesEC, [pt1midx xExtra1], [pt1midy yExtra1], 'color', [0.7 0.7 0.7], 'linewidth', 2.5);
    line(axesEC, [pt2midx xExtra2], [pt2midy yExtra2], 'color', [0.7 0.7 0.7], 'linewidth', 2.5);
    
    if nbRaces == 1;
        offsetx = 0.5+fullscreenOffset;
        offsety = 0;
    elseif nbRaces == 2 | nbRaces == 3;
        offsetx = 0.75+fullscreenOffset;
        offsety = 0;
    elseif nbRaces == 4;
        offsetx = 0.75+fullscreenOffset;
        offsety = 0;
    else;
        offsetx = 0.75+fullscreenOffset;
        offsety = 0;
    end;
    
    midpointTXT1 = [((x_pointLine(6)-x_pointLine(5))./2)+x_pointLine(5) ((y_pointLine(6)-y_pointLine(5))./2)+y_pointLine(5)];
    text(midpointTXT1(1)-offsetx, midpointTXT1(2)+offsety, 'Turn',...
            'Units', 'Data',...
            'HorizontalAlignment', 'left',...
            'VerticalAlignment', 'middle',...
            'Color', [1 1 1], ...
            'EdgeColor', [1 1 1],...
            'BackgroundColor', [0 0 0],...
            'FontSize', label_font_size+2,...
            'FontName', 'Antiqua', ...
            'FontWeight', 'Bold', ...
            'parent', axesEC);
    midpointTXT2 = [((x_pointLine(3)-x_pointLine(2))./2)+x_pointLine(2) ((y_pointLine(3)-y_pointLine(2))./2)+y_pointLine(2)];
    text(midpointTXT2(1)+offsetx, midpointTXT2(2)+offsety, 'Start',...
            'Units', 'Data',...
            'HorizontalAlignment', 'right',...
            'VerticalAlignment', 'middle',...
            'Color', [1 1 1], ...
            'EdgeColor', [1 1 1],...
            'BackgroundColor', [0 0 0],...
            'FontSize', label_font_size+2,...
            'FontName', 'Antiqua', ...
            'FontWeight', 'Bold', ...
            'parent', axesEC);

elseif length(x_pointLine) == 10;
    x1 = x_pointLine(4);
    y1 = y_pointLine(4);
    x2 = x_pointLine(5);
    y2 = y_pointLine(5);
    line1length = sqrt((x2-x1)^2 + (y2-y1)^2);
    pt1midx = ((x2-x1)./2)+x1;
    pt1midy = ((y2-y1)./2)+y1;
    u = [1 0];
    v = [x2-x1 y2-y1];
    ThetaRad = acos(dot(u,v)/(norm(u)*norm(v)));
    ThetaRad = -ThetaRad +(0.1*ThetaRad);
    MRot = [cos(ThetaRad) -sin(ThetaRad); sin(ThetaRad) cos(ThetaRad)];
    CoordExtra1 = MRot*[line1length./2; 0.5];
    xExtra1 = CoordExtra1(1) + x1;
    yExtra1 = CoordExtra1(2) + y1;
    
    x3 = x_pointLine(10);
    y3 = y_pointLine(10);
    x4 = x_pointLine(1);
    y4 = y_pointLine(1);
    line2length = sqrt((x4-x3)^2 + (y4-y3)^2);
    pt2midx = ((x4-x3)./2)+x3;
    pt2midy = ((y4-y3)./2)+y3;
    u = [1 0];
    v = [x4-x3 y4-y3];
    ThetaRad = acos(dot(u,v)/(norm(u)*norm(v)));
    ThetaRad = ThetaRad - (0.1*ThetaRad);
    MRot = [cos(ThetaRad) -sin(ThetaRad); sin(ThetaRad) cos(ThetaRad)];
    CoordExtra2 = MRot*[line2length./2; 0.5];  
    xExtra2 = CoordExtra2(1) + x3;
    yExtra2 = CoordExtra2(2) + y3;
    
    line(axesEC, [pt1midx 0], [pt1midy 0], 'color', [0.7 0.7 0.7], 'linewidth', 2.5);
    line(axesEC, [0 pt2midx], [0 pt2midy], 'color', [0.7 0.7 0.7], 'linewidth', 2.5);
    line(axesEC, [pt1midx xExtra1], [pt1midy yExtra1], 'color', [0.7 0.7 0.7], 'linewidth', 2.5);
    line(axesEC, [pt2midx xExtra2], [pt2midy yExtra2], 'color', [0.7 0.7 0.7], 'linewidth', 2.5);
    
    if nbRaces == 1;
        offsetx = 0.5;
        offsety = 0.35;
    elseif nbRaces == 2;
        offsetx = 1.2;
        offsety = 0.5;
    elseif nbRaces == 3;
        offsetx = 1;
        offsety = 0.5;
    else;
        offsetx = 1;
        offsety = 0.5;
    end;
    midpointTXT1 = [((x_pointLine(8)-x_pointLine(7))./2)+x_pointLine(7) ((y_pointLine(8)-y_pointLine(7))./2)+y_pointLine(7)];
    text(midpointTXT1(1)-offsetx, midpointTXT1(2)-offsety, 'Turns',...
            'Units', 'Data',...
            'HorizontalAlignment', 'left',...
            'VerticalAlignment', 'middle',...
            'Color', [1 1 1], ...
            'EdgeColor', [1 1 1],...
            'BackgroundColor', [0 0 0],...
            'FontSize', label_font_size+2,...
            'FontName', 'Antiqua', ...
            'FontWeight', 'Bold', ...
            'parent', axesEC);
    midpointTXT2 = [((x_pointLine(3)-x_pointLine(2))./2)+x_pointLine(2) ((y_pointLine(3)-y_pointLine(2))./2)+y_pointLine(2)];
    text(midpointTXT2(1)+offsetx, midpointTXT2(2)+offsety, 'Start',...
            'Units', 'Data',...
            'HorizontalAlignment', 'right',...
            'VerticalAlignment', 'middle',...
            'Color', [1 1 1], ...
            'EdgeColor', [1 1 1],...
            'BackgroundColor', [0 0 0],...
            'FontSize', label_font_size+2,...
            'FontName', 'Antiqua', ...
            'FontWeight', 'Bold', ...
            'parent', axesEC);
        
elseif length(x_pointLine) == 5;
    x1 = x_pointLine(4);
    y1 = y_pointLine(4);
    x2 = x_pointLine(5);
    y2 = y_pointLine(5);
    line1length = sqrt((x2-x1)^2 + (y2-y1)^2);
    pt1midx = ((x2-x1)./2)+x1;
    pt1midy = ((y2-y1)./2)+y1;
    u = [1 0];
    v = [x2-x1 y2-y1];
    ThetaRad = acos(dot(u,v)/(norm(u)*norm(v)));
    MRot = [cos(ThetaRad) -sin(ThetaRad); sin(ThetaRad) cos(ThetaRad)];
    CoordExtra1 = MRot*[line1length./2; 0.5];
    xExtra1 = CoordExtra1(1) + x1;
    yExtra1 = CoordExtra1(2) + y1;
    
    x3 = x_pointLine(5);
    y3 = y_pointLine(5);
    x4 = x_pointLine(1);
    y4 = y_pointLine(1);
    line2length = sqrt((x4-x3)^2 + (y4-y3)^2);
    pt2midx = ((x4-x3)./2)+x3;
    pt2midy = ((y4-y3)./2)+y3;
    u = [1 0];
    v = [x4-x3 y4-y3];
    ThetaRad = acos(dot(u,v)/(norm(u)*norm(v)));
    MRot = [cos(ThetaRad) -sin(ThetaRad); sin(ThetaRad) cos(ThetaRad)];
    CoordExtra2 = MRot*[line2length./2; 0.5];  
    xExtra2 = CoordExtra2(1) + x3;
    yExtra2 = CoordExtra2(2) + y3;

    line(axesEC, [pt1midx pt2midx], [pt1midy pt2midy], 'color', [0.7 0.7 0.7], 'linewidth', 2.5);
    line(axesEC, [pt1midx xExtra1], [pt1midy yExtra1], 'color', [0.7 0.7 0.7], 'linewidth', 2.5);
    line(axesEC, [pt2midx xExtra2], [pt2midy yExtra2], 'color', [0.7 0.7 0.7], 'linewidth', 2.5);
    
    if nbRaces == 1;
        offsetx = 0.4;
        offsety = 0.4;
    elseif nbRaces == 2 | nbRaces == 3;
        offsetx = 0.55;
        offsety = 0.4;
    elseif nbRaces == 4;
        offsetx = 0.6;
        offsety = 0.4;
    else;
        offsetx = 0.65;
        offsety = 0.4;
    end;
    
    midpointTXT1 = [((x_pointLine(5)-x_pointLine(4))./2)+x_pointLine(4) ((y_pointLine(5)-y_pointLine(4))./2)+y_pointLine(4)];
    text(midpointTXT1(1)-offsetx, midpointTXT1(2)+offsety, 'Finish',...
            'Units', 'Data',...
            'HorizontalAlignment', 'right',...
            'VerticalAlignment', 'middle',...
            'Color', [1 1 1], ...
            'EdgeColor', [1 1 1],...
            'BackgroundColor', [0 0 0],...
            'FontSize', label_font_size+2,...
            'FontName', 'Antiqua', ...
            'FontWeight', 'Bold', ...
            'parent', axesEC);
        
    midpointTXT2 = [((x_pointLine(3)-x_pointLine(2))./2)+x_pointLine(2) ((y_pointLine(3)-y_pointLine(2))./2)+y_pointLine(2)];
    text(midpointTXT2(1)+offsetx, midpointTXT2(2)-offsety, 'Start',...
            'Units', 'Data',...
            'HorizontalAlignment', 'right',...
            'VerticalAlignment', 'middle',...
            'Color', [1 1 1], ...
            'EdgeColor', [1 1 1],...
            'BackgroundColor', [0 0 0],...
            'FontSize', label_font_size+2,...
            'FontName', 'Antiqua', ...
            'FontWeight', 'Bold', ...
            'parent', axesEC);
end;



%%% Labels %%%
% Check labels argument
if ~strcmp(axes_labels, 'none')
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta, rho(end));
    
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
        
        if length(x_pointLine) == 6;
            if ii == 1;
                DataVal = roundn(axestitlesvalues(:,ii),-2);
                DataTXT = [];
                for race = 1:length(DataVal);
                    TXTEC = timeSecToStr(DataVal(race,1));
                    TXTEC = TXTEC(1:end-2);
                    DataTXT = [DataTXT '/' TXTEC];
                end;
                DataTXT = [DataTXT ' s'];
            elseif ii == 2
                DataVal = axestitlesvalues(:,ii);
                DataTXT = [];
                for race = 1:length(DataVal);
                    if P(race,2) == 0;
                        DataTXT = [DataTXT '/na'];
                    else;
                        DataTXT = [DataTXT '/' dataToStr(DataVal(race,1),2)];
                    end;
                end;
                DataTXT = [DataTXT ' m'];
            elseif ii == 3;
                DataVal = axestitlesvalues(:,ii);
                DataTXT = [];
                for race = 1:length(DataVal);
                    if P(race,3) == 0;
                        DataTXT = [DataTXT '/na'];
                    else;
                        DataTXT = [DataTXT '/' dataToStr(DataVal(race,1),2)];
                    end;
                end;
                DataTXT = [DataTXT ' m/s'];
            elseif ii == 4 | ii == 5 | ii == 6;
                DataVal = axestitlesvalues(:,ii).*100;
                DataTXT = [];
                for race = 1:length(DataVal);
                    DataTXT = [DataTXT '/' dataToStr(DataVal(race,1),1)];
                end;
                DataTXT = [DataTXT ' %'];
            end;
%         elseif length(x_pointLine) == 10;
%             if ii == 1;
%                 DataVal = roundn(axestitlesvalues(ii),-2);
%                 DataTXT = timeSecToStr(DataVal);
%             elseif ii == 2
%                 DataVal = roundn(axestitlesvalues(ii).*100,-2);
%                 DataTXT = [dataToStr(DataVal) ' m'];
%             elseif ii == 3;
%                 DataVal = roundn(axestitlesvalues(ii).*100,-2);
%                 DataTXT = [dataToStr(DataVal) ' m/s'];
%             elseif ii == 4 | ii == 5 | ii == 6 | ii == 7 | ii == 8 | ii == 9 | ii == 10;
%                 DataVal = roundn(axestitlesvalues(ii).*100,-2);
%                 DataTXT = [dataToStr(DataVal) ' %'];
%             end;
        elseif length(x_pointLine) == 5;
            if ii == 1;
                DataVal = roundn(axestitlesvalues(:,ii),-2);
                DataTXT = [];
                for race = 1:length(DataVal);
                    TXTEC = timeSecToStr(DataVal(race,1));
                    TXTEC = TXTEC(1:end-2);
                    DataTXT = [DataTXT(2:end) '/' TXTEC];
                end;
                DataTXT = [DataTXT ' s'];
            elseif ii == 2;
                DataVal = axestitlesvalues(:,ii);
                DataTXT = [];
                for race = 1:length(DataVal);
                    if P(race,2) == 0;
                        DataTXT = [DataTXT '/na'];
                    else;
                        DataTXT = [DataTXT '/' dataToStr(DataVal(race,1),2)];
                    end;
                end;
                DataTXT = [DataTXT ' m'];
            elseif ii == 3;
                    DataVal = axestitlesvalues(:,ii);
                    DataTXT = [];
                    for race = 1:length(DataVal);
                        if P(race,3) == 0;
                            DataTXT = [DataTXT '/na'];
                        else;
                            DataTXT = [DataTXT '/' dataToStr(DataVal(race,1),2)];
                        end;
                    end;
                    DataTXT = [DataTXT ' m/s'];
            elseif ii == 4 | ii == 5;
                DataVal = axestitlesvalues(:,ii).*100;
                DataTXT = [];
                for race = 1:length(DataVal);
                    DataTXT = [DataTXT '/' dataToStr(DataVal(race,1),1)];
                end;
                DataTXT = [DataTXT ' %'];
            end;
        end;
        if strcmpi(DataTXT(1), '/') == 1;
            titleaxes = {[axes_labels{ii} ':'];DataTXT(2:end)};
        elseif strcmpi(DataTXT(1), '.') == 1;;
            titleaxes = {[axes_labels{ii} ':']; ['0' DataTXT]};
        else;
            titleaxes = {[axes_labels{ii} ':'];DataTXT};
        end;
        
        
        % Display text label
        text(x_axes(ii)+x_pos, y_axes(ii)+y_pos, titleaxes,...
            'Units', 'Data',...
            'HorizontalAlignment', 'center',...
            'VerticalAlignment', vert_align,...
            'Color', [1 1 1], ...
            'FontSize', label_font_size, ...
            'FontName', 'Antiqua', ...
            'FontWeight', 'Bold', ...
            'parent', axesEC);
    end
end
