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
import { useState } from 'react';
import { Document, Page, pdfjs } from 'react-pdf';
import { renderAsync } from 'docx-preview';
import * as XLSX from 'xlsx-preview';

// Set PDF.js worker
pdfjs.GlobalWorkerOptions.workerSrc = `//cdnjs.cloudflare.com/ajax/libs/pdf.js/${pdfjs.version}/pdf.worker.js`;

function PreviewModal({ open, onClose, document }) {
  const [numPages, setNumPages] = useState(null);
  const [pageNumber, setPageNumber] = useState(1);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  if (!document) return null;

  const handlePreviousPage = () => {
    setPageNumber(prev => Math.max(prev - 1, 1));
  };

  const handleNextPage = () => {
    setPageNumber(prev => Math.min(prev + 1, numPages));
  };

  const base64ToUint8Array = (base64) => {
    const base64Clean = base64.split(',')[1]; // Remove the data URL prefix
    const binaryString = window.atob(base64Clean);
    const bytes = new Uint8Array(binaryString.length);
    for (let i = 0; i < binaryString.length; i++) {
      bytes[i] = binaryString.charCodeAt(i);
    }
    return bytes;
  };

  const renderPreview = () => {
    switch (document.type) {
      case 'PDF':
        const pdfData = base64ToUint8Array(document.file);
        return (
          <Box sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
            <Document
              file={pdfData}
              onLoadSuccess={({ numPages }) => {
                setNumPages(numPages);
                setLoading(false);
              }}
              onLoadError={(error) => {
                console.error('Error loading PDF:', error);
                setError('Failed to load PDF');
                setLoading(false);
              }}
              loading={<CircularProgress />}
            >
              <Page 
                pageNumber={pageNumber} 
                renderTextLayer={false}
                renderAnnotationLayer={false}
                scale={1.2}
              />
            </Document>
            
            {numPages > 0 && (
              <Box sx={{ mt: 2, display: 'flex', gap: 2, alignItems: 'center' }}>
                <Button onClick={handlePreviousPage} disabled={pageNumber <= 1}>
                  Previous
                </Button>
                <Typography>
                  Page {pageNumber} of {numPages}
                </Typography>
                <Button onClick={handleNextPage} disabled={pageNumber >= numPages}>
                  Next
                </Button>
              </Box>
            )}
          </Box>
        );

      case 'DOCX':
        return (
          <Box
            ref={(element) => {
              if (element && document.file) {
                try {
                  renderAsync(document.file, element, null, {
                    ignoreWidth: true,
                    ignoreFonts: true
                  })
                    .then(() => setLoading(false))
                    .catch(() => {
                      setError('Failed to load DOCX');
                      setLoading(false);
                    });
                } catch (err) {
                  setError('Failed to load DOCX');
                  setLoading(false);
                }
              }
            }}
          />
        );

      case 'XLSX':
        return (
          <Box
            ref={(element) => {
              if (element && document.file) {
                try {
                  const workbook = XLSX.read(document.file, { type: 'array' });
                  const firstSheet = workbook.Sheets[workbook.SheetNames[0]];
                  element.innerHTML = XLSX.utils.sheet_to_html(firstSheet);
                  setLoading(false);
                } catch (err) {
                  setError('Failed to load XLSX');
                  setLoading(false);
                }
              }
            }}
          />
        );

      default:
        return (
          <Typography color="error">
            Unsupported file type: {document.type}
          </Typography>
        );
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
          {loading ? (
            <CircularProgress />
          ) : error ? (
            <Typography color="error">{error}</Typography>
          ) : (
            renderPreview()
          )}
        </Box>
      </DialogContent>
      <DialogActions>
        <Button onClick={onClose}>Close</Button>
      </DialogActions>
    </Dialog>
  );
}

export default PreviewModal;
