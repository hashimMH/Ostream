import { useState } from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  FormGroup,
  FormControlLabel,
  Checkbox,
  Typography,
} from '@mui/material';
import useDocumentStore from '../../store/documentStore';

function ShareModal({ open, onClose, document }) {
  const { updateDocument } = useDocumentStore();
  const [selectedDepts, setSelectedDepts] = useState(document?.sharedWith || []);
  const departments = ['Finance', 'HR', 'IT', 'Legal'];

  const handleShare = () => {
    updateDocument(document.id, { sharedWith: selectedDepts });
    onClose();
  };

  const handleToggle = (dept) => {
    setSelectedDepts(prev =>
      prev.includes(dept)
        ? prev.filter(d => d !== dept)
        : [...prev, dept]
    );
  };

  return (
    <Dialog open={open} onClose={onClose}>
      <DialogTitle>Share Document</DialogTitle>
      <DialogContent>
        <Typography gutterBottom>
          Share "{document?.name}" with departments:
        </Typography>
        <FormGroup>
          {departments.map((dept) => (
            <FormControlLabel
              key={dept}
              control={
                <Checkbox
                  checked={selectedDepts.includes(dept)}
                  onChange={() => handleToggle(dept)}
                  disabled={dept === document?.department}
                />
              }
              label={dept === document?.department ? `${dept} (Owner)` : dept}
            />
          ))}
        </FormGroup>
      </DialogContent>
      <DialogActions>
        <Button onClick={onClose}>Cancel</Button>
        <Button onClick={handleShare} variant="contained">
          Share
        </Button>
      </DialogActions>
    </Dialog>
  );
}

export default ShareModal; 