import { useState } from 'react';
import {
  Container, Typography, Paper, Box, List, ListItem,
  ListItemText, IconButton, Chip, Divider
} from '@mui/material';
import { Delete as DeleteIcon, Done as DoneIcon } from '@mui/icons-material';
import useNotificationStore from '../store/notificationStore';
import useAuthStore from '../store/authStore';

function Notifications() {
  const { notifications, markAsRead, deleteNotification } = useNotificationStore();
  const userDepartment = useAuthStore(state => state.user?.department);
  
  const filteredNotifications = notifications.filter(
    n => n.department === userDepartment
  );

  return (
    <Container maxWidth="lg">
      <Box sx={{ mt: 4 }}>
        <Paper sx={{ p: 3 }}>
          <Typography variant="h4" component="h1" gutterBottom>
            Notifications
          </Typography>
          
          <List>
            {filteredNotifications.map((notification) => (
              <Box key={notification.id}>
                <ListItem
                  secondaryAction={
                    <>
                      {!notification.read && (
                        <IconButton 
                          edge="end" 
                          onClick={() => markAsRead(notification.id)}
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
                  <ListItemText
                    primary={notification.title}
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
                  {!notification.read && (
                    <Chip 
                      label="New" 
                      color="primary" 
                      size="small" 
                      sx={{ ml: 1 }} 
                    />
                  )}
                </ListItem>
                <Divider />
              </Box>
            ))}
          </List>
        </Paper>
      </Box>
    </Container>
  );
}

export default Notifications;