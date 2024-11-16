import { create } from 'zustand';
import { persist } from 'zustand/middleware';

// Initial dummy data
const initialDocuments = [
  {
    id: 1,
    name: 'Q4 Financial Report',
    type: 'PDF',
    department: 'Finance',
    status: 'approved',
    createdAt: '2024-03-10T10:00:00',
    lastModified: '2024-03-15T10:00:00',
    createdBy: '2',
    sharedWith: ['HR'],
    comments: [
      {
        id: 1,
        text: 'Please review the Q4 projections',
        userId: '2',
        username: 'finance_manager',
        department: 'Finance',
        timestamp: '2024-03-14T09:00:00'
      }
    ],
    versions: [
      {
        id: 1,
        version: '1.0',
        timestamp: '2024-03-15T10:00:00',
        author: 'finance_manager',
        changes: 'Final version'
      }
    ],
    analytics: {
      views: 15,
      downloads: 5,
      lastAccessed: '2024-03-15T10:00:00'
    }
  },
  {
    id: 2,
    name: 'Employee Handbook 2024',
    type: 'DOCX',
    department: 'HR',
    status: 'in_review',
    createdAt: '2024-03-12T14:30:00',
    lastModified: '2024-03-14T15:30:00',
    createdBy: '3',
    sharedWith: ['Finance', 'IT'],
    comments: [],
    versions: [
      {
        id: 1,
        version: '0.9',
        timestamp: '2024-03-14T15:30:00',
        author: 'hr_user',
        changes: 'Updated policies'
      }
    ],
    analytics: {
      views: 8,
      downloads: 3,
      lastAccessed: '2024-03-14T16:00:00'
    }
  }
];

const useDocumentStore = create(
  persist(
    (set, get) => ({
      documents: initialDocuments,
      
      // Add new document
      addDocument: (document) => {
        const newDocument = {
          ...document,
          id: Date.now(),
          createdAt: new Date().toISOString(),
          lastModified: new Date().toISOString(),
          comments: [],
          versions: [
            {
              id: 1,
              version: '1.0',
              timestamp: new Date().toISOString(),
              author: document.createdBy,
              changes: 'Initial version'
            }
          ],
          analytics: {
            views: 0,
            downloads: 0,
            lastAccessed: new Date().toISOString()
          }
        };
        
        set((state) => ({
          documents: [...state.documents, newDocument]
        }));
      },

      // Update existing document
      updateDocument: (id, updates) => {
        set((state) => ({
          documents: state.documents.map((doc) => {
            if (doc.id === id) {
              // Create new version when content is updated
              const newVersion = {
                id: doc.versions.length + 1,
                version: `1.${doc.versions.length}`,
                timestamp: new Date().toISOString(),
                author: updates.modifiedBy || 'Unknown',
                changes: updates.changes || 'Document updated'
              };

              return {
                ...doc,
                ...updates,
                lastModified: new Date().toISOString(),
                versions: [...doc.versions, newVersion]
              };
            }
            return doc;
          })
        }));
      },

      // Delete document
      deleteDocument: (id) => {
        set((state) => ({
          documents: state.documents.filter((doc) => doc.id !== id)
        }));
      },

      // Add comment to document
      addComment: (documentId, comment) => {
        set((state) => ({
          documents: state.documents.map((doc) => {
            if (doc.id === documentId) {
              return {
                ...doc,
                comments: [...(doc.comments || []), comment],
                lastModified: new Date().toISOString()
              };
            }
            return doc;
          })
        }));
      },

      // Share document with department
      shareDocument: (documentId, departments) => {
        set((state) => ({
          documents: state.documents.map((doc) => {
            if (doc.id === documentId) {
              return {
                ...doc,
                sharedWith: departments,
                lastModified: new Date().toISOString()
              };
            }
            return doc;
          })
        }));
      },

      // Update document analytics
      updateAnalytics: (documentId, analyticsData) => {
        set((state) => ({
          documents: state.documents.map((doc) => {
            if (doc.id === documentId) {
              return {
                ...doc,
                analytics: {
                  ...doc.analytics,
                  ...analyticsData,
                  lastAccessed: new Date().toISOString()
                }
              };
            }
            return doc;
          })
        }));
      },

      // Restore document version
      restoreVersion: (documentId, versionId) => {
        const document = get().documents.find(doc => doc.id === documentId);
        const version = document?.versions.find(v => v.id === versionId);
        
        if (document && version) {
          set((state) => ({
            documents: state.documents.map((doc) => {
              if (doc.id === documentId) {
                return {
                  ...doc,
                  ...version.content,
                  lastModified: new Date().toISOString(),
                  versions: [
                    ...doc.versions,
                    {
                      id: doc.versions.length + 1,
                      version: `1.${doc.versions.length}`,
                      timestamp: new Date().toISOString(),
                      author: version.author,
                      changes: `Restored from version ${version.version}`
                    }
                  ]
                };
              }
              return doc;
            })
          }));
        }
      }
    }),
    {
      name: 'document-storage',
      version: 1,
    }
  )
);

export default useDocumentStore; 