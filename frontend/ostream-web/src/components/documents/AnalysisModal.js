import {
	Dialog,
	DialogTitle,
	DialogContent,
	DialogActions,
	Button,
	Box,
	Typography,
	Grid,
	Paper,
	LinearProgress,
} from '@mui/material';
import {
	Timeline,
	Description,
	Share,
	Comment,
	History,
} from '@mui/icons-material';

function AnalysisModal({ open, onClose, document }) {
	if (!document) return null;

	// Calculate mock statistics
	const stats = {
		views: Math.floor(Math.random() * 100),
		shares: document.sharedWith?.length || 0,
		comments: document.comments?.length || 0,
		versions: document.versions?.length || 1,
		lastAccessed: new Date().toLocaleDateString(),
		createdAt: new Date(document.createdAt || Date.now()).toLocaleDateString(),
		status: document.status,
		completionRate: document.status === 'approved' ? 100 : 
					   document.status === 'in_review' ? 60 : 30,
	};

	return (
		<Dialog open={open} onClose={onClose} maxWidth="md" fullWidth>
			<DialogTitle>Document Analysis - {document.name}</DialogTitle>
			
			<DialogContent>
				<Grid container spacing={3}>
					{/* Document Info */}
					<Grid item xs={12}>
						<Paper sx={{ p: 2 }}>
							<Typography variant="h6" gutterBottom>
								Document Overview
							</Typography>
							<Grid container spacing={2}>
								<Grid item xs={6}>
									<Typography variant="body2" color="text.secondary">
										Type: {document.type}
									</Typography>
									<Typography variant="body2" color="text.secondary">
										Department: {document.department}
									</Typography>
								</Grid>
								<Grid item xs={6}>
									<Typography variant="body2" color="text.secondary">
										Created: {stats.createdAt}
									</Typography>
									<Typography variant="body2" color="text.secondary">
										Last Accessed: {stats.lastAccessed}
									</Typography>
								</Grid>
							</Grid>
						</Paper>
					</Grid>

					{/* Progress */}
					<Grid item xs={12}>
						<Paper sx={{ p: 2 }}>
							<Typography variant="subtitle1" gutterBottom>
								Completion Progress
							</Typography>
							<Box sx={{ display: 'flex', alignItems: 'center' }}>
								<Box sx={{ width: '100%', mr: 1 }}>
									<LinearProgress 
										variant="determinate" 
										value={stats.completionRate} 
										sx={{ height: 10, borderRadius: 5 }}
									/>
								</Box>
								<Box sx={{ minWidth: 35 }}>
									<Typography variant="body2" color="text.secondary">
										{stats.completionRate}%
									</Typography>
								</Box>
							</Box>
						</Paper>
					</Grid>

					{/* Statistics */}
					
				</Grid>
			</DialogContent>

			<DialogActions>
				<Button onClick={onClose}>Close</Button>
			</DialogActions>
		</Dialog>
	);
}

export default AnalysisModal;