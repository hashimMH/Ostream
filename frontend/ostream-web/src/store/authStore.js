import { create } from 'zustand';
import { persist } from 'zustand/middleware';

const useAuthStore = create(
  persist(
    (set, get) => ({
      user: null,
      roles: [],
      permissions: [],
      
      setUser: (user) => set({ user }),
      
      setRoles: (roles) => set({ roles }),
      
      hasPermission: (permission) => {
        const { permissions } = get();
        return permissions.includes(permission);
      },
      
      getDepartment: () => {
        const { user } = get();
        return user?.email?.split('@')[0] || null;
      },
      
      canAccessDocument: (document) => {
        const { user } = get();
        const userDepartment = user?.email?.split('@')[0];
        return (
          document.department === userDepartment ||
          document.sharedWith?.includes(userDepartment)
        );
      },
    }),
    {
      name: 'auth-storage',
    }
  )
);

export default useAuthStore; 