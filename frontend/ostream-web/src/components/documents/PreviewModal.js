import { 
  Dialog, 
  DialogTitle, 
  DialogContent, 
  IconButton, 
  Box,
  Typography,
  Grid,
  Paper,
  Button,
} from '@mui/material';
import { Close } from '@mui/icons-material';

function PreviewModal({ open, onClose, document }) {
  if (!document) return null;

  const renderContent = () => {
    if (document.file) {
      return (
        <object
          data={URL.createObjectURL(document.file)}
          type="application/pdf"
          width="100%"
          height="600px"
        >
          <p>
            PDF cannot be displayed. 
            <a href={URL.createObjectURL(document.file)} download={document.fileName}>
              Download instead
            </a>
          </p>
        </object>
      );
    }

    return (
      <Box sx={{ p: 3 }}>
        <Typography variant="h6" gutterBottom>{document.title}</Typography>
        <Typography paragraph>{document.summary?.executiveSummary}</Typography>
      </Box>
    );
  };

  return (
    <Dialog open={open} onClose={onClose} maxWidth="lg" fullWidth>
      <DialogTitle>
        <Box display="flex" justifyContent="space-between" alignItems="center">
          <Typography variant="h6">
            {document.file ? document.fileName : document.title}
          </Typography>
          <IconButton onClick={onClose}>
            <Close />
          </IconButton>
        </Box>
      </DialogTitle>
      <DialogContent>
        <Paper sx={{ minHeight: '600px' }}>
          {renderContent()}
        </Paper>
      </DialogContent>
    </Dialog>
  );
}

export default PreviewModal;
