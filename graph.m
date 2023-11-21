% Data for sorting algorithms
sizes = [1000, 2000, 3000, 4000];

% Elapsed times for each algorithm at different sizes
insertion_sort = [10991, 31025, 9730, 17471];
merge_sort = [2410, 1726, 3790, 5332];
bubble_sort = [22718, 34893, 51413, 95118];
quick_sort = [2088, 1084, 1463, 2179];
selection_sort = [12803, 24339, 11299, 22692];

% Plotting the data
figure;
plot(sizes, insertion_sort, '-o', 'LineWidth', 2, 'DisplayName', 'Insertion Sort');
hold on;
plot(sizes, merge_sort, '-o', 'LineWidth', 2, 'DisplayName', 'Merge Sort');
plot(sizes, bubble_sort, '-o', 'LineWidth', 2, 'DisplayName', 'Bubble Sort');
plot(sizes, quick_sort, '-o', 'LineWidth', 2, 'DisplayName', 'Quick Sort');
plot(sizes, selection_sort, '-o', 'LineWidth', 2, 'DisplayName', 'Selection Sort');

% Adding labels and title
xlabel('Input Size');
ylabel('Elapsed Time (nanoseconds)');
title('Sorting Algorithm Performance');
legend('show');

% Display the grid
grid on;

% Customize the appearance (optional)
set(gca, 'xtick', sizes);
set(gca, 'yscale', 'log'); % Use a logarithmic scale for better visibility

% Save the plot as an image (optional)
% print('sorting_performance_plot', '-dpng', '-r300');

hold off;
