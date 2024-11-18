import { create } from 'zustand';

const useDocumentStore = create((set) => ({
  documents: [],
  analytics: {
    totalDocuments: 0,
    sharedDocuments: 0,
    totalComments: 0,
    documentTypes: [],
    departmentActivity: [],
  },
  loading: false,
  error: null,
  
  setDocuments: (documents) => set({ documents }),
  setAnalytics: (analytics) => set({ analytics }),
  addDocument: (document) => 
    set((state) => ({ documents: [...state.documents, document] })),
  updateDocument: (id, updates) =>
    set((state) => ({
      documents: state.documents.map((doc) =>
        doc.id === id ? { ...doc, ...updates } : doc
	),
	})),
	deleteDocument: (id) =>
	set((state) => ({
	documents: state.documents.filter((doc) => doc.id !== id),
	})),
	setLoading: (loading) => set({ loading }),
	setError: (error) => set({ error }),
	}));
	export default useDocumentStore;