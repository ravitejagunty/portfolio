import React, { useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';

const Home = React.lazy(() => import('mfe_home/HomeApp'));
const Projects = React.lazy(() => import('mfe_projects/ProjectsApp'));
const About = React.lazy(() => import('mfe_about/AboutApp'));
const Contact = React.lazy(() => import('mfe_contact/ContactApp'));

export default function App() {

function RedirectToAngular() {
    useEffect(() => {
      window.location.href = 'http://localhost:3003';
    }
    , []);
    return <p>Redirecting to Blogs...</p>;
}
  return (
    <Router>
      <div className="min-h-screen bg-gray-100 text-center">
        <nav className="bg-white shadow p-4 flex justify-center gap-4">
          <Link to="/" className="text-blue-600 hover:underline">Home</Link>
            <Link to="/projects" className="text-blue-600 hover:underline">Projects</Link>
          <Link to="/about" className="text-blue-600 hover:underline">About</Link>
          <Link to="/blogs" className="text-blue-600 hover:underline">Blogs</Link>
          <Link to="/contact" className="text-blue-600 hover:underline">Contact</Link>
        </nav>

        <div className="p-8">
          <React.Suspense fallback={<p>Loading...</p>}>
            <Routes>
              <Route path="/" element={<Home />} />
              <Route path="/projects" element={<Projects />} />
              <Route path="/about" element={<About />} />
              <Route path="/blogs" element={<RedirectToAngular />} />
              <Route path="/contact" element={<Contact />} />
            </Routes>
          </React.Suspense>
        </div>
      </div>
    </Router>
  );
}