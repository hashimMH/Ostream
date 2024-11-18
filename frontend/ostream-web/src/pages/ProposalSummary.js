import { Paper, Typography, Grid } from '@mui/material';
import { BarChart, Bar, PieChart, Pie, Cell, ResponsiveContainer, Tooltip, Legend, LineChart, Line } from 'recharts';

function ProposalCharts({ charts }) {
  const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042'];

  return (
    <Paper sx={{ p: 3 }}>
      <Typography variant="h5" gutterBottom>Project Analytics</Typography>
      <Grid container spacing={3}>
        <Grid item xs={12} md={4}>
          <Typography variant="h6" gutterBottom>Budget Allocation</Typography>
          <ResponsiveContainer width="100%" height={300}>
            <PieChart>
              <Pie
                data={charts.budgetAllocation}
                dataKey="amount"
                nameKey="category"
                cx="50%"
                cy="50%"
                outerRadius={80}
              >
                {charts.budgetAllocation.map((entry, index) => (
                  <Cell key={index} fill={COLORS[index % COLORS.length]} />
                ))}
              </Pie>
              <Tooltip />
              <Legend />
            </PieChart>
          </ResponsiveContainer>
        </Grid>

        <Grid item xs={12} md={4}>
          <Typography variant="h6" gutterBottom>Environmental Impact</Typography>
          <ResponsiveContainer width="100%" height={300}>
            <BarChart data={charts.environmentalImpact}>
              <Bar dataKey="current" fill="#8884d8" name="Current" />
              <Bar dataKey="projected" fill="#82ca9d" name="Projected" />
              <Tooltip />
              <Legend />
            </BarChart>
          </ResponsiveContainer>
        </Grid>
        <Grid item xs={12} md={4}>
          <Typography variant="h6" gutterBottom>Implementation Timeline</Typography>
          <ResponsiveContainer width="100%" height={300}>
            <LineChart data={charts.implementationTimeline}>
              <Line type="monotone" dataKey="progress" stroke="#8884d8" />
              <Tooltip />
              <Legend />
            </LineChart>
          </ResponsiveContainer>
        </Grid>
      </Grid>
    </Paper>
  );
}
export default ProposalCharts;
