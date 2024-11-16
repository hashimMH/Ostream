import axios from 'axios';

const api = axios.create({
  baseURL: process.env.REACT_APP_API_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

api.interceptors.request.use((config) => {
  const token = localStorage.getItem('authToken');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

export const documentApi = {
  getAll: () => api.get('/documents'),
  getById: (id) => api.get(`/documents/${id}`),
  create: (data) => api.post('/documents', data),
  update: (id, data) => api.put(`/documents/${id}`, data),
  delete: (id) => api.delete(`/documents/${id}`),
  getVersions: (id) => api.get(`/documents/${id}/versions`),
  share: (id, departments) => api.post(`/documents/${id}/share`, { departments }),
  comment: (id, comment) => api.post(`/documents/${id}/comments`, comment),
};

export const analyticsApi = {
  getDepartmentStats: () => api.get('/analytics/departments'),
  getMonthlyActivity: () => api.get('/analytics/monthly'),
  getUserActivity: () => api.get('/analytics/users'),
};

export default api;
