import { useMemo } from 'react';
import { useAuth } from '../context/AuthContext';
import useDocumentStore from '../store/documentStore';
import { useNavigate } from 'react-router-dom';
import {
  Container,
  Typography,
  Paper,
  Box,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  IconButton,
} from '@mui/material';
import {
  VisibilityOutlined,
  PendingOutlined,
  DescriptionOutlined,
} from '@mui/icons-material';

function Tasks() {
  const { documents } = useDocumentStore();
  const { currentUser } = useAuth();
  const navigate = useNavigate();

  // Filter for unfinished documents
  const unfinishedTasks = useMemo(() => {
    return documents.filter(doc => {
      const isUnfinished = doc.status === 'draft' || doc.status === 'in_review';
      const hasAccess = 
        doc.department === currentUser.department || 
        doc.sharedWith?.includes(currentUser.department);

      return isUnfinished && (currentUser.role === 'superadmin' || hasAccess);
    }).sort((a, b) => new Date(b.lastModified) - new Date(a.lastModified));
  }, [documents, currentUser]);

  return (
    <Container maxWidth="xl">
      <Box sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>
          Pending Tasks {currentUser.role !== 'superadmin' && `- ${currentUser.department}`}
        </Typography>

        <Paper>
          <TableContainer>
            <Table>
              <TableHead>
                <TableRow>
                  <TableCell>Document Name</TableCell>
                  <TableCell>Type</TableCell>
                  <TableCell>Status</TableCell>
                  <TableCell>Last Modified</TableCell>
                  <TableCell>Deadline</TableCell>
                  <TableCell align="right">Actions</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {unfinishedTasks.map((task) => (
                  <TableRow 
                    key={task.id}
                    onClick={() => navigate('/proposal')}
                    sx={{ 
                      cursor: 'pointer',
                      '&:hover': { backgroundColor: 'action.hover' }
                    }}
                  >
                    <TableCell>{task.name}</TableCell>
                    <TableCell>{task.type}</TableCell>
                    <TableCell>
                      <Box sx={{ display: 'flex', alignItems: 'center' }}>
                        {task.status === 'in_review' && 
                          <PendingOutlined color="warning" sx={{ mr: 1 }} />}
                        {task.status === 'draft' && 
                          <DescriptionOutlined color="info" sx={{ mr: 1 }} />}
                        {task.status}
                      </Box>
                    </TableCell>
                    <TableCell>
                      {new Date(task.lastModified).toLocaleDateString()}
                    </TableCell>
                    <TableCell>
                      {task.deadline ? new Date(task.deadline).toLocaleDateString() : 'No deadline'}
                    </TableCell>
                    <TableCell align="right">
                      <IconButton 
                        size="small"
                        onClick={(e) => {
                          e.stopPropagation();
                          navigate('/proposal');
                        }}
                      >
                        <VisibilityOutlined />
                      </IconButton>
                    </TableCell>
                  </TableRow>
                ))}
                {unfinishedTasks.length === 0 && (
                  <TableRow>
                    <TableCell colSpan={6} align="center">
                      No pending tasks found
                    </TableCell>
                  </TableRow>
                )}
              </TableBody>
            </Table>
          </TableContainer>
        </Paper>
      </Box>
    </Container>
  );
}

export default Tasks;