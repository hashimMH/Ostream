import { create } from 'zustand';

const useNotificationStore = create((set, get) => ({
  notifications: [],
  
  addNotification: (notification) => 
    set((state) => ({
      notifications: [
        { id: Date.now(), ...notification, read: false },
        ...state.notifications
      ]
    })),
    
  markAsRead: (id) =>
    set((state) => ({
      notifications: state.notifications.map((n) =>
        n.id === id ? { ...n, read: true } : n
      )
    })),
    
  clearAll: () => set({ notifications: [] }),
  
  getUnreadCount: () => {
    const { notifications } = get();
    return notifications.filter(n => !n.read).length;
  },
}));

export default useNotificationStore; 