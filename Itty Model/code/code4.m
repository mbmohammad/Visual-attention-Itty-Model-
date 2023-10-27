% Step 1: Preprocessing
% Load eye-tracking fixations and Itti model saliency map
fixations = load('E:\UNI\visio neuro\Itty\EyeMovementDetectorEvaluation-master\annotated_data\originally uploaded data\images\TH34_img_Europe_labelled_MN.mat'); % Replace with your eye-tracking fixations data
saliency_map = imread('E:\UNI\visio neuro\Itty\latex\figures\screenshot006.png'); % Replace with your Itti model saliency map
fixations = fixations.ETdata.pos;
fixations = fixations(:,4:5);
% Step 2: Compute NSS
fixations = zscore(fixations); % Normalize fixations
saliency_map = im2double(saliency_map); % Convert saliency map to double
saliency_values = saliency_map(sub2ind(size(saliency_map), fixations(:, 2), fixations(:, 1))); % Extract saliency values at fixation locations
nss_score = mean(saliency_values); % Compute NSS score

% Step 3: Generate ROC curve
thresholds = linspace(0, 1, 100); % Set threshold values
true_positives = zeros(size(thresholds));
false_positives = zeros(size(thresholds));

for i = 1:numel(thresholds)
    threshold = thresholds(i);
    binarized_map = saliency_map >= threshold; % Binarize saliency map using threshold
    true_positives(i) = sum(binarized_map(fixations(:, 2), fixations(:, 1))); % Count true positives
    false_positives(i) = sum(binarized_map(:)) - true_positives(i); % Count false positives
end

sensitivity = true_positives / size(fixations, 1);
specificity = 1 - (false_positives / (size(saliency_map, 1) * size(saliency_map, 2)));
auc_roc = trapz(false_positives, sensitivity); % Compute AUC-ROC

% Step 4: Evaluate performance
disp(['NSS Score: ', num2str(nss_score)]);
disp(['AUC-ROC: ', num2str(auc_roc)]);

% Plot ROC curve
figure;
plot(false_positives, sensitivity);
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Curve');
grid on;
