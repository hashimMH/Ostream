import { useState } from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
  Checkbox,
  Typography,
} from '@mui/material';
import useDocumentStore from '../../store/documentStore';
import useNotificationStore from '../../store/notificationStore';
import useAuthStore from '../../store/authStore';

function ShareDialog({ open, onClose, document }) {
  const departments = ['Finance', 'HR', 'IT', 'Legal'];
  const [selectedDepts, setSelectedDepts] = useState(document?.sharedWith || []);
  const updateDocument = useDocumentStore((state) => state.updateDocument);
  const addNotification = useNotificationStore((state) => state.addNotification);
  const currentUser = useAuthStore((state) => state.user);

  const handleShare = () => {
    updateDocument(document.id, { sharedWith: selectedDepts });
    
    // Send notifications to selected departments
    selectedDepts.forEach(dept => {
      addNotification({
        title: 'New Document Shared',
        message: `${currentUser.name} from ${currentUser.department} shared "${document.title}" with your department`,
        type: 'share',
        documentId: document.id,
        department: dept
      });
    });
    
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
          Select departments to share with:
        </Typography>
        <List>
          {departments.map((dept) => (
            <ListItem 
              key={dept} 
              dense 
              button 
              onClick={() => handleToggle(dept)}
            >
              <ListItemIcon>
                <Checkbox
                  edge="start"
                  checked={selectedDepts.includes(dept)}
                  tabIndex={-1}
                  disableRipple
                />
              </ListItemIcon>
              <ListItemText primary={dept} />
            </ListItem>
          ))}
        </List>
      </DialogContent>
      <DialogActions>
        <Button onClick={onClose}>Cancel</Button>
        <Button 
          onClick={handleShare} 
          variant="contained" 
          color="primary"
          disabled={selectedDepts.length === 0}
        >
          Share
        </Button>
      </DialogActions>
    </Dialog>
  );
}

export default ShareDialog; 