import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  TextField,
} from '@mui/material';
import { useState } from 'react';

function RejectionModal({ open, onClose, onReject }) {
  const [reason, setReason] = useState('');

  const handleSubmit = () => {
    if (reason.trim()) {
      onReject(reason);
      setReason('');
    }
  };

  return (
    <Dialog open={open} onClose={onClose} maxWidth="sm" fullWidth>
      <DialogTitle>Rejection Reason</DialogTitle>
      <DialogContent>
        <TextField
          autoFocus
          multiline
          rows={4}
          fullWidth
          label="Please provide a reason for rejection"
          value={reason}
          onChange={(e) => setReason(e.target.value)}
          sx={{ mt: 2 }}
        />
      </DialogContent>
      <DialogActions>
        <Button onClick={onClose}>Cancel</Button>
        <Button 
          onClick={handleSubmit}
          variant="contained"
          color="error"
          disabled={!reason.trim()}
        >
          Submit
        </Button>
      </DialogActions>
    </Dialog>
  );
}

export default RejectionModal; 