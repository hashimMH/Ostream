import { useState } from 'react';
import {
  Box,
  TextField,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Button,
  Grid,
} from '@mui/material';
import { DateRangePicker } from '@mui/lab';
import useDocumentStore from '../../store/documentStore';

function SearchFilters() {
  const { searchFilters, setSearchFilters } = useDocumentStore();
  const [dateRange, setDateRange] = useState([null, null]);

  const handleFilterChange = (field, value) => {
    setSearchFilters({ [field]: value });
  };

  const handleDateRangeChange = (newRange) => {
    setDateRange(newRange);
    setSearchFilters({ dateRange: newRange });
  };

  const handleReset = () => {
    setSearchFilters({
      query: '',
      department: '',
      status: '',
      dateRange: null,
    });
    setDateRange([null, null]);
  };

  return (
    <Box sx={{ mb: 3 }}>
      <Grid container spacing={2} alignItems="center">
        <Grid item xs={12} md={3}>
          <TextField
            fullWidth
            label="Search"
            value={searchFilters.query}
            onChange={(e) => handleFilterChange('query', e.target.value)}
          />
        </Grid>
        <Grid item xs={12} md={2}>
          <FormControl fullWidth>
            <InputLabel>Department</InputLabel>
            <Select
              value={searchFilters.department}
              onChange={(e) => handleFilterChange('department', e.target.value)}
            >
              <MenuItem value="">All</MenuItem>
              <MenuItem value="finance">Finance</MenuItem>
              <MenuItem value="hr">HR</MenuItem>
              <MenuItem value="it">IT</MenuItem>
            </Select>
          </FormControl>
        </Grid>
        <Grid item xs={12} md={2}>
          <FormControl fullWidth>
            <InputLabel>Status</InputLabel>
            <Select
              value={searchFilters.status}
              onChange={(e) => handleFilterChange('status', e.target.value)}
            >
              <MenuItem value="">All</MenuItem>
              <MenuItem value="draft">Draft</MenuItem>
              <MenuItem value="in_review">In Review</MenuItem>
              <MenuItem value="approved">Approved</MenuItem>
              <MenuItem value="rejected">Rejected</MenuItem>
            </Select>
          </FormControl>
        </Grid>
        <Grid item xs={12} md={3}>
          <DateRangePicker
            value={dateRange}
            onChange={handleDateRangeChange}
            renderInput={(startProps, endProps) => (
              <>
                <TextField {...startProps} />
                <Box sx={{ mx: 2 }}> to </Box>
                <TextField {...endProps} />
              </>
            )}
          />
        </Grid>
        <Grid item xs={12} md={2}>
          <Button 
            variant="outlined" 
            onClick={handleReset}
            fullWidth
          >
            Reset Filters
          </Button>
        </Grid>
      </Grid>
    </Box>
  );
}

export default SearchFilters; 