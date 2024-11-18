import { useAuth } from '../context/AuthContext';

const useUserPermissions = () => {
  const { currentUser } = useAuth();

  const hasPermission = (permission) => {
    if (!currentUser) return false;
    
    // Superadmin has all permissions
    if (currentUser.role === 'superadmin') return true;
    
    return currentUser.permissions.includes(permission);
  };

  const canAccessDocument = (document) => {
    if (!currentUser || !document) return false;
    
    // Superadmin can access all documents
    if (currentUser.role === 'superadmin') return true;
    
    // Check if user has department-level access
    if (hasPermission('view_department') && document.department === currentUser.department) {
      return true;
    }
    
    // Check if document is shared with user's department
    if (document.sharedWith?.includes(currentUser.department)) {
      return true;
    }
    
    // Check if user is the document owner
    if (document.createdBy === currentUser.id) {
      return true;
    }
    
    return false;
  };

  const canEditDocument = (document) => {
    if (!currentUser || !document) return false;
    
    // Superadmin can edit all documents
    if (currentUser.role === 'superadmin') return true;
    
    // Check if user has department-level edit access
    if (hasPermission('edit_department') && document.department === currentUser.department) {
      return true;
    }
    
    // Check if user can edit their own documents
    if (hasPermission('edit_own') && document.createdBy === currentUser.id) {
      return true;
    }
    
    return false;
  };

  return {
    hasPermission,
    canAccessDocument,
    canEditDocument,
  };
};

export default useUserPermissions; 