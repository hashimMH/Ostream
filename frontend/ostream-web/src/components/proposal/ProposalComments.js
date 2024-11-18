import { useState } from 'react';
import {
  Paper,
  Typography,
  Box,
  TextField,
  Button,
  List,
  ListItem,
  ListItemText,
  ListItemAvatar,
  Avatar,
  IconButton,
  Menu,
  MenuItem,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
} from '@mui/material';
import {
  MoreVert,
  Edit as EditIcon,
  Delete as DeleteIcon,
} from '@mui/icons-material';

function ProposalComments({ comments, onAddComment, onEditComment, onDeleteComment }) {
  const [newComment, setNewComment] = useState('');
  const [editingComment, setEditingComment] = useState(null);
  const [anchorEl, setAnchorEl] = useState(null);
  const [selectedComment, setSelectedComment] = useState(null);
  const [editDialogOpen, setEditDialogOpen] = useState(false);
  const [editedText, setEditedText] = useState('');

  const handleSubmitComment = () => {
    if (newComment.trim()) {
      onAddComment({
        text: newComment,
        timestamp: new Date().toISOString(),
        user: "Current User", // Replace with actual user data
        edited: false
      });
      setNewComment('');
    }
  };

  const handleEditClick = (comment) => {
    setEditingComment(comment);
    setEditedText(comment.text);
    setEditDialogOpen(true);
    setAnchorEl(null);
  };

  const handleEditSubmit = () => {
    onEditComment(editingComment.id, editedText);
    setEditDialogOpen(false);
    setEditingComment(null);
  };

  return (
    <Paper sx={{ p: 3 }}>
      <Typography variant="h5" gutterBottom>Comments</Typography>
      

      <List>
        {comments.map((comment) => (
          <ListItem
            key={comment.id}
            alignItems="flex-start"
            secondaryAction={
              <IconButton 
                edge="end" 
                onClick={(e) => {
                  setAnchorEl(e.currentTarget);
                  setSelectedComment(comment);
                }}
              >
                <MoreVert />
              </IconButton>
            }
          >
            <ListItemAvatar>
              <Avatar>{comment.user[0]}</Avatar>
            </ListItemAvatar>
            <ListItemText
              primary={
                <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                  <Typography variant="subtitle2">{comment.user}</Typography>
                  <Typography variant="caption" color="text.secondary">
                    {new Date(comment.timestamp).toLocaleString()}
                  </Typography>
                  {comment.edited && (
                    <Typography variant="caption" color="text.secondary">
                      (edited)
                    </Typography>
                  )}
                </Box>
              }
              secondary={comment.text}
            />
          </ListItem>
        ))}
      </List>

      <Menu
        anchorEl={anchorEl}
        open={Boolean(anchorEl)}
        onClose={() => setAnchorEl(null)}
      >
        <MenuItem onClick={() => handleEditClick(selectedComment)}>
          <EditIcon fontSize="small" sx={{ mr: 1 }} />
          Edit
        </MenuItem>
        <MenuItem 
          onClick={() => {
            onDeleteComment(selectedComment.id);
            setAnchorEl(null);
          }}
        >
          <DeleteIcon fontSize="small" sx={{ mr: 1 }} />
          Delete
        </MenuItem>
      </Menu>

      <Dialog open={editDialogOpen} onClose={() => setEditDialogOpen(false)}>
        <DialogTitle>Edit Comment</DialogTitle>
        <DialogContent>
          <TextField
            fullWidth
            multiline
            rows={3}
            value={editedText}
            onChange={(e) => setEditedText(e.target.value)}
            sx={{ mt: 2 }}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setEditDialogOpen(false)}>Cancel</Button>
          <Button onClick={handleEditSubmit} variant="contained">
            Save
          </Button>
        </DialogActions>
      </Dialog>
      <Box sx={{ mb: 3 }}>
        <TextField
          fullWidth
          multiline
          rows={3}
          placeholder="Add a comment..."
          value={newComment}
          onChange={(e) => setNewComment(e.target.value)}
          sx={{ mb: 1 }}
        />
        <Button 
          variant="contained" 
          onClick={handleSubmitComment}
          disabled={!newComment.trim()}
        >
          Add Comment
        </Button>
      </Box>
    </Paper>
  );
}

export default ProposalComments; 