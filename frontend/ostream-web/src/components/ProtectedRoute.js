import { Navigate, useLocation } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

function ProtectedRoute({ children, requiredPermissions = [] }) {
  const { currentUser, isAuthenticated } = useAuth();
  const location = useLocation();

  if (!isAuthenticated) {
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  // Superadmin has access to everything
  if (currentUser.role === 'superadmin') {
    return children;
  }

  // Check if user has all required permissions
  const hasRequiredPermissions = requiredPermissions.every(permission =>
    currentUser.permissions.includes(permission)
  );

  if (!hasRequiredPermissions) {
    return <Navigate to="/unauthorized" replace />;
  }

  return children;
}

export default ProtectedRoute; 