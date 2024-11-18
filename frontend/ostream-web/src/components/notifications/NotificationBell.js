import { useState } from 'react';
import {
  Badge,
  IconButton,
  Menu,
  MenuItem,
  Typography,
  Box,
  Divider,
} from '@mui/material';
import { Notifications as NotificationsIcon } from '@mui/icons-material';
import useNotificationStore from '../../store/notificationStore';

function NotificationBell() {
  const [anchorEl, setAnchorEl] = useState(null);
  const { notifications, markAsRead, getUnreadCount } = useNotificationStore();
  
  const handleClick = (event) => {
    setAnchorEl(event.currentTarget);
  };
  
  const handleClose = () => {
    setAnchorEl(null);
  };
  
  const handleNotificationClick = (notification) => {
    markAsRead(notification.id);
    // Handle navigation or action based on notification type
    handleClose();
  };
  
  return (
    <>
      <IconButton color="inherit" onClick={handleClick}>
        <Badge badgeContent={getUnreadCount()} color="error">
          <NotificationsIcon />
        </Badge>
      </IconButton>
      
      <Menu
        anchorEl={anchorEl}
        open={Boolean(anchorEl)}
        onClose={handleClose}
        PaperProps={{
          sx: { width: 320, maxHeight: 400 }
        }}
      >
        {notifications.length === 0 ? (
          <MenuItem>
            <Typography>No notifications</Typography>
          </MenuItem>
        ) : (
          notifications.map((notification) => (
            <MenuItem
              key={notification.id}
              onClick={() => handleNotificationClick(notification)}
              sx={{
                backgroundColor: notification.read ? 'inherit' : 'action.hover',
                display: 'block',
              }}
            >
              <Typography variant="subtitle2">{notification.title}</Typography>
              <Typography variant="body2" color="text.secondary">
                {notification.message}
              </Typography>
              <Typography variant="caption" color="text.secondary">
                {new Date(notification.id).toLocaleString()}
              </Typography>
            </MenuItem>
          ))
        )}
      </Menu>
    </>
  );
}

export default NotificationBell; 