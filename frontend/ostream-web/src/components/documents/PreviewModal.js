import { useState, useEffect } from 'react';
import DocViewer, { DocViewerRenderers } from "@cyntler/react-doc-viewer";
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  Typography,
  Box,
  CircularProgress,
} from '@mui/material';

function PreviewModal({ open, onClose, document }) {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  if (!document) return null;

  // Convert file data to proper format for DocViewer
  const getDocumentData = (doc) => {
    try {
      return [{
        uri: doc.file,
        fileType: doc.type.toLowerCase(),
        fileName: doc.name
      }];
    } catch (error) {
      console.error('Error preparing document:', error);
      return null;
    }
  };

  return (
    <Dialog 
      open={open} 
      onClose={onClose} 
      maxWidth="md" 
      fullWidth
      PaperProps={{
        sx: { minHeight: '80vh' }
      }}
    >
      <DialogTitle>Document Preview</DialogTitle>
      <DialogContent>
        <Box sx={{ mb: 2 }}>
          <Typography variant="h6">{document.name}</Typography>
          <Typography color="textSecondary">
            Type: {document.type}
          </Typography>
        </Box>
        
        <Box sx={{ 
          bgcolor: 'grey.100', 
          p: 2, 
          borderRadius: 1,
          minHeight: 400,
          display: 'flex',
          justifyContent: 'center',
          alignItems: 'center',
          overflow: 'auto'
        }}>
          <DocViewer
            documents={getDocumentData(document)}
            pluginRenderers={DocViewerRenderers}
            config={{
              header: {
                disableHeader: true,
                disableFileName: true,
              }
            }}
            style={{ width: '100%', height: '500px' }}
            onError={(e) => {
              console.error('Preview error:', e);
              setError('Failed to load document');
              setLoading(false);
            }}
            onLoad={() => setLoading(false)}
          />
        </Box>
      </DialogContent>
      <DialogActions>
        <Button onClick={onClose}>Close</Button>
      </DialogActions>
    </Dialog>
  );
}

export default PreviewModal;
