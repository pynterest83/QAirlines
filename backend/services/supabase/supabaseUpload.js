import supabase from './supabaseClient'; // Supabase client đã khởi tạo
import path from 'path';

export const uploadFilesToSupabase = async (req, res) => {
    try {
        const { flightID } = req.params;

        const svgFile = req.files?.svg;
        const jsonFile = req.files?.json;

        if (!svgFile || !jsonFile) {
            return res.status(400).json({ error: 'Both SVG and JSON files are required' });
        }

        // Kiểm tra định dạng file
        if (path.extname(svgFile.name) !== '.svg') {
            return res.status(400).json({ error: 'Invalid SVG file format. Only .svg is allowed.' });
        }
        if (path.extname(jsonFile.name) !== '.json') {
            return res.status(400).json({ error: 'Invalid JSON file format. Only .json is allowed.' });
        }

        // Upload SVG vào Supabase Storage
        const svgUploadPath = `${flightID}/${svgFile.name}`;
        const svgUpload = await supabase.storage
            .from('flight-files')
            .upload(svgUploadPath, svgFile.data, {
                cacheControl: '3600',
                upsert: true, // Ghi đè nếu file đã tồn tại
                contentType: 'image/svg+xml'
            });

        if (svgUpload.error) throw svgUpload.error;

        // Upload JSON vào Supabase Storage
        const jsonUploadPath = `${flightID}/${jsonFile.name}`;
        const jsonUpload = await supabase.storage
            .from('flight-files')
            .upload(jsonUploadPath, jsonFile.data, {
                cacheControl: '3600',
                upsert: true, // Ghi đè nếu file đã tồn tại
                contentType: 'application/json'
            });

        if (jsonUpload.error) throw jsonUpload.error;

        // Lấy URL công khai của file SVG và JSON
        const svgPublicUrl = supabase.storage
            .from('flight-files')
            .getPublicUrl(svgUploadPath).data.publicUrl;

        const jsonPublicUrl = supabase.storage
            .from('flight-files')
            .getPublicUrl(jsonUploadPath).data.publicUrl;

        // Trả kết quả về client
        res.status(200).json({
            message: 'Files uploaded successfully',
            files: {
                svgUrl: svgPublicUrl,
                jsonUrl: jsonPublicUrl
            }
        });
    } catch (error) {
        console.error('Error uploading files:', error.message);
        res.status(500).json({ error: 'Failed to upload files' });
    }
};
