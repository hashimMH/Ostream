import { useState } from 'react';
import { useNavigate, Link, useLocation } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import useUserPermissions from '../../hooks/useUserPermissions';
import {
  AppBar,
  Toolbar,
  Typography,
  Button,
  Box,
  IconButton,
  Avatar,
  Menu,
  MenuItem,
  Tabs,
  Tab,
} from '@mui/material';
import {
  HomeOutlined,
  DescriptionOutlined,
  AssignmentOutlined,
  NotificationsOutlined,
  LogoutOutlined,
} from '@mui/icons-material';
import logo from '../../assets/logo.png'; // Import the logo

function Navbar() {
  const { currentUser, logout } = useAuth();
  const { hasPermission } = useUserPermissions();
  const [anchorEl, setAnchorEl] = useState(null);
  const navigate = useNavigate();
  const location = useLocation();

  const handleMenu = (event) => {
    setAnchorEl(event.currentTarget);
  };

  const handleClose = () => {
    setAnchorEl(null);
  };

  const handleLogout = () => {
    handleClose();
    logout();
    navigate('/login');
  };

  const handleTabChange = (event, newValue) => {
    navigate(newValue);
  };

  // Get current tab value from location
  const getCurrentTab = () => {
    const path = location.pathname;
    if (path === '/') return '/';
    if (path.startsWith('/documents')) return '/documents';
    if (path.startsWith('/tasks')) return '/tasks';
    if (path.startsWith('/notifications')) return '/notifications';
    return false;
  };

  return (
    <AppBar position="static">
      <Toolbar>
        {/* Logo and Title */}
        <Box sx={{ display: 'flex', alignItems: 'center', mr: 4 }}>
          <img
            src={logo}
            alt="OStream Logo"
            style={{
              height: '40px',
              width: 'auto',
              marginRight: '12px'
            }}
          />
          <Typography variant="h6" component="div">
            OStream
          </Typography>
        </Box>

        {currentUser && (
          <>
            <Tabs 
              value={getCurrentTab()} 
              onChange={handleTabChange}
              textColor="inherit"
              indicatorColor="secondary"
              sx={{ flexGrow: 1 }}
            >
              <Tab 
                label="Home" 
                value="/" 
                icon={<HomeOutlined />} 
                iconPosition="start"
              />
              {hasPermission('view_documents') && (
                <Tab 
                  label="Documents" 
                  value="/documents" 
                  icon={<DescriptionOutlined />} 
                  iconPosition="start"
                />
              )}
              {hasPermission('view_tasks') && (
                <Tab 
                  label="Tasks" 
                  value="/tasks" 
                  icon={<AssignmentOutlined />} 
                  iconPosition="start"
                />
              )}
              <Tab 
                label="Notifications" 
                value="/notifications" 
                icon={<NotificationsOutlined />} 
                iconPosition="start"
              />
            </Tabs>

            {/* User Menu */}
            <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
              <IconButton
                onClick={handleMenu}
                color="inherit"
              >
                <Avatar sx={{ width: 32, height: 32 }}>
                  {currentUser.username[0].toUpperCase()}
                </Avatar>
              </IconButton>
              
              <Menu
                anchorEl={anchorEl}
                open={Boolean(anchorEl)}
                onClose={handleClose}
                anchorOrigin={{
                  vertical: 'bottom',
                  horizontal: 'right',
                }}
                transformOrigin={{
                  vertical: 'top',
                  horizontal: 'right',
                }}
              >
                <MenuItem disabled>
                  <Typography variant="body2">
                    {currentUser.username}
                  </Typography>
                </MenuItem>
                <MenuItem disabled>
                  <Typography variant="caption" color="text.secondary">
                    {currentUser.role} - {currentUser.department || 'All Departments'}
                  </Typography>
                </MenuItem>
                <MenuItem onClick={handleLogout}>
                  <LogoutOutlined sx={{ mr: 1 }} fontSize="small" />
                  Logout
                </MenuItem>
              </Menu>
            </Box>
          </>
        )}
      </Toolbar>
    </AppBar>
  );
}

export default Navbar;