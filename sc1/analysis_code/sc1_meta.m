function sc_meta(what,varargin)

% This function reads in the header and image data of NIfTI files
% T-Maps are Z-transformed
% New Maps are then read out to a folder, which contains all Z-Maps
% All NIfTI files have been downloaded from neurovault.org
% Written by Maedbh King 31/10/2015

%% Set-Up Directories

%base_dir = '/Volumes/ANNA/data/super_cerebellum/meta_analysis';
base_dir = '/Users/mking/Dropbox (Diedrichsenlab)/Cerebellum_Cognition/data/super_cerebellum/meta_analysis';
text_dir = [base_dir, '/Whole_Brain_Maps_Key']; % Text File Directory
image_dir = [base_dir, '/T_Maps']; % T-Maps directory
zscore_dir = [base_dir, '/Z_Maps']; % Z-Map directory
header_dir = [base_dir, '/Header_Info']; % Header Information
coor_dir = [base_dir, '/Image_Coordinates']; % Image Dimensions
resampled_dir = [base_dir, '/Resampled_Maps']; % voxels are resampled at 2mm

% Read text file
D = dload(text_dir);

switch (what)
    case 'make_zmaps'
        
        %% Z score T-Maps
        
        numImages = length(D.Image);
        
        % Find Files
        X = zeros(1,numImages); % preallocate X variable
        
        % Start loop
        for i = 1:numImages,
            
            if strcmp(D.Image{i}, 'NaN')==0, % Make file name (from NeuroVault)
                filename = sprintf('%s_%s_%s.nii',D.Citation{i},D.Image{i},D.Contrast{i});
                
            else
                filename = sprintf('%s_%s_%s.nii', D.Citation{i}, D.Task{i}, D.Contrast{i}); % Make file name (from other repository)
                
            end
            
            file_dir = [image_dir, filesep, filename]; % filepath to NIfTI images
            
            V = spm_vol(file_dir); % get header information
            X = spm_read_vols(V); % get volume data
            
            % Transformed Maps
            
            % Compute t values to z-scores
            if D.Stat{i} ~= 'z',
                df = D.Sample(i) - 1;
                z  = norminv(tcdf(X, df));
                V.fname = fullfile(zscore_dir, filename); % V.fname must be redefined to make outdir
                V.private.dat.fname = V.fname;
                
                % Create new filename
                header.Stat = 'z'; % define new stats value
            else
                z=X;
                V.fname = fullfile(zscore_dir, filename);
                V.private.dat.fname = V.fname;
            end
            
            % Add header fields
            header.Citation = D.Citation{i};
            header.Sample = D.Sample(i);
            header.Contrast = D.Contrast(i);
            header.Norm = D.Norm{i};
            header.Image = D.Image{i};
            header.Stat = D.Image{i};
            header.Thresh = D.Thresh(i);
            header.Field_Strength = D.Field_Strength{i};
            header.Brain_Coverage = D.Brain_Coverage(i);
            header.Task = D.Task{i};
            
            %% Write out new maps
            
            cd(zscore_dir);
            V = spm_write_vol(V, z); % V = header information; z = image data.
            
            % textfile
            headerFile = sprintf('%s.txt', filename);
            dsave(fullfile(header_dir, headerFile), header);
            
            disp(sprintf('Processing %s', headerFile))
        end
        
    case 'find_coordinates'
        
        for i = 1:numImages,
            
            filename = dir_no_hidden(zscore_dir);
            file_dir = [zscore_dir, filesep, filename(i).name]; % filepath to NIfTI images
            
            V = spm_vol(file_dir); % get header information
            
            % get x,y,z coordinates
            image.dim = NaN(4,4);
            image.dim(1,1) = V.dim(1,1);
            image.dim(2,1) = V.dim(1,2);
            image.dim(3,1) = V.dim(1,3);
            
            % get affine transform
            image.transform = V.mat;
            
            % make outfile
            coorFile = sprintf('%s_.txt',filename);
            dsave(fullfile(coor_dir,coorFile), image)
            
        end
        
    case 'resample'
        % resample all z-scored voxels at 2mm
        
        numImages = length(D.Image);
        
        for i = 1:numImages,
            
            % check if voxel size is not 2mm
            
            filename = dir_no_hidden(zscore_dir);
            file_dir = [zscore_dir, filesep, filename(i).name]; % filepath to NIfTI images
            
            voxsiz = [2 2 2]; % new voxel size {mm}
            V = spm_vol(file_dir);
            X = spm_read_vols(V);
            bb = spm_get_bbox(V);
            
            V.mat = spm_matrix([bb(1,:) 0 0 0 voxsiz])*spm_matrix([-1 -1 -1]);
            V.dim = ceil(V.mat \ [bb(2,:) 1]' - 0.1)';
            V.dim = V.dim(1:3);
            V.fname = fullfile(resampled_dir, filename(i).name); % V.fname must be redefined to make outdir
            V.private.dat.fname = V.fname;
            
            spm_reslice(V,struct('mean',false,'which',1,'interp',0)); % 1 for linear
            V = spm_write_vol(V, X); % V = header information; X = image data.
            
        end
        
    case 'cerebellar_coverage'
        % Calculates cerebellar coverage
end

