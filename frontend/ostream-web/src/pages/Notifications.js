import { useState } from 'react';
import { useAuth } from '../context/AuthContext';
import useNotificationStore from '../store/notificationStore';
import {
  Container,
  Box,
  Paper,
  Typography,
  List,
  ListItem,
  ListItemText,
  IconButton,
  Chip,
  Divider,
} from '@mui/material';
import {
  Delete as DeleteIcon,
  Done as DoneIcon,
  Description,
  Share,
  Comment,
  Update,
} from '@mui/icons-material';

function Notifications() {
  const { currentUser } = useAuth();
  const { notifications, markAsRead, deleteNotification } = useNotificationStore();

  // Demo notifications data
  const demoNotifications = [
    {
      id: Date.now() - 1000,
      title: "New Document Shared",
      message: "Transportation Department has shared 'Q1 Infrastructure Report' with your department",
      type: "share",
      read: false,
      department: currentUser.department
    },
    {
      id: Date.now() - 2000,
      title: "Document Status Update",
      message: "Your document 'City Planning 2024' has been approved",
      type: "status",
      read: false,
      department: currentUser.department
    },
    {
      id: Date.now() - 3000,
      title: "New Comment",
      message: "John Doe commented on 'Environmental Impact Assessment'",
      type: "comment",
      read: true,
      department: currentUser.department
    },
    {
      id: Date.now() - 4000,
      title: "Document Updated",
      message: "Urban Development team updated 'Smart City Proposal v2'",
      type: "update",
      read: false,
      department: currentUser.department
    }
  ];

  const getNotificationIcon = (type) => {
    switch (type) {
      case 'share':
        return <Share color="primary" />;
      case 'status':
        return <Description color="success" />;
      case 'comment':
        return <Comment color="info" />;
      case 'update':
        return <Update color="warning" />;
      default:
        return <Description />;
    }
  };

  return (
    <Container maxWidth="lg">
      <Box sx={{ mt: 4 }}>
        <Paper sx={{ p: 3 }}>
          <Typography variant="h4" gutterBottom>
            Notifications
          </Typography>
          
          <List>
            {demoNotifications.map((notification) => (
              <Box key={notification.id}>
                <ListItem
                  sx={{
                    bgcolor: notification.read ? 'transparent' : 'action.hover',
                    borderRadius: 1,
                  }}
                  secondaryAction={
                    <>
                      {!notification.read && (
                        <IconButton 
                          edge="end" 
                          onClick={() => markAsRead(notification.id)}
                          sx={{ mr: 1 }}
                        >
                          <DoneIcon />
                        </IconButton>
                      )}
                      <IconButton 
                        edge="end" 
                        onClick={() => deleteNotification(notification.id)}
                      >
                        <DeleteIcon />
                      </IconButton>
                    </>
                  }
                >
                  <Box sx={{ mr: 2 }}>
                    {getNotificationIcon(notification.type)}
                  </Box>
                  <ListItemText
                    primary={
                      <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                        {notification.title}
                        {!notification.read && (
                          <Chip 
                            label="New" 
                            color="primary" 
                            size="small" 
                          />
                        )}
                      </Box>
                    }
                    secondary={
                      <>
                        <Typography variant="body2">
                          {notification.message}
                        </Typography>
                        <Typography variant="caption" color="text.secondary">
                          {new Date(notification.id).toLocaleString()}
                        </Typography>
                      </>
                    }
                  />
                </ListItem>
                <Divider sx={{ my: 1 }} />
              </Box>
            ))}
          </List>
        </Paper>
      </Box>
    </Container>
  );
}

export default Notifications;