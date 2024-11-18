import { 
	Dialog, 
	DialogTitle, 
	DialogContent,
	IconButton, 
	Box,
	Typography,
	TextField,
	Button,
	CircularProgress,
	Paper
  } from '@mui/material';
  import { Close, Send } from '@mui/icons-material';
  import { useState } from 'react';
  
  function ChatWithPDFModal({ open, onClose, document }) {
	const [question, setQuestion] = useState('');
	const [messages, setMessages] = useState([]);
	const [isLoading, setIsLoading] = useState(false);
  
	const handleSendQuestion = async () => {
	  if (!question.trim() || !document?.file) return;
  
	  setIsLoading(true);
	  const formData = new FormData();
  
	  try {
		let pdfFile;
		if (typeof document.file === 'string' && document.file.startsWith('data:')) {
		  const base64Data = document.file.split(',')[1];
		  const byteCharacters = atob(base64Data);
		  const byteNumbers = new Array(byteCharacters.length);
		  for (let i = 0; i < byteCharacters.length; i++) {
			byteNumbers[i] = byteCharacters.charCodeAt(i);
		  }
		  const byteArray = new Uint8Array(byteNumbers);
		  pdfFile = new Blob([byteArray], { type: 'application/pdf' });
		} else {
		  pdfFile = document.file;
		}
  
		const file = new File([pdfFile], document.fileName || 'document.pdf', {
		  type: 'application/pdf'
		});
  
		formData.append('pdf_file', file);
		formData.append('question', question);
  
		const response = await fetch('http://localhost:8001/chat_with_pdf', {
		  method: 'POST',
		  body: formData,
		  headers: {
			'Accept': 'application/json'
		  },
		  credentials: 'include',
		  mode: 'cors'
		});
  
		if (!response.ok) {
		  const errorData = await response.json().catch(() => ({ detail: 'Network error occurred' }));
		  throw new Error(errorData.detail || 'Failed to get response');
		}
  
		const data = await response.json();
		setMessages(prev => [...prev, 
		  { type: 'question', content: question },
		  { type: 'answer', content: data.answer }
		]);
		setQuestion('');
	  } catch (error) {
		console.error('Error:', error);
		setMessages(prev => [...prev, 
		  { type: 'system', content: `Error: ${error.message}` }
		]);
	  } finally {
		setIsLoading(false);
	  }
	};
  
	return (
	  <Dialog open={open} onClose={onClose} maxWidth="md" fullWidth>
		<DialogTitle>
		  <Box display="flex" justifyContent="space-between" alignItems="center">
			<Typography variant="h6">Chat with PDF AI Assistant</Typography>
			<IconButton onClick={onClose}>
			  <Close />
			</IconButton>
		  </Box>
		</DialogTitle>
		<DialogContent>
		  <Box sx={{ height: '60vh', display: 'flex', flexDirection: 'column' }}>
			<Box sx={{ flexGrow: 1, overflowY: 'auto', mb: 2 }}>
			  {messages.map((message, index) => (
				<Paper 
				  key={index} 
				  sx={{ 
					p: 2, 
					mb: 1, 
					bgcolor: message.type === 'system' ? 'grey.100' :
							message.type === 'question' ? 'primary.light' : 
							'background.paper',
					ml: message.type === 'question' ? 'auto' : 0,
					mr: message.type === 'answer' ? 'auto' : 0,
					maxWidth: '80%'
				  }}
				>
				  <Typography>{message.content}</Typography>
				</Paper>
			  ))}
			</Box>
  
			<Box sx={{ display: 'flex', gap: 1 }}>
			  <TextField
				fullWidth
				value={question}
				onChange={(e) => setQuestion(e.target.value)}
				placeholder="Ask a question about the document..."
				disabled={isLoading}
			  />
			  <Button
				variant="contained"
				onClick={handleSendQuestion}
				disabled={isLoading || !question.trim()}
				startIcon={isLoading ? <CircularProgress size={20} /> : <Send />}
			  >
				Send
			  </Button>
			</Box>
		  </Box>
		</DialogContent>
	  </Dialog>
	);
  }
  
  export default ChatWithPDFModal;