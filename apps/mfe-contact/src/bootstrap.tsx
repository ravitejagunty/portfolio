import React from 'react';
import ReactDOM from 'react-dom/client';
import ContactApp from './ContactApp';
import './styles.css';

const container = document.getElementById('root');
const root = ReactDOM.createRoot(container!);
root.render(<ContactApp />);