import { Routes, Route, Navigate } from 'react-router-dom';
import Layout from '../components/layout/Layout';
import Home from '../pages/Home';
import Login from '../pages/Login';
import Signup from '../pages/Signup';
import Documents from '../pages/Documents';
import Tasks from '../pages/Tasks';
import Notifications from '../pages/Notifications';
import ProposalDashboard from '../pages/ProposalDashboard';
import { useAuth } from '../context/AuthContext';

const PrivateRoute = ({ children }) => {
  const { isAuthenticated } = useAuth();
  return isAuthenticated ? children : <Navigate to="/login" />;
};

function AppRoutes() {
  return (
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route path="/signup" element={<Signup />} />
      
      <Route path="/" element={
        <PrivateRoute>
          <Layout>
            <Home />
          </Layout>
        </PrivateRoute>
      } />
      
      <Route path="/documents" element={
        <PrivateRoute>
          <Layout>
            <Documents />
          </Layout>
        </PrivateRoute>
      } />
      
      <Route path="/proposals" element={
        <PrivateRoute>
          <Layout>
            <ProposalDashboard />
          </Layout>
        </PrivateRoute>
      } />
      
      <Route path="/tasks" element={
        <PrivateRoute>
          <Layout>
            <Tasks />
          </Layout>
        </PrivateRoute>
      } />
      
      <Route path="/notifications" element={
        <PrivateRoute>
          <Layout>
            <Notifications />
          </Layout>
        </PrivateRoute>
      } />
    </Routes>
  );
}

export default AppRoutes; 