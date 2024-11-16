import { useState, useEffect } from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  TextField,
  Box,
  Typography,
  Avatar,
  Divider,
  Paper,
} from '@mui/material';
import { Send as SendIcon } from '@mui/icons-material';
import { useAuth } from '../../context/AuthContext';
import useDocumentStore from '../../store/documentStore';

function CommentsModal({ open, onClose, document }) {
  const { currentUser } = useAuth();
  const { updateDocument } = useDocumentStore();
  const [newComment, setNewComment] = useState('');
  const [comments, setComments] = useState(document?.comments || []);

  useEffect(() => {
    setComments(document?.comments || []);
  }, [document]);

  const handleAddComment = () => {
    if (!newComment.trim()) return;

    const comment = {
      id: Date.now(),
      text: newComment,
      userId: currentUser.id,
      username: currentUser.username,
      department: currentUser.department,
      timestamp: new Date().toISOString(),
    };

    const updatedComments = [...comments, comment];
    setComments(updatedComments);
    updateDocument(document.id, { comments: updatedComments });
    setNewComment('');
  };

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleString();
  };

  return (
    <Dialog open={open} onClose={onClose} maxWidth="md" fullWidth>
      <DialogTitle>
        Comments - {document?.name}
      </DialogTitle>
      
      <DialogContent>
        <Box sx={{ height: '400px', display: 'flex', flexDirection: 'column' }}>
          {/* Comments List */}
          <Box sx={{ flexGrow: 1, overflow: 'auto', mb: 2 }}>
            {comments.length === 0 ? (
              <Typography color="text.secondary" align="center" sx={{ mt: 2 }}>
                No comments yet
              </Typography>
            ) : (
              comments.map((comment) => (
                <Paper
                  key={comment.id}
                  elevation={1}
                  sx={{ p: 2, mb: 2, bgcolor: 'background.default' }}
                >
                  <Box sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
                    <Avatar sx={{ width: 32, height: 32, mr: 1 }}>
                      {comment.username[0].toUpperCase()}
                    </Avatar>
                    <Box>
                      <Typography variant="subtitle2">
                        {comment.username} ({comment.department})
                      </Typography>
                      <Typography variant="caption" color="text.secondary">
                        {formatDate(comment.timestamp)}
                      </Typography>
                    </Box>
                  </Box>
                  <Typography>{comment.text}</Typography>
                </Paper>
              ))
            )}
          </Box>

          <Divider />

          {/* Comment Input */}
          <Box sx={{ display: 'flex', gap: 1, mt: 2 }}>
            <TextField
              fullWidth
              placeholder="Add a comment..."
              value={newComment}
              onChange={(e) => setNewComment(e.target.value)}
              multiline
              rows={2}
              variant="outlined"
              size="small"
            />
            <Button
              variant="contained"
              onClick={handleAddComment}
              disabled={!newComment.trim()}
              sx={{ minWidth: '100px' }}
            >
              <SendIcon />
            </Button>
          </Box>
        </Box>
      </DialogContent>

      <DialogActions>
        <Button onClick={onClose}>Close</Button>
      </DialogActions>
    </Dialog>
  );
}

export default CommentsModal; 