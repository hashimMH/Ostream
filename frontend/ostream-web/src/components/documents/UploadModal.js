import { useState } from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  TextField,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Box,
  CircularProgress,
} from '@mui/material';
import { useAuth } from '../../context/AuthContext';
import useDocumentStore from '../../store/documentStore';
import { documentApi } from '../../services/api';

function UploadModal({ open, onClose }) {
  const { currentUser } = useAuth();
  const { addDocument } = useDocumentStore();
  
  const [formData, setFormData] = useState({
    name: '',
    type: 'PDF',
    department: currentUser.role === 'superadmin' ? '' : currentUser.department,
    status: 'draft',
    file: null,
    fileName: ''
  });

  const [isLoading, setIsLoading] = useState(false);

  const handleFileChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = () => {
        setFormData({ 
          ...formData, 
          file: reader.result,
          fileName: file.name,
          type: file.name.split('.').pop().toUpperCase(),
          name: formData.name || file.name.split('.')[0]
        });
      };
      reader.readAsDataURL(file);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!formData.file) {
      return;
    }

    setIsLoading(true);

    try {
      const formDataToSend = new FormData();
      const file = await fetch(formData.file).then(r => r.blob());
      formDataToSend.append('file', file, formData.fileName);
      formDataToSend.append('name', formData.name);
      formDataToSend.append('type', formData.type);
      formDataToSend.append('department', formData.department);
      formDataToSend.append('status', formData.status);

      const response = await fetch('http://127.0.0.1:8000/api/upload', {
        method: 'POST',
        body: formDataToSend,
      });

      if (!response.ok) {
        throw new Error('Upload failed');
      }

      const result = await response.json();
      
      const newDocument = {
        ...formData,
        id: Date.now(),
        createdBy: currentUser.id,
        createdAt: new Date().toISOString(),
        lastModified: new Date().toISOString(),
        sharedWith: [],
        file: result.fileUrl
      };

      addDocument(newDocument);
      onClose();
      setFormData({
        name: '',
        type: 'PDF',
        department: currentUser.role === 'superadmin' ? '' : currentUser.department,
        status: 'draft',
        file: null,
        fileName: ''
      });
    } catch (error) {
      console.error('Error uploading file:', error);
      // Here you might want to show an error message to the user
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <Dialog open={open} onClose={onClose} maxWidth="sm" fullWidth>
      <DialogTitle>Upload New Document</DialogTitle>
      <form onSubmit={handleSubmit}>
        <DialogContent>
          <Box sx={{ display: 'flex', flexDirection: 'column', gap: 2 }}>
            <TextField
              required
              label="Document Name"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
            />

            <FormControl required>
              <InputLabel>Document Type</InputLabel>
              <Select
                value={formData.type}
                label="Document Type"
                onChange={(e) => setFormData({ ...formData, type: e.target.value })}
              >
                <MenuItem value="PDF">PDF</MenuItem>
                <MenuItem value="DOCX">DOCX</MenuItem>
                <MenuItem value="XLSX">XLSX</MenuItem>
              </Select>
            </FormControl>

            {currentUser.role === 'superadmin' && (
              <FormControl required>
                <InputLabel>Department</InputLabel>
                <Select
                  value={formData.department}
                  label="Department"
                  onChange={(e) => setFormData({ ...formData, department: e.target.value })}
                >
                  <MenuItem value="Finance">Finance</MenuItem>
                  <MenuItem value="HR">HR</MenuItem>
                  <MenuItem value="IT">IT</MenuItem>
                  <MenuItem value="Legal">Legal</MenuItem>
                </Select>
              </FormControl>
            )}

            <FormControl required>
              <InputLabel>Status</InputLabel>
              <Select
                value={formData.status}
                label="Status"
                onChange={(e) => setFormData({ ...formData, status: e.target.value })}
              >
                <MenuItem value="draft">Draft</MenuItem>
                <MenuItem value="in_review">In Review</MenuItem>
                <MenuItem value="approved">Approved</MenuItem>
              </Select>
            </FormControl>

            <Button
              variant="outlined"
              component="label"
            >
              Upload File
              <input
                type="file"
                hidden
                accept=".pdf,.docx,.xlsx"
                onChange={handleFileChange}
              />
            </Button>
            {formData.fileName && (
              <Box sx={{ mt: 1 }}>
                Selected file: {formData.fileName}
              </Box>
            )}
          </Box>
        </DialogContent>
        <DialogActions>
          <Button onClick={onClose}>Cancel</Button>
          <Button 
            type="submit" 
            variant="contained"
            disabled={!formData.file || isLoading}
            startIcon={isLoading ? <CircularProgress size={20} /> : null}
          >
            {isLoading ? 'Uploading...' : 'Upload'}
          </Button>
        </DialogActions>
      </form>
    </Dialog>
  );
}

export default UploadModal;
