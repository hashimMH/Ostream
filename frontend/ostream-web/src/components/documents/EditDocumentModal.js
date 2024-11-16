import { useState, useEffect } from 'react';
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
  Typography,
  Alert,
} from '@mui/material';
import { useAuth } from '../../context/AuthContext';
import useDocumentStore from '../../store/documentStore';

function EditDocumentModal({ open, onClose, document }) {
  const { currentUser } = useAuth();
  const { updateDocument } = useDocumentStore();
  
  const [formData, setFormData] = useState({
    name: '',
    type: '',
    department: '',
    status: '',
    lastModified: new Date().toISOString()
  });

  const [error, setError] = useState('');

  useEffect(() => {
    if (document) {
      setFormData({
        name: document.name,
        type: document.type,
        department: document.department,
        status: document.status,
        lastModified: new Date().toISOString()
      });
    }
  }, [document]);

  const handleSubmit = (e) => {
    e.preventDefault();
    setError('');

    try {
      // Validate if user has permission to edit
      if (currentUser.role !== 'superadmin' && 
          document.department !== currentUser.department) {
        setError('You do not have permission to edit this document');
        return;
      }

      updateDocument(document.id, {
        ...formData,
        lastModified: new Date().toISOString()
      });

      onClose();
    } catch (err) {
      setError('Failed to update document');
    }
  };

  if (!document) return null;

  return (
    <Dialog open={open} onClose={onClose} maxWidth="sm" fullWidth>
      <DialogTitle>
        Edit Document
        <Typography variant="subtitle2" color="text.secondary">
          Last modified: {new Date(document.lastModified).toLocaleString()}
        </Typography>
      </DialogTitle>

      <form onSubmit={handleSubmit}>
        <DialogContent>
          {error && (
            <Alert severity="error" sx={{ mb: 2 }}>
              {error}
            </Alert>
          )}

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

            <FormControl required>
              <InputLabel>Department</InputLabel>
              <Select
                value={formData.department}
                label="Department"
                onChange={(e) => setFormData({ ...formData, department: e.target.value })}
                disabled={currentUser.role !== 'superadmin'}
              >
                <MenuItem value="Finance">Finance</MenuItem>
                <MenuItem value="HR">HR</MenuItem>
                <MenuItem value="IT">IT</MenuItem>
                <MenuItem value="Legal">Legal</MenuItem>
              </Select>
            </FormControl>

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
              Replace File
              <input
                type="file"
                hidden
                onChange={(e) => {
                  if (e.target.files[0]) {
                    // Handle file replacement logic here
                    console.log('New file selected:', e.target.files[0]);
                  }
                }}
              />
            </Button>
          </Box>
        </DialogContent>

        <DialogActions>
          <Button onClick={onClose}>Cancel</Button>
          <Button 
            type="submit" 
            variant="contained"
            color="primary"
          >
            Save Changes
          </Button>
        </DialogActions>
      </form>
    </Dialog>
  );
}

export default EditDocumentModal; 