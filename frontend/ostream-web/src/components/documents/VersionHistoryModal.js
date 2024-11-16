import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  Box,
  Typography,
  List,
  ListItem,
  ListItemText,
  ListItemIcon,
  ListItemSecondaryAction,
  IconButton,
  Chip,
  Divider,
} from '@mui/material';
import {
  History as HistoryIcon,
  GetApp as DownloadIcon,
  Restore as RestoreIcon,
} from '@mui/icons-material';
import { useAuth } from '../../context/AuthContext';

function VersionHistoryModal({ open, onClose, document }) {
  const { currentUser } = useAuth();

  // Mock version history data
  const versions = [
    {
      id: 1,
      version: '1.0',
      timestamp: new Date().toISOString(),
      author: currentUser.username,
      changes: 'Initial version',
      status: 'current'
    },
    {
      id: 2,
      version: '0.2',
      timestamp: new Date(Date.now() - 86400000).toISOString(), // 1 day ago
      author: 'John Doe',
      changes: 'Updated content and formatting',
      status: 'previous'
    },
    {
      id: 3,
      version: '0.1',
      timestamp: new Date(Date.now() - 172800000).toISOString(), // 2 days ago
      author: 'Jane Smith',
      changes: 'Draft version',
      status: 'previous'
    }
  ];

  const handleRestore = (versionId) => {
    console.log('Restoring version:', versionId);
    // Implement version restore logic
  };

  const handleDownload = (versionId) => {
    console.log('Downloading version:', versionId);
    // Implement version download logic
  };

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleString();
  };

  return (
    <Dialog open={open} onClose={onClose} maxWidth="md" fullWidth>
      <DialogTitle>
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
          <HistoryIcon />
          <Typography>Version History - {document?.name}</Typography>
        </Box>
      </DialogTitle>

      <DialogContent>
        <List>
          {versions.map((version, index) => (
            <Box key={version.id}>
              <ListItem>
                <ListItemIcon>
                  <Typography variant="h6" color="primary">
                    v{version.version}
                  </Typography>
                </ListItemIcon>
                <ListItemText
                  primary={
                    <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                      {version.changes}
                      {version.status === 'current' && (
                        <Chip 
                          label="Current" 
                          size="small" 
                          color="primary" 
                          variant="outlined"
                        />
                      )}
                    </Box>
                  }
                  secondary={
                    <>
                      <Typography variant="body2" color="text.secondary">
                        By {version.author} on {formatDate(version.timestamp)}
                      </Typography>
                    </>
                  }
                />
                <ListItemSecondaryAction>
                  <IconButton 
                    edge="end" 
                    aria-label="download"
                    onClick={() => handleDownload(version.id)}
                    sx={{ mr: 1 }}
                  >
                    <DownloadIcon />
                  </IconButton>
                  {version.status !== 'current' && (
                    <IconButton 
                      edge="end" 
                      aria-label="restore"
                      onClick={() => handleRestore(version.id)}
                    >
                      <RestoreIcon />
                    </IconButton>
                  )}
                </ListItemSecondaryAction>
              </ListItem>
              {index < versions.length - 1 && <Divider variant="inset" component="li" />}
            </Box>
          ))}
        </List>
      </DialogContent>

      <DialogActions>
        <Button onClick={onClose}>Close</Button>
      </DialogActions>
    </Dialog>
  );
}

export default VersionHistoryModal; 